# 众筹合约

## 1 简介

​        在下面的例子中，我们将使用合约进行一次众筹。合约创建者发起众筹，并初始化众筹的代币数量及众筹持序的时间。如果在指定时间内众筹完成则此次众筹成功。并关闭众筹开头，根据一个固定兑换比率得到的一定数量的token会被铸造出来，并且会被计入在买方名下。否则众筹失败，把众筹的金额返还给投资者。

在合约中设置了两个角色

- 众筹者
- 投资者

## 2  众筹的流程

- 1.创建众筹合约指受益人
- 2.部署合约初始化众筹代币数量及持续时间
- 3.投资者进行投资
- 4.判断众筹是否结束
-  如果众筹时间未到，众筹代币数量已完成，关闭众筹开头。给投资者按比例分配token。众筹成功
-  如果众筹时间已到，众筹代币数量已完成，给投资者按比例分配token。众筹成功
-  如果众筹时间已到，众筹代币数量未完成，反还投资者代币。众筹失败

## 3 众筹合约

```
pragma solidity ^0.5.13;

contract CrowdFunding {
    address payable public beneficiaryAddress = address(0x0); //受益人地址，设置为合约创建者
    uint256 public fundingGoal = 100 lat;  //众筹目标，单位是lat
    uint256 public amountRaised = 0; //已筹集金额数量， 单位是von
    uint256 public deadline; //截止时间
    uint256 public price;  //代币价格
    bool public fundingGoalReached = false;  //达成众筹目标
    bool public crowdsaleClosed = false; //众筹关闭

    mapping(address => uint256) public balance; //保存众筹者对捐赈的金额
    
    mapping(address => uint256) public tokenMap; //保存众筹者所拥有的代币数量

    //记录已接收的lat通知
    event GoalReached(address _beneficiaryAddress, uint _amountRaised);

    //转帐通知
    event FundTransfer(address _backer, uint _amount, bool _isContribution);
    
    //校验地址是否为空
    modifier validAddress(address _address) {
        require(_address != address(0x0));
        _;
    }

    /**
     * 初始化构造函数
     *
     * @param _fundingGoalInlats 众筹lat币总量
     * @param _durationInMinutes 众筹截止,单位是分钟
     */
    constructor (
        uint _fundingGoalInlats,
        uint _durationInMinutes
    )public {
	    beneficiaryAddress = msg.sender;
        fundingGoal = _fundingGoalInlats * 1 lat;
        deadline = now + _durationInMinutes * 1 minutes;
        price = 500 finney; //1个lat币可以买 2 个代币
    }


    /**
     * 默认函数
     *
     * 默认函数，可以向合约直接打款
     */
    function () payable external {

        //判断是否关闭众筹
        require(!crowdsaleClosed);
        uint amount = msg.value;

        //捐款人的金额累加
        balance[msg.sender] += amount;

        //捐款总额累加
        amountRaised += amount;

        //转帐操作，转多少代币给捐款人
        tokenMap[msg.sender]  += amount / price;
        
        emit FundTransfer(msg.sender, amount, true);
    }

    /**
     * 判断是否已经过了众筹截止限期
     */
    modifier afterDeadline() { if (now >= deadline) _; }

    /**
     * 检测众筹目标是否已经达到
     */
    function checkGoalReached() public afterDeadline payable{
        if (amountRaised >= fundingGoal){
            //达成众筹目标
            fundingGoalReached = true;
            emit GoalReached(beneficiaryAddress, amountRaised);
        }

        //关闭众筹
        crowdsaleClosed = true;
    }


    /**
     * 收回资金
     *
     * 检查是否达到了目标或时间限制，如果有，并且达到了资金目标，
     * 将全部金额发送给受益人。如果没有达到目标，每个贡献者都可以退回
     * 他们贡献的金额
     */
    function safeWithdrawal() public afterDeadline {

        //如果没有达成众筹目标
        if (!fundingGoalReached) {
            //获取合约调用者已捐款余额
            uint amount = balance[msg.sender];

            if (amount > 0) {
                //返回合约发起者所有余额
                msg.sender.transfer(amount);
                emit FundTransfer(msg.sender, amount, false);
                balance[msg.sender] = 0;
            }
        }

        //如果达成众筹目标，并且合约调用者是受益人
        if (fundingGoalReached && beneficiaryAddress == msg.sender) {

            //将所有捐款从合约中给受益人
            beneficiaryAddress.transfer(amountRaised);

            emit FundTransfer(beneficiaryAddress, amountRaised, false);
        }
    }
}
```

**编译众筹合约：**

>juzix@juzix:~/example$ truffle compile
>
>Compiling your contracts...
===========================
> Compiling ./contracts/CrowdFunding.sol
>
    > compilation warnings encountered:
>
>Warning: This is a pre-release compiler version, please do not use it in production.
>
> Artifacts written to /home/juzix/example/build/contracts
> Compiled successfully using:
>    solc: 0.5.13-develop.2020.1.2+commit.9ff23752.mod.Emscripten.clang

**部署众筹合约：**
>juzix@juzix:~/example$ truffle migrate
>
>Compiling your contracts...
> Everything is up to date, there is nothing to compile.
> 3_initial_CrowdFunding.js
> 
>    Deploying 'CrowdFunding'
>     transaction hash:    0x3a6419cd4169d7cfb430a1fc5632239ac4a01845827f20df9b3229a334c5488b
>     Blocks: 0            Seconds: 0
>     contract address:    0x02D04C6fD2b0C07c43AA1a329D667f1F1Fc7a907
>     block number:        280532
>     block timestamp:     1581751224032
>     account:             0xF644CfC3b0Dc588116D6621211a82C1Ef9c62E9e
>     balance:             90000000.806077629992489796
>     gas used:            379154
>     gas price:           50.000000004 gwei
>     value sent:          0 ETH
>     total cost:          0.018957700001516616 ETH
> 
> 
>     Saving migration to chain.
>     Saving artifacts
>     Total cost:     0.018957700001516616 ETH
> 
> 
> Summary
>  Total deployments:   1
>  Final cost:          0.018957700001516616 ETH


**众筹者查询众筹情况：**
> truffle(development)> crowdFunding.methods.amountRaised().call(null,function(error,result){console.log("result:" + result);})
> result:0


**众筹者判断众筹是否成功：**
> truffle(development)> crowdFunding.methods.safeWithdrawal().send({from:'0xf644cfc3b0dc588116d6621211a82c1ef9c62e9e'}).on('data', function(event){ console.log(event);}).on('error', console.error); 

