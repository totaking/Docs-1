
## Public Blockchain design principles

One of the core problems of economics research is the rational allocation of scarce resources. The public blockchain is an open, free, and distributed system that everyone can participate in. A well-designed economic model can ensure the reasonable allocation of public blockchain resources on the premise of maximizing the interests of participants, and at the same time align the interests of each participant with the overall interests of the public blockchain, so that it can pursue its own economic interests while also Can contribute to the entire blockchain network and ensure that the network can develop steadily for a long time.

Specifically, the economic design of the public blockchain needs to consider the following issues:

### Distributed economy and infrastructure payment problem

The core of a distributed economy is the production and distribution of scarce resources, and the allocation of scarce resources is carried out through market mechanisms rather than centralized methods. The distributed economy is autonomous by the community, and the infrastructure of economic activities is jointly built and shared by the community.

In a distributed economy related to the public blockchain, the most important infrastructure is a distributed ledger (which can be called a distributed trust infrastructure). Miner is a core member of the distributed economy, maintaining distributed ledgers, and needs to bear certain costs and risks. PoW miners need to bear high hardware investment and electricity costs. PoS miners need to lock a certain number of tokens and bear the liquidity cost of the token and the cost of wallet security risks.

To motivate miners to maintain distributed ledgers, they must compensate for the costs and risks they bear. The issue of incentives for miners is essentially how to pay for infrastructure. The common practice is "who uses who pays", and this solution faces the following three problems:

First, this type of income depends on the activeness of transactions within the public blockchain, which is unstable and difficult to predict accurately for miners.

Second, is this type of revenue sufficient to cover the costs and risks borne by miners? This has plagued the Bitcoin community for quite some time.

Third, the issue of fairness. Many long-term holders of tokens rarely initiate transactions within the public chain, and therefore rarely pay fees to miners. But the value of their token holdings still depends on the distributed ledger security provided by the miners.

Block rewards help alleviate these three problems faced by "who uses and pays," especially in the early stages of public blockchain development.

### Token value, block rewards and inflation tax

There is a key difference between block rewards and "who uses who pays." "Who uses who pays" is the redistribution of the issued token between the transaction initiator and the miner, and the block reward is the newly issued token obtained by the miner.

The core issue in the economics of block rewards is the relationship between Token issuance and Token value.

Token value is affected by fundamentals and liquidity factors. In the long run, the value of Token is mainly determined by the fundamentals. In the short term, liquidity factors have a strong driving force for token value. Assuming that there are no significant changes in the fundamentals and liquidity factors, the newly issued Token will dilute the value of the original Token, and the dilution of the original Token value by the Token issuance can be called inflation tax.

Compared with "who uses who pays", inflation tax is a more stable source of income for miners, and those who hold tokens for a long time also pay miners by sharing inflation tax. If the group of miners is regarded as a new token holder, the Token Offering is essentially a transfer of wealth from the original token holder to the new token holder. Therefore, in the short term, the issuance of tokens is mainly a redistribution of wealth; in the long term, the interests of new and old token holders are tied to the rise in the value of the token.

### Trust basis, consensus algorithm and consensus cost

The core of the public blockchain is the consensus algorithm, which has two key points:

First, additional tokens are issued;

The second is the distribution of accounting rights in the distributed ledger.

If the token issuance is mainly to reward the contribution of miners to maintain distributed ledgers, then the allocation of accounting rights is mainly to prevent malicious miners from damaging the distributed ledgers. We give an economic analysis framework for consensus algorithms from the perspective of trust.

#### PoW—Technology-based trust

In PoW, miners do not need to hold tokens to participate in the consensus algorithm. PoW mining is completely random. The greater the computing power controlled by the miner, the greater the probability of obtaining accounting rights.

In PoW, there is a competitive relationship between miners, and there is no interactive communication and collaboration. Whoever finds the random number Nonce first will get the right of bookkeeping and block reward, while other miners' previous work is basically void.

The openness of mining and the competitive relationship between miners make mining costs rise when the price of Token rises. Once a miner invests in computing power, while increasing his own mining success probability, it also reduces the mining success probability of other miners. Therefore, the investment of one miner in computing power will have a negative externality to other miners. As a result, miners entered an "arms race".

In general, PoW reflects technology-based trust. It mainly relies on technology to create an environment that does not depend on the identity or credit of miners outside the chain. Miners are in a competitive relationship, but it is difficult to endogenously suppress computing power. Contest "raises the cost of mining.

#### PoS—Institution-based trust

In PoS, miners need to hold tokens to participate in consensus algorithms, so there is risk exposure to PoS-type public blockchains, but the hardware facilities they face are much lower than PoW. The size of the risk exposure depends on whether the miner needs to lock the token.

Locking a token is to temporarily give up the right to sell tokens based on market conditions, that is, to temporarily give up token liquidity. The cost of abandoning token liquidity is positively related to the number and time of locked tokens, and more related to the strategy of holding tokens.

PoS miners have two significant features. First, the miner's off-chain identity and credit are important, and miners need to "cancel votes" from their supporters. The miners' past performance, such as the rate of block production and the generosity of reward sharing, will directly affect their credit and “get votes”. The evil miners were elected in the election. Second, there is a certain cooperative relationship between different miners. Miners can produce blocks in a sequential or VRF manner, but eventually all miners run a Byzantine agreement on candidate blocks until a consensus is reached.

In general, PoS reflects trust in the system. Institutions are rules of conduct introduced for group members in order to improve the efficiency of group cooperation. The off-chain identity and credit of miners, the miner election process, and the cooperative relationship between miners in block production and reaching consensus are all examples of the system.

#### Consensus cost

Regardless of PoW or PoS, the goal of the consensus algorithm is in distributed networks with various errors, malicious attacks, and asynchronous, and without central coordination, to ensure that the distributed ledger will "Eventual consistency".There is no doubt that there is a cost to reaching this state of consensus, which we call "**consensus cost**".

In PoW, the consensus cost is mainly reflected in the mining cost, that is, the investment in mining hardware facilities and the energy consumed by running these hardware facilities, which can be called "technical costs". It is difficult for PoW to endogenously suppress the increase in technological costs caused by the "arms race".

In PoS, although the various systems in PoS can improve the efficiency of group cooperation, the continuous, effective and stable operation of the system is not easy. PoS relies on off-chain identity and credit mechanisms and procedural arrangements for group interaction. The design of these mechanisms has a complex impact on the consensus cost of PoS and can be called "institutional costs."

Each consensus algorithm relies on technology-based trust and institution-based trust to varying degrees, and therefore incurs technical and institutional costs, respectively. Consensus cost is the sum of technical and institutional costs. The greater the dependence on technology-based trust, the higher the cost of technology, and vice versa. This relationship is also true of institutional-based trust and institutional costs. Relying entirely on technology-based trust, or relying entirely on system-based trust, will result in relatively high consensus costs. We believe that **there is an optimal ratio between the two trust bases that minimizes the cost of consensus** (Figure 1).


![Consensus cost](PlatON_economic_plan.assets/共识成本.png)

<center>Figure 1 Consensus cost</center>


## PlatON's economic design goals

Based on the previous analysis, PlatON's economic design has the following goals:

First, choose PoS. We believe that PoW's energy consumption is too high. Faced with real-world energy constraints, PoW's market share cannot grow indefinitely. PlatON's consensus algorithm is called PPoS (PlatON PoS).

Second, reduce consensus costs. PPoS uses off-chain identity and credit mechanisms and programmatic arrangements, but reduces the reliance on them through the randomness introduced by VRF. This can effectively suppress bribery and collusion.

Third, strengthen the coupling relationship between the economic activities in the public blockchains and the economic activities supported by the public blockchain (that is, data and computing power circulation markets) to provide support for the value of the token.

Fourth, endogenously inhibit the expansion of the PPoS mining pool.

## PlatON's economic solution

### The business cycle in PlatON

![economic cycle](PlatON_economic_plan.assets/economic_cycle.png)

Before introducing PlatON's economic plan, in order to facilitate subsequent understanding, first introduce several basic economic cycles in the PlatON economic model:

- Additional period	

  PlatON is designed to issue additional shares every year. This additional period is not a natural time cycle in PlatON, but a block height cycle. Based on 365.25 days a year, it is based on the average block production time within a period of time (the time range is based on the current block). The previous year), calculate the number of blocks in the current additional period. In order to make the additional issue logic always be processed in the settlement block, the additional issue period is designed to be a multiple of the settlement period when designing, so the additional issue block is also a settlement block. Due to the uncertainty of the average block production time, the number of settlement cycles in the issuance cycle will be dynamically adjusted.

- Epoch

  In PlatON, considering the system processing performance, the logics such as lock-up processing, pledge lock, Staking reward issuance, additional issuance, and node ranking are processed periodically and centrally. This cycle is called the Epoch. The last block of the Epoch is called the settlement block, which handles various periodic processing logic in a unified manner. The Epoch is a multiple of the consensus cycle and is fixed at 10750 blocks.

- Round

  Each consensus Round produces 250 blocks, of which the 230th block is an election block, used to select 25 verification nodes for the next consensus Round.

### Published by Energon

The token in the PlatON public blockchain is called Energon. Energon does not have a hard cap, and is divided into initial issuance and additional issuance.

#### Initial release

Energon's initial issuance is distributed to the founding team, PlatON Foundation, academic fund, ecological fund, and private equity issuers in a certain proportion. This is achieved by writing the allocated account and balance parameter information into the genesis block configuration. And introduce the corresponding locking mechanism.

The initial issuance of locks is controlled through the restricting contract, and the lock-up and unlocking are performed according to the set restricting period. The amount of the restricted Token	 cannot be unlocked in advance. In order to improve the processing performance of the system, the locking period must be a multiple of the Epoch (10750blocks). Therefore, the unlocking point (unlocking block height) of each locking period is the Epoch block (the last block of the Epoch).

In order to protect the equity of the restricting account, the restricting Energon can be used to verify the pledge and delegate of the node. When the pledge or delegate is released, the pledged and delegate Energon returns to the restricting contract.

According to the restricting plan, when the unlocked block is reached, the restricting contract automatically unlocks the corresponding Energon to the restricting account address.

Assume that the account A's restricting plan is (a total of 1000Energon):

- Locked for 1 Epoch, locked quantity: 100Energon

- Locked for 2 Epoch, locked quantity: 300Energon

- Locked for 3 Epoch, locked quantity: 600Energon

The unlocking process flow is shown in the following figure:

![unlock the restricting normally LAT](PlatON_economic_plan.assets/unlock_the_restricting_normally.png)


Due to the existence of the locked Energon for pledge or delegate, and the pledge or delegate was returned without expiry, the unlocked block was reached. The account balance in the restricting contract was not enough to unlock the amount. At this time, the processing method is to fully unlock and record A "number of accounts owed", and check whether there is "number of accounts owed" in each settlement block, and whether the locked balance of the account in the restricting contract is recorded, and if necessary, continue to unlock until the "account owed" returns zero.

At the same time, it should be pointed out that when restricting Energon is used to verify the node pledge, and the Energon pledged is reduced by penalties, the system will feed back the restricting contract, and deduct the corresponding amount of "locked to be unlocked".

#### Energon issue

The additional issue is mainly to motivate miners to maintain distributed ledgers. In the case that pure transaction fees cannot be met as incentives for miners, the additional block issuance will compensate them for the costs and risks. At the same time, the continuous issuance can dilute the holder's Token, thereby promoting more people to participate in PoS consensus verification and ensuring a more stable network.

There are usually two ways to issue additional shares:

- Batch issuance: Periodically issue additional batches, each batch issuing a certain percentage. Such as Cosmos issue method.
- Continuous issuance: irregular issuance can be understood as shortening the batch of batch issuance mode to a very small value. Such as the EOS issue.

PlatON adopts the batch issuance mode, that is, one issuance per year (one additional period). Compared to continuous issuance, batch issuance is simpler and more practical, and can improve the performance of the chain.

According to the annual expected number of blocks for the additional period, Energon issuance. **Compared to Energon's total issuance at the end of the previous year**, **a fixed additional 2.5% issuance per year**. Additional issuances are made in the additional issuance block (the last block in the last additional period), and 2% of the additional issuance is transferred to the reward pool controlled by smart contracts. , And the reward is given to the validator	 by the running of the PPoS consensus algorithm. The remaining 0.5% is transferred to a trust fund, which is used by the PlatON Foundation as a trustee to reward future developers of the PlatON basic agreement.

![additional period](PlatON_economic_plan.assets/additional_period.png)

Therefore, the current additional period	 of Energon can be expressed as:

$$f(x)=W\times(1+a\%)^{x-1}\times a\%$$

among them:

$x$: The number of the current additional period is from the genesis block to the current number of additional periods (the genesis block begin from first year, the additional period is 1).


$W$: The total amount of Energon in the initial issuance and circulation is the base of the additional issue in the first year of the genesis block.

$a\%$ : The issuance ratio is fixed at a fixed issuance period.

The additional Energon issued by the reward pool will be used for validator block rewards and Staking rewards. The details will be detailed in the incentive mechanism section.


### PPoS consensus

PlatON adopts randomly selected nodes among the small-scale candidate nodes to participate in the BFT consensus, and makes a trade-off between the number of verified nodes and performance. Any Energon holder can pledge to participate in the validator (alternative validator candidate	), other Energon holders continue to vote through delegation, thereby maintaining a small-scale dynamic alternative validator candidate (alternative node) list, and then In this candidate list, several validators are randomly selected for block generation and verification through VRF and probability distribution. The characteristics of VRF ensure the randomness of the selection, thereby reducing the probability of attacking the validator, and increasing the degree of decentralization. The probability distribution can make the candidate nodes with high equity be selected with a higher probability, thereby motivating the candidate nodes to find ways to increase their equity. As the number of Energon pledged by the entire system increases, the security of the entire system will be higher. . In this way, the selection range of validators is narrowed, thereby ensuring consensus efficiency and effectively avoiding the problem of too centralization.

#### Role description

- Alternative Validator Candidate	

  Energon holders who want to participate in the production of the PlatON block, pledge to lock a certain number of Energon into the staking contract and become alternative validator candidate	.

- Alternative Validator

  Ranking (see [Alternative Node Selection] (#Alternative-Validator-selection) for the ranking rules) Alternative Validator Candidates in the top 101 are called Alternative Validator. The Alternative Validators participate in the Validator election for each consensus round to obtain the settlement epoch Energon additional distribution bonus.

- Validator

  The system randomly selects 25 (normal state) nodes from 101 alternative validator as the consensus round validator through the VRF random function.

- Proposer

  A consensus round produces 250 (25 validator * each validator produces 10 blocks in succession) blocks, 25 validators take turns to become proposers, and each validator has a block generation time of 20 seconds.

- Delegator

  Energon owns Energon holders of alternative validator candidate. validators cannot delegate each other or self-delegate.

The role relationship diagram is as follows. **To facilitate the subsequent description,  alternative validator candidates include alternative validators and validators.alternative validators include validator.**

![角色说明](PlatON_economic_plan.assets/%E8%A7%92%E8%89%B2%E8%AF%B4%E6%98%8E.png)



#### Overview of the overall process

1. Pledged as  Alternative Validator Candidate

   Energon holders pledge more than a certain amount of Energon as a deposit to become Alternative Validator Candidate.

2. Delegate Energon

   Energon holders can entrust their Energon to Alternative Validator Candidate, where Alternative Validator and Validators can obtain benefits in participating in the consensus process, and the benefits can be shared with the principal based on the commissioning reward ratio set by the nodes. The principal can redeem the entrustment in part or in full at any time without additional freeze periods.

3. Election of Alternative Validator

   For the last block of each settlement epoch (that is, the settlement block), the system takes the top 101 nodes as alternative validators for the next  epoch according to the current alternative validator candidate ranking and participates in the consensus of the next settlement round. alternative validators can get Staking rewards.

4. Election  Validators

   Each round of consensus requires 25 validators. The system will use VRF to randomly select 25 validators from the current alternative validators to participate in the next round of consensus.

5. Consensus block

   The validators take turns to become the proposer to produce blocks, other validators perform block verification, and jointly run the CBFT protocol to complete a round of consensus (a total of 250 blocks per round), and the block producing nodes receive transaction fees and block rewards.

6. Exit Alternative Validator Candidate

   Obtain a new ranking in the settlement block of the epoch. The nodes after the 101st ranking become  alternative validator candidates and no longer get Staking rewards. In cases where multiple reports are reported and the report is true or the consensus round-off block rate is 0, the node will be immediately eliminated from the Alternative Validator Candidate list.

#### Election of Validator

##### Pledged as Alternative Validator Candidate

Any Energon holder can pledge a certain amount of Energon (must exceed a predetermined minimum amount) as a deposit to become Alternative Validator Candidate
s, and the total number of Alternative Validator Candidates is unlimited. Energon can be pledged from two sources:

(1) Energon of account balance: refers to the balance of the account, which is the Energon circulated in the account and can be used at any time.

(2) Energon of account lockout: refers to the part of Energon that is not unlocked when the account is locked in the restricting contract.

To become a  Alternative Validator Candidate, you also need to submit the true version number of the node program, the signature of the real version number of the node program, the public key of the BLS, the Proof of the public key of the BLS, and a revenue account for receiving block rewards and Staking rewards (follow-up) Support for modification), the percentage of rewards (including support for block production and staking rewards) allocated by the node to the client (subsequent support modification), description of the node (subsequent support modification), the node's official homepage (subsequent support modification), Node's third-party information disclosure ID (optional, [keybase.io] (keybase.io) 16-bit characters generated by the account-support for subsequent amendments), name of the node being pledged (subsequent support for modification), node ID of the pledged And the number of Energon pledged. The pledge needs to comply with the following rules:

- Nodes cannot be repeatedly staking.

- The system will initiate a period from the staking transaction block to the settlement block of the current epoch as a hesitation period. During the hesitation period, the system will initiate a revocation, and the node will immediately exit the  Alternative Validator Candidate list.

  ![staking hesitation period](PlatON_economic_plan.assets/staking_hesitation_period.png)

- When the node's version number is lower than the current chain version number or the pre-validated version number, the staking fails.

- Once the node is successfully pledged as a Alternative Validator Candidate, the account used for the staking will correspond to the node ID one by one, and subsequent related operations need to use the staking account to initiate signed transactions. Please pay attention to the safe storage of the staking account.

Alternative Validator Candidate can accept delegation. In the settlement block of the current epoch, if it ranks 101st according to the current total staking amount (the sum of self-pledged and delegate quantities), it can be elected as an alternative validatorfor the next epoch.

##### Increase staking

All Alternative Validator Candidate can increase the number of staking Energon at any time, thereby improving the ranking of alternative validator candidates.

- If the pledge is being cancelled or punished, the pledge cancellation is being processed (the return of the pledged Energon requires a period of freezing) or completed (the pledged Energon has been released to the original staking account), the pledge cannot be increased.

- The Energon used to increase the pledge can be the Energon of the account balance or the Energon of the restricting account .

- Pledge can only be increased from the initial staking account.

##### <span id="ElectionAlternativeValidators">Alternative Validator selection</span>

The total number of  alternative validators is at most 101, and the last block (settlement block) of each epoch will be re-selected.

![election of validators](PlatON_economic_plan.assets/election_of_validators.png)

The selection rules are based on the top 101 nodes, and the ranking rules are as follows:

1. First, sort from highest to lowest version of the running system.
2. Then sort according to the total staking amount (the sum of self-staking and delegate amount) from high to low.
3. If the total staking amount (equity) is equal, then the initial staking block height is ranked, and the smaller staking block height is preferred.
4. If the initial staking block is the same, then rank according to the serial number of the transaction in the same block at the time of the staking, with the smaller serial number first.

##### Validator selection

Each consensus round is responsible for the production of 250 blocks. In the 230th block of the consensus round, the next round of consensus round validator is elected from 101 alternative validators. The first consensus  round validator is in the genesis block Built-in.

In order to prevent the newly selected validators from affecting the efficiency of the consensus due to slow network connections and out-of-synchronization of blocks, to ensure the fault tolerance of the consensus, not all of the 25 nodes are replaced at a time, and only some of the verification nodes are replaced.

  - Eliminate some validators from the 25 validators in the current consensus round

  - Priority elimination of validators with abnormal status (assuming the number is $F_1$) must be eliminated, including those that are reported to be double-signature verification, whose block rate is 0, and whose version is lower than the pre-validated version (if the voting for the upgrade proposal is successful, The version number in the upgrade proposal is a pre-validated version, and for details refer to the PlatON governance plan), the application is withdrawn and is not on the Alternative Validator  list.

  - Then eliminate some normal validators. Assuming that the remaining number of candidate nodes is $L$ and $u$ is the total number of validators per round, the number of eliminated normal validators $F_2$ is calculated as follows:

    $$R=(u-1)/3$$

    $$F_2^{'}=IF(F_1>=R, 0, R-F_1)$$

    $$F_2=IF(F_2^{'}>L, L, F_2^{'})$$

  - The eliminated normal validators are sorted according to the following rules and the first $F_2$ are selected: the term (the number of consecutive participation in the consensus round) is from long to short, the total staking amount is from small to large, and the initial staking block height is from high Low, the transaction serial number of the staking transaction in the same block is from large to small.

- From the list of alternative validators, select $F=F_1 + F_2$ new verification nodes through VRF. If the number of candidate nodes is insufficient, select all.

  In order to ensure sufficient randomness and reduce the attack of the attacker, the pseudo-random seed generation rules of the algorithm are selected as follows:

  - Each candidate node generates a public-private key pair $(pk, sk)$ locally. The private key is stored locally to generate random numbers, and the public key is publicly used to verify the random numbers.
  
  - The genesis block generates a random number as the initial pseudo-random seed $r_0$.
  
  - Assume that the current block is the $i-1$ block, and the random seed parameter generated by the Xth block is $r_{i-1}$, which is responsible for producing the public and private key pair $(pk,sk)$ of the verification node of the current block. The current verification node uses the following VRF to produce the random number seed $r_i$ of the $i$ block:
  
    $$\pi_i=SIG_{sk}(r_{i-1}), r_i=H(\pi)$$                                                                            (1)
  
    Where $SIG_sk(r_{i-1})$ means sign the current random seed parameter $r_{i-1}$ with the private key $sk$, and $H(\cdot)$ is a hash function. For any input, $H(\cdot)$ outputs a binary number of $l$ in length. The hash function $H(\cdot)$ determines the nature of the random prediction. $r_i$ is evenly distributed between $[0, 2^l-1]$, so $\frac{r_i}{2^l-1}$ obeys the even distribution between $[0,1]$.
  
  - The initial designated verification node in the genesis block is responsible for packaging all the blocks in the first round and generating a random seed in each block. Calculated by VRF function.
  
  The proposer of the 230th block of each round is responsible for selecting the verification node for the next consensus round. Assuming the current $n$ block, the selection rules are as follows:
  
  - The block proposer generates a random seed of the current block and its proof based on the random seed of the previous block $(r_i, \pi_i)$ 
  
  - Consider a candidate node. Assume that the ranking is $i$ and there are $w_i$ votes. The total number of votes for all candidate nodes is $W=\sum_{k=1}^{101}w_k$, choose a positive The integer $m<W$,  so  $p=\frac{m}{W}$.For this node, finding $X$ makes
  
    $$\sum_{k=0}^XB(k,w_i,p)\leq\frac{r_i}{2^l-1}<\sum_{k=0}^{X+1}B(k,w_i,p)$$                                               (2)
  
    Where $B(k,n,p)$ is a probability density function of the binomial distribution $B(n,p)$, and $F(x)=\sum_{k=0}^xB(k,n,p)$ is its cumulative probability distribution function.
  
    Therefore, formula (2) can be equivalently expressed as $F(X)=\frac{r_i}{2^l-1}$, so
  
    $$X=F^{-1}(\frac{r_i}{2^l-1})$$                                                                                                     (3)
  
    Because $\frac{r_i}{2^l-1}$ obeys the distribution between $[0,1]$, X obeys the binomial distribution $B(n,p)$, and
  
    $$E(X)=np$$                                                                                                             (4)
  
    Because the current random seed parameters and public key are public, participants in the PPoS consensus algorithm can easily verify $(r_i, \pi_i)$ and calculate their $X$ value based on the number of votes received by the candidate nodes.
  
  - The $X$ value of all candidate nodes is calculated, and the candidate node corresponding to the highest $F$ $X$ value becomes the verification node. The higher the value of $X$ obtained by VRF, the more likely it is to be selected as a verification node. However, due to the randomness introduced by VRF, the finally selected $F$ verification nodes may not be exactly the $F$ candidate nodes with the highest votes.
  

##### Exit Alternative Validator Candidate

Alternative Validator Candidates can apply for withdrawal voluntarily, and validators can be punished or forced to quit. In order to maintain the security of the entire network, after the execution of the exit command, the staking Energon requires a long freeze period before it can be actually received. The freeze period allows malicious attacks to be detected even after they are formed and still be punished.

**Application process for withdrawal from validator:**

![exit the validator process](PlatON_economic_plan.assets/exit_the_validator_process.png)

(1) Starting from the block applying to withdraw from the verification node, the node is immediately removed from the candidate list of candidate nodes, and the node will not be able to receive commissions and increase pledge deposits. If the node is a candidate node for the current settlement cycle, the node can continue to participate in the election of the VRF consensus round to verify the node, and at the same time can obtain Staking rewards in the settlement block.



![apply for withdrawal](PlatON_economic_plan.assets/apply_for_withdrawal.png)

(2) When the alternative validator in the current epoch is withdrawn by the system or the minimum staking threshold required by the alternative validator candidate is not met after deducting the node's own deposit, the penalty block will move the node out of the alternative validator in the current settlement cycle in real time List and  alternative validator candidate  list. Nodes no longer continue to participate in the VRF consensus round to verify node elections. There is no Staking reward for this node in the current epoch.

![system penalty exit](PlatON_economic_plan.assets/system_penalty_exit.png)

(3) After the execution of the exit validator command, the node's own staking Energon returned to the staking account time:

- Energon, which has not been locked in the hesitation period, will be credited immediately after the execution of the exit order.

- Locked staking Energon, after exiting the execution of the order, continue to freeze and lock 28 epochs (excluding the current epoch)

  ![exit freeze lock period](PlatON_economic_plan.assets/exit_freeze_lock_period.png)


>[!NOTE|style:flat|label:notice]
>
>If the current node participates in the upgrade proposal voting and the proposal does not end voting, you need to determine whether the thawed block is greater than the voting deadline block. If it is greater, continue to pledge <font color=red>Energon</font> release according to the default thawed block. If it is smaller, the pledged <font color=red>Energon</font> is released according to the voting deadline block. The returned pledge <font color=red>Energon</font> returned the same way.

(4) The alternative validator candidate withdraws, and Energon entrusts the processing instructions:

- The alternative validator candidates  take the initiative to apply. In the settlement block of the current epoch, all delegated Energon received by the node are unlocked, and the principal needs to actively apply for redemption. After submitting the redemption, the delegated Energon will immediately return to the principal's account .

  ![voluntary withdrawal from delegate](PlatON_economic_plan.assets/voluntary_withdrawal_from_delegate.png)

- The alternative validator candidates withdraw from passive penalties. Starting from the penalty block, all delegated Energons received by the nodes are unlocked, and the principal needs to actively apply for redemption. After submitting the redemption, the delegated Energon is immediately returned to the principal's account.

  ![system punishment withdraw from delegate](PlatON_economic_plan.assets/system_punishment_withdraw_from_delegate.png)


(5) The withdrawal application must be initiated by the node's original staking account.



#### Delegator

##### Delegate

Energon holders can earn profits by entrusting Energon in their hands to alternative validator candidates.

- Energon delegated from two sources:

    (1)  Energon of account balance: refers to the balance of the account, which is the Energon circulating in the account and can be used at any time.

    (2) Energon for account lockout: refers to the part of the account where the account is locked in the restricting contract.

- To prevent malicious delegation attacks, there is a minimum Energon limit for a single delegation.
- Energon commissioned enters the next epoch and starts to lock. Energon commissioned does not actively redeem. Energon commissioned will continue to be locked. The system does not support the automatic redemption function. At the same time, only when a complete epoch is locked will it participate in sharing node revenue.

- Once the alternative validator candidate applies for withdrawal or is withdrawn by the system, he cannot continue to delegate. The original entrusted Energon will be unlocked, and users need to actively redeem the entrusted Energon.

##### Delegated award

Based on the PPoS consensus, the client entrusts Energon to the alternative validator candidates, which affects the ranking of alternative validator candidates. The alternative validator candidates ranked in the top 101 can become alternative validators for each epoch and get Staking Reward, at the same time have the opportunity to become a validator, participate in the block production and get block rewards and transaction fee rewards in the block. The principal is an important factor in maintaining thealternative validator ranking of the alternative validator. In order to improve the ranking and attract the principal to commission, the alternative validator candidates needs to generously assign the commission reward to the principal who is given the system reward. The percentage of rewards specifically allocated to the client is submitted by the node in the stage of pledge to become a alternative validator candidate.

- Delegated rewards come from two sources:

   (1) Block rewards based on the proportion of delegated rewards: The alternative validator candidate commissioned by the commission becomes the validator and participates in the block rewards. Share the block reward to the client under the node's name in accordance with the node's delegated reward ratio.

  (2)  Staking reward sharing based on delegated reward ratio: The alternative validator candidate who is delegated becomes the alternative validator, gets Staking reward in the settlement block, and shares the Staking reward to the trustee under the name of the node according to the delegated reward ratio of the node.

- Delegated rewards follow the rules：

  - Delegated reward settlement interval: Delegated rewards are settled every settlement interval.

  - Scope of Delegated rewards: Delegated rewards can only be granted to delegated (valid delegated) for a complete epoch. There are no delegated rewards for any locked-out, un-locked, and node-unlocked withdrawals.

  - Assignment of Delegated rewards: The Delegated rewards are shared according to the effective Delegation ratio between the clients under the node name. The more effective delegations, the more delegated rewards.

  - Delegated reward collection: Requires the client to initiate a collection transaction actively. The collection transaction can receive all the delegated rewards under all the delegated nodes at one time. At the same time, if all the delegated of a certain node are redeemed, all delegated rewards that can be received under a certain node will be automatically collected.

  - In the following cases, the nodes will not share the delegated reward in this epoch:

      (1) There is no valid delegation under the node name during a settlement period.

   

     (2) Within a certain settlement period, the node is punished and forced to withdraw from the  alternative validator candidate list.

     (3) After the node applies to withdraw from the alternative validator candidate, it will not share the delegated reward in the next epoch of the current epoch.

##### Receive delegated award

After delegating Energon to a alternative validator candidate, the delegated Energon will generate entrusted rewards when the delegating nodes generate revenue (get block rewards and Staking rewards) and entrust Energon to lock the complete epoch. The client can submit the delegated reward transaction at any time.

- Receive delegated rewards, support receiving all currently settled delegated rewards. Partial collection is not supported.

- Entrust multiple alternative validator candidates, and each time you submit an delegated reward transaction, you will automatically receive the delegated rewards generated under the names of all entrusted nodes, and all of them will be received at one time.

##### Redemption delegation

The principal can submit the redemption delegation transaction at any time, because the principal can be said to be wicked to a certain extent, so the Energon after the principal redeems the commission has no additional freezing period. At the same time, it is different from the cancellation of the pledge of the candidate who has withdrawn from the candidate node. The cancellation of the pledge is all but the redemption entrustment supports partial redemption (that is, reduction of holdings) and full redemption.

- The interval between the entrusted transaction block and the settlement block of the current epoch is a hesitation period. The delegation is redeemed, and the delegated Energon immediately returns to the user's delegated account.

- The delegated Energon will be locked in the next epoch. The locked Energon will redeem the entrustment. The energon will be returned to the user's delegated account in the settlement block of the epoch.

  ![redemption delegate](PlatON_economic_plan.assets/redemption_delegate.png)

- When the delegated Energon contains unlocked and locked Energon, the unlocked Energon will be redeemed first, and the remaining part will be redeemed from the locked Energon.

- When Energon commissioned includes Energon commissioned using account balance and Energon commissioned using account lockout balance, priority is given to redemption (reduction) of Energon commissioned using account balance. If the number of redemptions specified by the user is insufficient, the remaining part will be redeemed from Energon commissioned using the account lockout.

- In order to prevent malicious delegation attacks, a single redemption order has a minimum Energon number limit. At the same time, to prevent a large number of small orders from remaining, after the number of redemption orders, the remaining entrustment amount is less than the minimum Energon number, and all orders are automatically redeemed.

- When all the delegation of a node are redeemed, all the delegated rewards that can be collected under that node will be automatically collected.



#### Consensus

Each verification node turns into a proposer, and each proposer has a 20-second window period and can produce up to 10 blocks. That is, if 10 blocks are produced within 20 seconds, the next proposer will immediately turn out to produce blocks. If 10 blocks are not produced within 20 seconds, it is still the turn of the next proposer to produce blocks. If the round has not produced 250 blocks, the cycle will continue.

For the specific consensus scheme, see PlatON consensus scheme.

### Incentives

#### Cost analysis of validation nodes

In PlatON, the cost of maintaining a verification node includes the following:
- Equipment power
-System security maintenance
-Client Support Services
-Pledge locks liquidity costs

#### Source of Incentive Fund

Based on the PoS consensus public chain, in order to promote the maintenance of distributed ledgers by miners, to ensure that there are enough tokens to carry future strong and rich distributed ecological applications, and to promote user pledge to provide chain security, the general incentive funds for PoS blockchains are From inflation.

The sources of PlatON network incentives include the following:

- Additional system
  
  Each additional issuance cycle is fixed at 80% (equivalent to 2% of the previous year's total issuance) transferred to the reward pool. Additional issues are the main source of incentive funds.

- PlatON Foundation subsidy

  In the first 10 years (additional period), in order to encourage and attract more nodes to join, the fund is subsidized to the reward pool by means of lock-up issuance, thereby increasing the profitability of the node in the first 10 years (additional period).

- PlatON Foundation validator revenue

  In order to maintain the stable operation of the main network, the PlatON Foundation sponsored the pledge and maintained 7 verification nodes. The proceeds from the verification node sponsored by the PlatON Foundation will all enter the reward pool as an incentive fund for community verification nodes.

- Slash cuts fines

  The verification node was penalized by the system due to the low block generation rate, and the penalties were all entered into the reward pool for distribution in the next year's additional issuance cycle.

#### Incentive rules

![reward distribution](PlatON_economic_plan.assets/reward_distribution.png)

在PlatON中，对验证节点有以下三类激励方式：

In PlatON, there are three types of incentive methods for the validator:

- Block reward

  All verification nodes participating in consensus block production will receive block production rewards for the blocks produced. Block rewards are issued in real time based on the blocks that are produced. 50% of the reward pool is used for block rewards. The amount of block rewards for a single block is determined based on the balance of the reward pool at the beginning of each additional period, and the entire additional period remains unchanged. The reward for a single block in the $n$ additional period is as follows:

  $$B(n)=\frac{R_{v\times (n-1)}\times50\%}{v}$$

  among them,

  $R_{v\times (n-1)}$: The balance of the bonus pool at the beginning of the n-th year additional period (block $v\times (n-1)$).

  $v$ : The number of blocks in the system's additional period is a non-fixed parameter. The total number of blocks generated in one year is calculated based on the average interval of block generation.

- Transaction Fees

  The verification node responsible for the production block can obtain the commission for all transactions in the corresponding block. Transaction fees are issued in real time with the block.

- Staking reward

  All candidate verification nodes in each epoch can get Staking rewards as the return of the pledge lock. 50% of the reward pool is used for Staking rewards. Staking rewards in a single epoch are determined at the beginning of each additional period based on the balance of the reward pool at that time, and the entire additional period is unchanged. Staking rewards are evenly distributed to the candidate nodes at the time (including the verification node of the current consensus round) in the settlement block.

  Staking rewards for each epoch of the current issuance period:

  $$S(n)=\frac{c\times R_{v\times (n-1)}\times50\%}{v}$$

  On the settlement block, assuming that the number of candidate nodes in the current epoch is $m$, the Staking reward for each candidate node in the current  epoch:

  $$I(n)=\frac{S(n)}{m}$$

  among them,

  $R_{v\times (n-1)}$: The balance of the reward pool at the beginning of the n-th additional period (block $v\times (n-1)$ ).

  $v$ :  The number of blocks in the system's additional period is a non-fixed parameter. The total number of blocks generated in one year is calculated based on the average interval of block generation.

  $c$: Number of blocks in the system epoch, fixed at 10750 blocks

### Punishment mechanism

Unlike PoW public chains, PoS public chains generally do not rely on computing power to maintain system security. PoS public chains require participating nodes to pledge a certain amount of tokens as a guarantee. When a node behaves badly, the system will reduce the node's The pledged deposit is punished to increase the cost of evil, restrict and regulate the behavior of nodes, and ensure the stability and security of the system. PlatON also introduced corresponding punishment mechanisms.

#### Punished behavior

In PlatON, any node that attempts to fork the blockchain and stay offline for a long time may be penalized by Slash.

- DuplicateVote\DuplicatePrepare

  Whether it is a soft fork or a hard fork, a collective decision needs to be made through voting. Any attempt by a node to attempt a fork privately will be punished by Slash.

  **DuplicatePrepare,** Refers to the situation where nodes in the same view have double blocks (or multiple blocks) at the same block height.

  **DuplicateVote** It means that in the same view, nodes have multiple signatures on the same block with different heights.

- Long offline

  Nodes can't connect for a long time, can't produce blocks or verify signatures normally, nodes will be punished by Slash.

#### PlatON's way of punishment

PlatON currently supports two penalties:

1. Deduct node own pledge

   A certain percentage or fixed amount of Energon is deducted from the node's own pledge (**locked own pledge**) as a penalty. After the deduction, if the node's remaining own pledge (including the locked and unlocked pledges in the hesitation period) does not meet the pledge threshold of the alternative validator candidate, the alternative validator candidate will immediately lose the qualification to participate in the validator and the system Automatically revoke its pledge. The deduction rules are as follows:

   - Deduction of the node's own pledge deposit will only deduct the node's own pledge Energon which has been locked in the current epoch. Unlocked pledge Energon during the hesitation period will not participate in the deduction.

   - If a node pledges both the account balance and the locked balance of Energon, it will preferentially deduct the Energon pledged using the account balance, and then deduct the Energon of the locked balance pledge.

   - When deducting the Energon pledged from the account lock balance, the remaining unlocked amount of the account in the lock contract and the participating pledge amount are deducted correspondingly.

2. Force exit alternative validator candidate

   Alternative validator candidate are passively withdrawn, they no longer participate in the election of alternative validators and validators, and are immediately revoked for pledges, withdrawing from the alternative validator candidate list. The Energon entrusted to this node is all invalidated and unlocked. The Energon entrusted to dismiss requires the user to apply for redemption by itself (too many principals, automatic return will greatly affect system performance). The node's remaining own pledge deposit will continue to be locked for 28 epochs and will automatically be returned to the node staking account.

   ![remove from candidate validator list](PlatON_economic_plan.assets/remove_from_candidate_validator_list.png)

   - Nodes that are forced to withdraw do not participate in the allocation of Staking rewards for settlement blocks in this epoch.

   - When the pledge is revoked, the pledged Energon that is not locked in the hesitation period does not need to continue to lock for 28 epochs and will be returned immediately.

   - When the entrusted Energon is revoked, the entrusted Energon can be redeemed, and the entrusted Energon will be credited to the account immediately, but the principal needs to apply for redemption.

   - A node that is forcibly withdrawn can only use the node ID to re-pledge after the lock-up period ends and the node pledged Energon returns.

  - When a node that is forcibly withdrawn uses the node ID to re-pledge, the previously entrusted Energon that has expired but has not been redeemed will not be credited to the re-pledged verification node (alternative node candidate).

   - When a forced withdrawal node participates in the voting of a proposal and the voting deadline of the proposal is greater than 28 settlement cycles, the unlocking block is postponed to the voting deadline block.

  - If the verification node that is punished and forced to withdraw is participating in the current consensus round, the verification node can continue to complete the block generation and verification work of this consensus round. If the node is punished after 230 blocks in the consensus round, if the next consensus round confirms that the verification node has the node, the node can continue to participate in the block generation and verification of the next consensus round.

#### PlatON's punishment mechanism

##### DuplicatePrepare\DuplicateVote-Manual reporting and systematic penalties

In PlatON, DuplicateVote means signing the same block height and different hash in the same view, which is manifested in CBFT, namely DuplicateVote ViewChangeVote and DuplicateVote PrepareVote. DuplicatePrepare indicates that the block node has two different hash blocks for the same height in the same view. In essence, the block is also verified by the signature of the block, so the node DuplicateVote and DuplicatePrepare in PlatON are unified as DuplicateVote.

The node has a DuplicateVote behavior. If it is found by any user, it can initiate a DuplicateVote report transaction, submit the type and evidence of the DuplicateVote (the evidence can be obtained through the query double-out, DuplicateVote evidence interface provided) to the system slashing contract, and slashing After the contract verification is confirmed to be true, the system will reduce 100% of the reported node's own pledge as a penalty, and at the same time, the reported node will forcibly withdraw from the alternative validator candidate and revoke the pledge. All penalties are awarded to the reporting user.

- A DuplicateVote report has a validity period, and reports that are more than 28 epochs are invalid.

  ![report validity period](PlatON_economic_plan.assets/report_validity_period.png)

- Reporting follows the principle of chronological order, and only the user who reports first will receive a penalty. Subsequent identical reports are invalid reports. Therefore, it is best to check whether you have been reported to have DuplicateVote before reporting.

- A duplicateVote report only supports reporting of a duplicateVote behavior of a validating node. Multiple duplicateVote reports require multiple submissions.

- In order to prevent misjudgment or artificially forged report evidence, the slashing contract follows the following verification rules:

  1) Reporting whether the evidence is within the validity period or not is an invalid report.
  2) Whether the signature of the report evidence is the signature of the verification node; otherwise, the report is invalid.
  3) Whether the reported duplicatePrepare block is the block produced by the reported node, otherwise it is an invalid report.
  4) Whether the reported duplicateVote voting block is the block responsible for verification by the reporting node, otherwise it is an invalid report.
  5) Whether the reported duplicateVote block is a future block or not is an invalid report.

##### Zero block-the system automatically judges and punishes

PlatON judges whether a node is online and whether the node's software, hardware, and network environment meets the requirements based on the level of block production. In the 230 block of each consensus round (250 blocks in one consensus round), the block rate of the last consensus round verification node is judged.

![low block rate verification](PlatON_economic_plan.assets/low_block_rate_verification.png)

When the number of blocks produced is zero, the system forcibly quits the alternative validator candidate, no longer participates in the validator election, and there is no staking reward in the current epoch.

### Transaction Fees

Every application running on PlatON consumes certain resources (including computing power, bandwidth, storage, data, etc.). In order to achieve fair and reasonable use of resources and avoid misuse of resources, the Gas mechanism of Ethereum is used to achieve reasonable scheduling and validity verification of resources.

#### Gas fee mechanism

To prevent the exponential explosion and infinite loop of the code, PlatON uses the Gas mechanism of Ethereum to measure the resources (memory, CPU, bandwidth) consumed by each transaction execution. When submitting transactions, users can set GasPrice, which is the price of each Gas, in order to control the transaction fee for submitting transactions.

#### Gas Expense Description

In addition to ordinary transfer transactions, PlatON also supports the following built-in contract transactions related to economics and governance. We adopt a custom fixed gas consumption according to the interface plus a customizable floating gas consumption based on input parameters.

##### Transfer transaction

The transfer transaction is fixed at 21000Gas.

##### Built-in transactions

Gas calculation rules for built-in transactions are:

```
Built-in transaction gas consumption = transaction fixed gas consumption + transaction dynamic gas consumption rules + (number of non-zero value bytes in data * 68) + (number of zero value bytes in data * 4)
```

- Staking transactions

| Interface name      | Transaction fixed gas consumption | Trading dynamic gas consumption rules |
| ------------- | --------------- | ------------------- |
| create staking      | 59000           | N                  |
| edit staking  | 39000           | N                  |
| increase staking      | 47000           | N                  |
| Revoke staking      | 47000           | N                  |
| Initiate a delegate      | 43000           | N                  |
| Underweight/Revoke deleagte | 35000           | N                  |

- Governance transactions

To limit the malicious submission of text proposals, parameter proposals, upgrade proposals, and cancel proposals, increase the minimum GasPrice limit.

| Interface name     | Transaction fixed gas consumption | Trading dynamic gas consumption rules |Minimum GasPrice（GVon）|
| ------------ | --------------- | ------------------- | ------------------- |
| Submit text proposal | 350000         | N                  | 1500000           |
| Submit parameter proposal | 530000        | N                  | 2000000           |
| Submit upgrade proposal | 480000         | N                  | 2100000           |
| Cancel proposal | 530000         | N                  | 3000000           |
| Vote on proposal   | 32000          | N                  | N                  |
| Version declaration     | 33000           | N                  | N                  |

- Slashing transactions

| Interface name     | Transaction fixed gas consumption | Trading dynamic gas consumption rules |
| ------------ | --------------- | ------------------- |
| Report duplicate signatures | 63000           | N                  |

- Restricting  transactions

| Name of Trade     | Transaction fixed gas consumption | Trading dynamic gas consumption rules      |
| ------------ | --------------- | ------------------------ |
| Create a restricting plan | 68000           | Unlock times of this lockup×21000 |


- Receive delgate income

| Name of Trade     | Transaction fixed gas consumption | Trading dynamic gas consumption rules      |
| ------------ | --------------- | ------------------------ |
| Receive delegate award  | 8000           | Number of delegated nodes(nodeid+stakingNum) x 1000 + Number of epoch without delegated reward x 100 |
