# PlatON WASM 用户手册

[TOC]

## 数据类型

### 支持的类型

- char \*
- const char\*
- char
- int8_t/uint8_t/byte
- short/unsigned short/int16_t/uint16_t
- long/int/int32_t/unsigned int/uint32_t
- long long/int64_t/unsigned long long/uint64_t
- int128/unsigned int128/int128_t/uint128_t

### 不支持的类型

- float
- dobule
- std::string

## API

### Common API

#### fromHexChar

```C++
int platon::fromHexChar(int _i)
​```

> 将 16 进制字符转换为 10 进制整数
>
> **Parameters:**
>
> - **\_i** - 16 进制字符
>
> **Returns:**
>
> int - 如果`_i`不是 16 进制字符, 则返回-1; 否则返回对应 10 进制整数
>
> **Example:**
>
> ```C++
> int i = platon::fromHexChar('a'); // i = 10
> ```

#### fromHex

```C++
bytes platon::fromHex(std::string const& _s)
​```

> 将 16 进制字符串转换为对应的 byte 数组
>
> **Parameters:**
>
> - **\_s** - 16 进制字符串
>
> **Returns:**
>
> bytes - 16 进制字符串`_s`代表的 byte 数组
>
> **Example:**
>
> ```C++
> auto b = platon::fromHex("0x12abef");
> ```

#### asBytes

```C++
bytes platon::asBytes(std::string const& _b)
```

> 将字符串转换为 byte 数组
>
> **Parameters:**
>
> - **\_b** - 字符串
>
> **Returns:**
>
> bytes - byte 数组
>
> **Example:**
>
> ```C++
> auto b = platon::asBytes("hello");
> ```

#### toHex(1/2)

```C++
template <class Iterator>
std::string toHex(Iterator _it, Iterator _end, std::string const& _prefix)
​```

> 将 byte 序列转换为对应的 16 进制字符串
>
> **Template Paramters:**
>
> - **Iterator** - 迭代器
>
> **Paramters:**
>
> - **\_it** - 迭代器开始位置
> - **\_end** - 迭代器结束位置
> - **\_prefix** - 字符串前缀
>
> **Returns:**
>
> std::string - 16 进制字符串
>
> **Example:**
>
> ```C++
> bytes bs = {'a', 'b', 'c'};
> auto s = platon::toHex(bs.begin(), bs.end(), "0x");
> ```

#### toHex(2/2)

```C++
template <class T>
std::string toHex(T const& _data)
​```

> 将 byte 序列转换为对应的 16 进制字符串
>
> **Template Paramters:**
>
> - **T** - 字符串类型, 必须是 std::string 或 char\*
>
> **Paramters:**
>
> - **\_data** - byte 序列
>
> **Returns:**
>
> std::string - 16 进制字符串
>
> **Example:**
>
> ```C++
> auto s = platon::toHex("A\x69"); // "4169"
> ```

#### toBigEndian

```C++
template <class T, class Out>
void toBigEndian(T _val, Out o_out)
​```

> 将整数转换为大端 byte 数组
>
> **Template Parameters:**
>
> - **T** - 整数类型, 必须为 bigint 或无符号整数类型
> - **Out** - 输出类型
>
> **Parameters:**
>
> - **\_val** - 无符号整数或 bigint
> - **o_out** - 转换结果
>
> **Example:**
>
> ```C++
> platon::bytes out(16);
> platon::toBigEndian(123456, out);
> ```

#### fromBigEndian

```C++
template <class T, class _In>
T fromBigEndian(_In const& _bytes)
​```

> 将大端 byte 数组转换为整数
>
> **Template Parameters:**
>
> - **T** - 整数类型, 必须为 bigint 或无符号整数类型
> - **\_In** - 输入类型
>
> **Parameters:**
>
> - **\_bytes** - 大端 byte 数组
>
> **Returns:**
>
> T - 大端 byte 数组对应的整数
>
> **Example:**
>
> ```C++
> platon::bytes bs = {12, 32, 40, 60};
> int32_t i = platon::fromBigEndian(bs);
>
> uint8_t arr[] = {12, 30};
> int16_t = platon::fromBigEndian(arr);
> ```

### State API

#### gasPrice()

```C
int64_t gasPrice()
​```

> 获取 gas 的价格
>
> **Returns:**
>
> int64_t - gas 价格
>
> **Example:**
>
> ```C
> auto price = gasPrice();
> ```

#### blockHash

```C++
h256 blockHash(int64_t number)
​```

> 获取块高`number`的哈希
>
> **Paramters:**
>
> - **number** - 块高
>
> **Returns:**
>
> h256 - 块的哈希
>
> **Example:**
>
> ```C++
> auto hash = platon::blockHash(16);
> ```

#### number

```C++
uint64_t number()
​```

> 获取当前块的高度
>
> **Returns:**
>
> uint64_t - 块高
>
> **Example:**
>
> ```C++
> uint64_t blockNumber = number();
> ```

#### gasLimit

```C++
uint64_t gasLimit()
​```

> 获取 gas 上限
>
> **Returns:**
>
> uint64_t - gas 上限
>
> **Example:**
>
> ```C++
> uint64_t limited = platon::gasLimit();
> ```

#### timestamp

```C++
int64_t timestamp()
​```

> 获取区块时间(ms)
>
> **Returns:**
>
> int64_t - 时间戳(ms)
>
> **Example:**
>
> ```C++
> int64_t blockTime = platon::timestamp();
> ```

#### coinbase

```C++
h160 coinbase()
​```

> 获取当前区块矿工的钱包地址
>
> **Returns:**
>
> h160 - 当前区块矿工的钱包地址
>
> **Example:**
>
> ```C++
> platon::h160 addr = platon::coinbase();
> ```

#### balance

```C++
u256 balance()
​```

> 获取资产
>
> **Returns:**
>
> u256 - 资产总值
>
> **Example:**
>
> ```C++
> platon::u256 balance = platon::balance();
> ```

#### origin

```C++
h160 origin()
​```

> 获取原始交易发起人的地址
>
> **Returns:**
>
> h160 - 原始交易发起人的地址
>
> **Example:**
>
> ```C++
> platon::h160 addr = platon::origin();
> ```

#### caller

```C++
h160 caller()
​```

> 获取合约调用方的地址
>
> **Returns:**
>
> h160 - 合约调用方的地址
>
> **Example:**
>
> ```C++
> platon::h160 addr = platon::caller();
> ```

#### callValue

```C++
u256 callValue()
​```

> 与消息一起发送的能量数量
>
> **Returns:**
>
> u256 - 能量数量
>
> **Example:**
>
> ```C++
> platon::u256 v = platon::callValue();
> ```

#### address

```C++
h160 address()
​```

> 获取合约地址
>
> **Returns:**
>
> h160 - 合约地址
>
> **Example:**
>
> ```C++
> platon::h160 addr = platon::address();
> ```

#### sha3(1/3)

```C++
h256 sha3(bytes& data)
​```

> 计算输入数据的 Keccak-256 哈希
>
> **Parameters:**
>
> - **data** - 二进制数据
>
> **Returns:**
>
> h256 - Keccak-256 哈希
>
> **Example:**
>
> ```C++
> platon::bytes arr{10, 11, 12, 13};
> auto hash = platon::sha3(arr);
> ```

#### sha3(2/3)

```C++
h256 sha3(const std::string& data)
​```

> 计算输入字符串的 Keccak-256 哈希
>
> **Parameters:**
>
> - **data** - 字符串
>
> **Returns:**
>
> h256 - Keccak-256 哈希
>
> **Example:**
>
> ```C++
> std::string str = "hello world!";
> auto hash = platon::sha3(str);
> ```

#### sha3(3/3)

```C++
h256 sha3(const byte* data, size_t len)
​```

> 计算输入数据的 Keccak-256 哈希
>
> **Parameters:**
>
> - **data** - 数据
> - **len** - 数据长度
>
> **Returns:**
>
> h256 - Keccak-256 哈希
>
> **Example:**
>
> ```C++
> byte arr[3] = {20, 30, 40};
> auto hash = platon::sha3(arr, 3);
> ```

#### getCallerNonce

```C++
int64_t getCallerNonce()
​```

> 获取调用方的 nonce
>
> **Returns:**
>
> int64_t - 调用方的 nonce
>
> **Example:**
>
> ```C++
> auto nonce = getCallerNonce();
> ```

#### callTransfer

```C++
int64_t callTransfer(const Address& to, u256 amount)
​```

> 转账
>
> **Parameters:**
>
> - **to** - 转账目的地址
> - **amount** - 转账数量
>
> **Returns:**
>
> int64_t - 0 转账成功, 非 0 转账失败
>
> **Example:**
>
> ```C++
> platon::Address to("0x1C4A8F9a6cdFa6e7FF32f72546840d6BeBF6BBd0", true);
> auto res = platon::callTransfer(to, 100);
> ```

#### setState

```C++
template <typename KEY, typename VALUE>
void setState(const KEY& key, const VALUE&)
​```

> 设置状态
>
> **Template Parameters:**
>
> - **KEY** - 键类型, 必须是容器类型如 std::string, std::vector<int>, bytes
> - **VALUE** - 值类型, 必须是容器类型如 std::string, std::vector<int>, bytes
>
> **Parameters:**
>
> - **key** - 主键
> - **value** - 值
>
> **Example:**
>
> ```C++
> std::string key = "key";
> std::string val = "val";
> platon::setState(key, val);
>
> std::vector<int> key{1, 2, 3};
> std::vector<std::string> val{"123", "hello"};
> platon::setState(key, val);
> ```

#### getState

```C++
template <class KEY, class VALUE>
size_t getState(const KEY& key, const VALUE& value)
​```

> 获取状态
>
> **Template Parameters:**
>
> - **KEY** - 键类型, 必须是容器类型如 std::string, std::vector<int>, bytes
> - **VALUE** - 值类型, 必须是容器类型如 std::string, std::vector<int>, bytes
>
> **Parameters:**
>
> - **key** - 主键
> - **value** - 值
>
> **Returns:**
>
> size_t - 数据长度
>
> **Example:**
>
> ```C++
> std::string key = "hello";
> std::string val;
> auto len = platon::getState(key, val);
> ```

#### delState

```C++
template <typename KEY>
void delState(const KEY& key)
​```

> 删除状态
>
> **Template Parameters:**
>
> - **KEY** - 键类型, 必须是容器类型如 std::string, std::vector<int>, bytes
>
> **Parameters:**
>
> - **key** - 主键
>
> **Example:**
>
> ```C++
> std::string key("hello");
> platon::delState(key);
> ```

### Print API

#### print(1/15)

```C++
void print(const char* ptr)
​```

> 打印字符串
>
> **Parameters:**
>
> - **ptr** - C 风格字符串
>
> **Example:**
>
> ```C++
> platon::print("hello world!");
> ```

#### print(2/15)

```C++
void print(const std::string& s)
​```

> 打印字符串
>
> **Parameters:**
>
> - **s** - 字符串
>
> **Example:**
>
> ```C++
> std::string str("hello world!");
> platon::print(str);
> ```

#### print(3/15)

```C++
void print(std::string& s)
​```

> 打印字符串
>
> **Parameters:**
>
> - **s** - 字符串
>
> **Example:**
>
> ```C++
> std::string str("hello world!")
> platon::print(str);
> ```

#### print(4/15)

```C++
void print(const char c)
​```

> 打印字符
>
> **Parameters:**
>
> - **c** - 字符
>
> **Example:**
>
> ```C++
> platon::print('a');
> ```

#### print(5/15)

```C++
void print(int num)
​```

> 打印整数
>
> **Parameters:**
>
> - **num** - 整数
>
> **Example:**
>
> ```C++
> int i = 23;
> platon::print(i);
> ```

#### print(6/15)

```C++
void print(uint32_t num)
​```

> 打印 32 位整数
>
> **Parameters:**
>
> - **num** - 32 位整数
>
> **Example:**
>
> ```C++
> int32_t i = 32;
> platon::print(i);
> ``
> ```

#### print(7/15)

```C++
void print(int64_t num)
​```

> 打印 64 位整数
>
> **Parameters:**
>
> - **num** - 64 位整数
>
> **Example:**
>
> ```C++
> int64_t i = 10;
> platon::print(i);
> ```

#### print(8/15)

```C++
void print(unsigned int num)
​```

> 打印无符号整数
>
> **Parameters:**
>
> - **num** - 无符号整数
>
> **Example:**
>
> ```C++
> unsigned int i = 10;
> platon::print(i);
> ```

#### print(9/15)

```C++
void print(uint32_t num)
​```

> 打印 32 位无符号整数
>
> **Parameters:**
>
> - **num** - 32 位无符号整数
>
> **Example:**
>
> ```C++
> uint32_t i = 10;
> platon::print(i);
> ```

#### print(10/15)

```C++
void print(uint64_t num)
​```

> 打印 64 位无符号整数
>
> **Parameters:**
>
> - **num** - 64 位无符号整数
>
> **Example:**
>
> ```C++
> uint64_t i = 10;
> platon::print(i);
> ```

#### print(11/15)

```C++
void print(int128_t num)
​```

> 打印 128 位整数
>
> **Parameters:**
>
> - **num** - 128 位整数
>
> **Example:**
>
> ```C++
> int128_t i = 10;
> platon::print(i);
> ```

#### print(12/15)

```C++
void print(uint128_t num)
​```

> 打印 128 位无符号整数
>
> **Parameters:**
>
> - **num** - 128 无符号整数
>
> **Example:**
>
> ```C++
> uint128_t i = 10;
> platon::print(i);
> ```

#### print(13/15)

```C++
void print(u256 num)
​```

> 打印 256 位无符号整数
>
> **Parameters:**
>
> - **num** - 256 位无符号整数
>
> **Example:**
>
> ```C++
> platon::u256 i = 10;
> platon::print(i);
> ```

#### print(14/15)

```C++
void print(bool val)
​```

> 打印布尔值(true/false)
>
> **Parameters:**
>
> - **val** - 布尔值
>
> **Example:**
>
> ```C++
> bool val = true;
> platon::print(val);
> ```

#### print(15/15)

```C++
template <typename Arg, typename... Args>
void print(Arg&& a, Args&&.. args)
​```

> 打印一个或多个值
>
> **Template Parameters:**
>
> - **Arg\*** - 值类型(int,char,std::string...)
> - **Args** - 值类型列表
>
> **Parameters:**
>
> - **a** - 值
> - **args** - 值列表
>
> **Example:**
>
> ```C++
> const char* s= "Hello World!";
> uint64_t ui64 = 1e+18;
> uint128_t ui128 = 87654321;
> uint64_t strAsUi64 = N(abcde);
> platon::print(s, ui64, ui128, strAsUi64);
> ```

#### println

```C++
template <typename Arg, typename..Args>
void print(Arg&& a, Args&&... args)
​```

> 打印一个值或多个值, 并换行
>
> **Template Parameters:**
>
> - **Arg\*** - 值类型(int,char,std::string...)
> - **Args** - 值类型列表
>
> **Parameters:**
>
> - **a** - 值
> - **args** - 值列表
>
> **Example:**
>
> ```C++
> const char* s= "Hello World!";
> uint64_t ui64 = 1e+18;
> uint128_t ui128 = 87654321;
> uint64_t strAsUi64 = N(abcde);
> platon::print(s, ui64, ui128, strAsUi64);
> ```

## Classes

### Contract

合约基类

Example:

```C++
class TestContract : public Contract {
 public:
  virtual void init() override {}

  void hello() {
    platon::print("Hello World!\n");
  }
};
​```

#### Public Functions

##### init

```C++
virtual void init() {}
​```

> 合约初始化函数, 在合约部署时调用, 且仅调用一次. 通常用于初始化合约数据.


### DeployedContract

提供跨合约调用功能

#### Public Functions

##### DeployedContract(1/2)

```C++
explicit DeployedContract(Address address)
​```

通过合约地址构造 DeployedContract 对象

##### DeployedContract(2/2)

```C++
explicit DeployedContract(const std::string& address)
​```

> 通过合约地址字符串构造 DeployedContract 对象

##### callString

```
template <typename... Args>
inline std::string callString(const std::string& funcName, Args&&... args) const
​```

> 调用指定合约的函数
>
> **Template parameters:**
>
> - **Args** - 参数类型, 必须符合 abi 声明的类型
>
> **Paramters:**
>
> - **funcName** - 函数名
> - **args** - 参数类别
>
> **Returns:**
>
> std::string - 合约函数的返回值
>
> **Example:**
>
> ```C++
> platon::Address to("0x2C4A8F9a6cdFa6e7FE32f72546840d6BeBF6BBd0", true);
> platon::DeployedContract caller(to);
> auto ret = to.callString("Say", "Hello", "PlatON");
> ```

##### delegateCallString

```C++
template <typename... Args>
inline std::string delegateCallString(
  const std::string& funcName,
  Args&&... args
) const
​```

> 调用指定合约的函数
>
> **Template parameters:**
>
> - **Args** - 参数类型, 必须符合 abi 声明的类型
>
> **Paramters:**
>
> - **funcName** - 函数名
> - **args** - 参数类别
>
> **Returns:**
>
> std::string - 合约函数的返回值
>
> **Example:**
>
> ```C++
> platon::Address to("0x2C4A8F9a6cdFa6e7FE32f72546840d6BeBF6BBd0", true);
> platon::DeployedContract caller(to);
> auto ret = to.delegateCallString("Say", "Hello", "PlatON");
> ```

##### callInt64

```C++
template <typename... Args>
inline std::string callInt64(const std::string& funcName, Args&&... args) const
​```

> 调用指定合约的函数
>
> **Template parameters:**
>
> - **Args** - 参数类型, 必须符合 abi 声明的类型
>
> **Paramters:**
>
> - **funcName** - 函数名
> - **args** - 参数类别
>
> **Returns:**
>
> int64_t - 合约函数的返回值
>
> **Example:**
>
> ```C++
> platon::Address to("0x2C4A8F9a6cdFa6e7FE32f72546840d6BeBF6BBd0", true);
> platon::DeployedContract caller(to);
> auto ret = to.callInt64("Say", "Hello", "PlatON");
> ```

##### delegateCallInt64

```C++
template <typename... Args>
inline int64_t delegateCallInt64(const std::string& funcName, Args&&... args) const
​```

> 调用指定合约的函数
>
> **Template parameters:**
>
> - **Args** - 参数类型, 必须符合 abi 声明的类型
>
> **Paramters:**
>
> - **funcName** - 函数名
> - **args** - 参数类别
>
> **Returns:**
>
> int64_t - 合约函数的返回值
>
> **Example:**
>
> ```C++
> platon::Address to("0x2C4A8F9a6cdFa6e7FE32f72546840d6BeBF6BBd0", true);
> platon::DeployedContract caller(to);
> auto ret = to.delegateCallInt64("Say", "Hello", "PlatON");
> ```

##### call

```C++
template <typename... Args>
inline void call(const std::string& funcName, Args&&... args) const
​```

> 调用指定合约的函数
>
> **Template parameters:**
>
> - **Args** - 参数类型, 必须符合 abi 声明的类型
>
> **Paramters:**
>
> - **funcName** - 函数名
> - **args** - 参数类别
>
> **Example:**
>
> ```C++
> platon::Address to("0x2C4A8F9a6cdFa6e7FE32f72546840d6BeBF6BBd0", true);
> platon::DeployedContract caller(to);
> to.call("Say", "Hello", "PlatON");
> ```

##### delegateCall

```C++
template <typename... Args>
inline void delegateCall(const std::string& funcName, Args&&... args) const
​```

> 调用指定合约的函数
>
> **Template parameters:**
>
> - **Args** - 参数类型, 必须符合 abi 声明的类型
>
> **Paramters:**
>
> - **funcName** - 函数名
> - **args** - 参数类别
>
> **Example:**
>
> ```C++
> platon::Address to("0x2C4A8F9a6cdFa6e7FE32f72546840d6BeBF6BBd0", true);
> platon::DeployedContract caller(to);
> to.delegateCall("Say", "Hello", "PlatON");
> ```

### StorageType

存储类型. 提供数据持久化到StateDB的能力.

**Template Parameters:**

- **Name** - 元素名称, 对于同一个合约, 名称必须唯一
- **T** - 数据类型(int/uint8_t/uint32_t/long/std::string...)

Example:
​```C++
void test_storage_type() {
  char stu8_name[] = "stu8";
  char st_str_name[] = "st_str";

  platon::StorageType<stu8_name, uint8_t> stu8(1);
  platon::StorageType<st_str_name, std::string> st_str("Hello, PlatON");

  platon::println(stu8.get()); // 1
  platon::println(st_str.get()); // Hello, PlatON

  *stu8 = 10;
  *st_str = "Hello, World";

  platon::println(stu8.get()); // 10
  platon::println(st_str.get()); // Hello, World

  stu8 = 20;
  st_str = "Hello";

  platon::println(stu8.get()); // 20 
  platon::println(st_str.get()); // Hello
}
​```

#### Typedef

##### platon::Uint8

```C++
template <const char* name>
using Uint8 = class StorageType<name, uint8_t>
​```

Example:

```c++
#include <platon/platon.hpp>

typedef platon::Uint8<"test"_n> TestUint8;

void test() {
  TestUint8 t;

  // 通过解引用拿到真正的类型，赋值
  *t = 10;

  // access
  platon::println(*t);
  platon::println(t.get());
}
​```

##### platon::Int8

```C++
template <const char* name>
using Int8 = class StorageType<name, int8_t>
​```

Example:

```C++
#include <platon/platon.hpp>

typedef platon::Int8<"test"_n> TestInt8;

void test() {
  TestInt8 t;

  // assign
  *t = 10;

  // access
  platon::println(*t);
  platon::println(t.get());
}
​```

##### platon::Uint16

```C++
template <const char* name>
using Uint16 = class StorageType<name, uint16_t>
​```

Example:

```c++
#include <platon/platon.hpp>

typedef platon::Uint16<"test"_n> TestUint16;

void test() {
  TestUint16 t;

  // assign
  *t = 100;

  // access
  platon::println(*t);
  platon::println(t.get());
}
​```

##### platon::Int16

```C++
template <const char* name>
using Int16 = class StorageType<name, int16_t>
​```

Example:

```c++
#include <platon/platon.hpp>

typedef platon::Int16<"test"_n> TestInt16;

void test() {
  TestInt16 t;

  // assign
  *t = 199;

  // access
  platon::println(*t);
  platon::println(t.get());
}
​```

##### platon::Uint

```C++
template <class char* name>
using Uint = class StorageType<name, unt32_t>
​```

Example: 

```c++
#include <platon/platon.hpp>

typedef platon::Uint<"test"_n> TestUint;

void test() {
  TestUint t;

  // assign
  *t = 90;

  // access
  platon::println(*t);
  platon::println(t.get());
}
​```

##### platon::Int

```C++
template <class char* name>
using Int = class StorageType<name, int32_t>
​```

Example: 

```c++
#include <platon/platon.hpp>

typedef platon::Int<"test"_n> TestInt;

void test() {
  TestInt t;

  // assign
  *t = 100;

  // access
  platon::println(*t);
  platon::println(t.get());
}
​```

##### platon::Uint64

```C++
template <class char* name>
using Uint64 = class StorageType<name, uint64_t>
​```

Example:

```C++
#include <platon/platon.hpp>

typedef platon::Uint64<"test"_n> TestUint64;

void test() {
  TestUint64 t;

  // assign
  *t = 100000;

  // access
  platon::println(*t);
  platon::println(t.get());
}
​```

##### platon::Int64

```C++
template <class char* name>
using Int64 = class StorageType<name, int64_t>
​```

Example:

```C++
#include <platon/platon.hpp>

typedef platon::Int64<"test"_n> TestInt64;

void test() {
  TestInt64 t;

  // assign
  *t = 199999999;

  // access
  platon::println(*t);
  platon::println(t.get());
}
​```

##### platon::String

```C++
template <class char* name>
using String = class StorageType<name, std::string>
​```

Example:

```C++
#include <platon/platon.hpp>

typedef platon::String<"test"_n> TestString;

void Test() {
  TestString str;

  // assign
  *str = "Hello, PlatON!";
  str->append("Hello");
  str->assign("Hello, PlatON");

  // 通过operater*可以拿到std::string
  // 可以把*str当成一个std::string对象去使用

  // access
  platon::println(str->c_str());
  platon::println((*str).c_str());
  platon::println(str.get().c_str());
}
​```

##### platon::Vector

```C++
template <class char* name, typename T>
using Vector = class StorageType<name, std::vector<T>>
​```
> **Template Parameters:**
> 
> - **name** - 名称
> - **T** - 元素类型

Example:

```C++
#include <platon/platon.hpp>

typedef platon::Vector<"test"_n, int> TestVec;

void test() {
  TestVec vec;

  // assign
  for (auto i = 0; i < 10; i++) {
    (*vec).push_back(i);
  }

  // 通过operater*可以拿到std::vector
  // 可以把*vec当成一个std::vector对象去使用

  // access
  for (auto i = 0; i < vec->size(); i++) {
    platon::print((*vec)[i]);
  }
  platon::println(vec.get()[0]);
  platon::println(vec->font());  // 访问vector第一个元素
  platon::println(vec->back());  // 访问vector最后一个元素

  // 使用迭代器
  for (auto it = vec->begin(); it != vec->end(); ++it) {
    platon::print(*it);
  }
}
​```

##### platon::Set

```C++
template <class char* name, typename T>
using Set = class StorageType<name, std::set<T>>
​```

> **Template Parameters:**
>
> - **name** - 名称
> - **T** - 元素类型

Example:

```C++
#include <platon/platon.hpp>

typedef platon::Set<"test"_n, int> TestSet;

void test() {
  TestSet set;

  // assign
  for (auto i = 0; i < 10; i++) {
    (*set).insert(i); 
  }

  // 通过operater*可以拿到std::set
  // 可以把*set当成一个std::set对象去使用

  // access
  for (auto it = set->begin(); it != set->end(); ++it) {
    platon::print(*it);
  }

  // modify
  set->erase(8);
  set->clear();
}
​```

##### platon::Map

```C++
template <class char* name, typename K, typename V>
using Map = class StorageType<name, std::map<K,V>>
​```

> **Template Parameters:**
>
> - **name** - 名称
> - **K** - std::map的键类型
> - **V** - std::map的值类型

Example: 

```C++
#include <platon/platon.hpp>

typedef platon::Map<"test"_n, std::string, std::string> TestMap;

void test() {
  TestMap tm;

  // assign
  (*tm)["hello"] = "platon";
  (*tm).insert(std::make_pair("key", "value")); 

  // 通过operater*可以拿到std::map
  // 可以把*tm当成一个std::map对象去使用

  // access
  for (auto it = tm->begin(); it != tm->end(); ++it) {
    platon::print_f("key: % value: %\n", it->first.c_str(), it->second.c_str());
  }
  platon::println(tm->get()["hello"]);
  platon::println(tm->at("hello"));
  platon::println((*tm)["hello"]);

  // modify
  tm->erase("key");
  tm->clear();
}
​```

##### platon::Array

```C++
template <const char* name, typename T, size_t N>
using Array = class StorageType<name, std::array<T,N>>
​```

> **Template Parameters:**
> 
> - **name** - 名称
> - **T** - 元素类型
> - **N** - 数组大小

Example:

```C++
#include <platon/platon.hpp>

typedef platon::Array<"test"_n, int, 10> TestArray;

void test() {
  TestArray arr;

  // assign
  for (auto i = 0; i < 10; i++) {
    (*arr)[i] = i;
  }

  // 通过operater*可以拿到std::array
  // 可以把*arr当成一个std::array对象去使用

  // access
  for (auto i = 0; i < 10; i++) {
    platon::print((*arr)[i]);
  }
  platon::println(arr-at(0));
  platon::println(arr->front());
  platon::println(arr->back());
}
​```

##### platon::Tuple

```C++
template <const char* name, typename... Types>
using Tuple = class StorageType<name, std::tuple<Types...>>
​```

> **Template Parameters:**
>
> - **name** - 名称
> - **Types** - 元素类型

Example: 

```C++
#include <platon/platon.hpp>

typedef platon::Tuple<"test"_n, int, std::string, int> TestTuple;

void test() {
  TestTuple tpl;

  // assign
  *tpl = std::make_tuple(10, "test", 9);

  // 通过operater*可以拿到std::tuple
  // 可以把*tpl当成一个std::tuple对象去使用

  // access
  platon::println(std::get<0>(*tpl));
  platon::println(std::get<1>(*tpl).c_str());
  platon::println(std::get<2>(*tpl));
}
​```

### platon::db::Array

支持持久化的数组实现

**Template Parameters:**

- **Name** - 数组名, 同一合约下, 该名称必须唯一
- **Key** - 数组存放的数据类型
- **Size** - 数组长度

Example:

```C++
char arr_name[] = "array_name";
platon::db::Array<arr_name, int, 10> arr;
for (size_t i = 0; i < 10; i++) {
  arr[i] = i;
}
platon::println(arr.size());

for (auto it = arr.begin(); it != arr.end(); ++it) {
  platon::print(*it);  // 123456789
}
platon::print("\n");

for (auto it = arr.rbegin(); it != arr.rend(); ++it) {
  platon::print(*it); // 987654321
}
​```

#### Public Functions

##### Array

```C++
Array()
​```

> 构造`Array`对象

##### begin

```C++
Iterator begin()
​```

> 返回一个指向数组开始位置的迭代器
>
> **Returns:**
> 
> Iterator - 指向数组开始位置的迭代器
>

##### end

```C++
Iterator end()
​```

> 返回指向数组结束位置的迭代器
>
> **Returns:**
> 
> Iterator - 指向数组开始结束的迭代器

##### rbegin

```C++
ReverseIterator rbegin()
​```

> 返回指向数组末尾的反向迭代器
>
> **Returns:**
> 
> ReverseIterator - 指向数组末尾的反向迭代器

##### rend

```C++
ReverseIterator rend()
​```

> 返回指向数组开始位置的反向迭代器
> 
> **Returns:**
> 
> ReverseIterator - 指向数组开始位置的反向迭代器

##### cbegin

```C++
ConstIterator cbegin()
​```

> 返回指向数组开始位置的迭代器
> 
> **Returns:**
> 
> ConstIterator - 指向数组开始位置的迭代器

##### cend

```C++
ConstIterator cend()
​```

> 返回指向数组末尾的迭代器
>
> **Returns:**
>
> ConstIterator - 指向数组末尾的迭代器

##### crbegin

```C++
ConstReverseIterator crbegin()
​```

> 返回指向数组末尾的反向迭代器
>
> **Returns:**
> 
> ConstReverseIterator - 指向数组末尾的反向迭代器

##### crend

```C++
ConstReverseIterator crend()
​```

> 返回指向数组开始位置的反向迭代器
> 
> **Returns:**
> 
> ConstReverseIterator - 指向数组开始位置的反向迭代器

##### at

```C++
Key& at(size_t pos)
​```

> 返回指定索引对应的数组元素
> 
> **Parameters:**
> 
> - **pos** - 数组元素索引位置
>
> **Returns:**
> 
> Key - 数组元素

##### operator[]

```C++
Key& operator[](size_t pos)
​```

> 返回指定索引对应的数组元素
> 
> **Parameters:**
> 
> - **pos** - 数组元素索引
>
> **Returns:**
>
> Key - 数组元素

##### size

```C++
size_t size()
​```

> 返回数组长度
>
> **Returns:**
>
> size_t - 数组长度

##### getConst

```C++
Key getConst(size_t pos)
​```

> 返回指定索引对应的数组元素
>
> **Parameters:**
> 
> - **pos** - 数组索引
>
> **Returns:**
>
> Key - 数组元素

##### setConst

```C++
void setConst(size_t pos, const Key& key)
​```

> 修改指定索引的数组元素
>
> **Parameters:**
>
> - **pos** - 数组索引
> - **key** - 数组元素

### platon::db::List

支持数据持久化的列表实现

**Template Parameters:**

- **Name** - List的名称
- **Key** - List存储的数据类型

Example:

```C++
char list_name[] = "test_list";
platon::db::List<list_name, int> list;

for (size_t i = 0; i < 10; i++) {
  list.push(i);
}

for (auto it = list.begin(); it != list.end(); ++it) {
  platon::print(*it); // 123456789
}

list.del(2); // list: 13456789
​```
#### Public Functions

##### List

```C++
List()
​```

> 构造`List`对象

##### begin

```C++
Iterator begin()
​```

> 返回指向列表开始位置的迭代器
>
> **Returns:**
>
> Iterator - 指向列表开始位置的迭代器

##### end

```C++
Iterator end()
​```

> 返回指向列表末尾的迭代器
>
> **Returns:**
> 
> Iterator - 指向列表末尾的迭代器

##### rbegin

```C++
ReverseIterator rbegin()
​```

> 返回指向列表末尾的反向迭代器
>
> **Returns:**
> 
> ReverseIterator - 指向列表末尾的反向迭代器

##### rend

```C++
ReverseIterator rend()
​```

> 返回指向列表开始位置的反向迭代器
>
> **Returns:**
>
> ReverseIterator - 指向列表开始位置的反向迭代器

##### cbegin

```C++
ConstIterator cbegin()
​```

> 返回指向列表开始位置的迭代器
>
> **Returns:**
>
> ConstIterator - 指向列表开始位置的迭代器

##### cend

```C++
ConstIterator cend()
​```

> 返回指向列表末尾的迭代器
>
> **Returns:**
>
> ConstIterator - 指向列表末尾的迭代器

##### crbegin

```C++
ConstReverseIterator crbegin()
​```

> 返回指向列表末尾的反向迭代器
> 
> **Returns:**
>
> ConstReverseIterator - 指向列表末尾的反向迭代器

##### crend

```C++
ConstReverseIterator crend()
​```

> 返回指向列表开始位置的反向迭代器
>
> **Returns:**
>
> ConstReverseIterator - 指向列表开始位置的反向迭代器

##### push

```C++
void push(const Key& k)
​```

> 增加元素
>
> **Parameters:**
> 
> - **k** - 增加的元素值

##### get

```C++
Key& get(size_t index)
​```

> 获取指定索引位置对应的元素
>
> **Parameters:**
>
> - **index** - 索引位置
>
> **Returns:**
>
> Key - 索引位置对应的元素

##### del(1/2)

```C++
void del(size_t index)
​```

> 删除索引位置对应的元素
>
> **Parameters:**
>
> - **index** - 索引位置

##### del(2/2)

```C++
void del(Key& delKey)
​```

> 删除元素
>
> **Parameters:**
> 
> - **delKey** - 将要删除的元素

##### operator[]

```C++
Key& operator[](size_t i)
​```

> 返回索引位置对应的元素
>
> **Parameters:**
>
> - **i** - 索引位置
>
> **Returns:**
>
> Key - 索引位置对应的元素

##### getConst

```C++
Key getConst(size_t index)
​```

> 返回索引位置对应的元素
> 
> **Parameters:**
>
> - **index** - 索引位置
>
> **Returns:**
>
> Key - 索引位置对应的元素

##### setConst

```C++
void setConst(size_t index, const Key& key)
​```

> 指定索引位置对应的元素值
>
> **Parameters:**
>
> - **index** - 索引位置
> - **key** - 指定的元素值

##### size

```C++
size_t size()
​```

> 获取列表的大小
>
> **Returns:**
> 
> size_t - 列表大小

### platon::db::Map

支持数据持久化的map实现

**Template Parameters:**

- **Name** - `map`的名称
- **Key** - 主键的类型
- **Value** - 值的类型
- **type** - `map`的类型(MapType::Traverse,MapType::NoTraverse,默认MapType::Traverse)

Example:

```C++
void test_map() {
  char map_name[] = "map_test";
  platon::db::Map<map_name, std::string, std::string> map;

  map.insert("hello", "world");
  map.insert("hey", "platon");

  platon::println(map.size());

  for (auto it = map.begin(); it != map.end(); ++it) {
    platon::println("key", it->first, "value", it->second);
  }

  map.del("hello");
}
​```

#### Public Functions

##### construct Map

```C++
Map()
​```

> 构造`map`对象

##### insert

```C++
bool insert(const Key& k, const Value& v)
​```

> 插入键值对(更新内部缓存)
>
> **Parameters:**
> 
> - **k** - 主键
> - **v** - 值
>
> **Returns:**
>
> boolean - true插入成功, false插入失败

##### insertConst

```C++
bool insertConst(const Key& k, const Value& v)
​```

> 插入键值对(不更新内部缓存)
>
> **Parameters:**
>
> - **k** - 主键
> - **v** - 值
>
> **Returns:**
>
> boolean - true插入成功, false插入失败

##### getConst

```C++
Value getConst(const Key& k)
​```

> 返回`k`对应的值(不更新到内部缓存)
>
> **Parameters:**
>
> - **k** - 主键
>
> **Return**
>
> Value - `k`对应的值

##### get

```C++
Value get(const Key& k)
​```

> 获取`k`对应的值(更新到内部缓存中)
>
> **Parameters:**
>
> - **k** - 主键
>
> **Returns:**
>
> Value - `k`对应的值

##### del

```C++
void del(const Key& k)
​```

> 删除`k`对应的键值对
>
> **Parameters:**
>
> - **k** - 要删除的键值对的主键

##### operator[]

```C++
Value& operator[](const Key& k)
​```

> 返回`k`对应的值
>
> **Parameters:**
>
> - **k** - 主键
>
> **Returns**
>
> Value - `k`对应的值

##### size

```C++
size_t size()
​```

> 返回`map`的元素数量
>
> **Returns:**
>
> size_t - `map`的元素数量

##### begin,cbegin

```C++
Iterator begin()
ConstIterator cbegin()
​```

> 返回指向容器第一个元素的迭代器
>
> **Returns:**
>
> 指向容器第一个元素的迭代器

##### end,cend

```C++
Iterator end()
ConstIterator cend()
​```

> 返回指向容器最后一个元素之后元素的迭代器
>
> **Returns:**
> 
> 指向最后一个元素之后元素的迭代器

##### rbegin, crbegin

```C++
ReverseIterator rbegin()
ConstReverseIterator crbegin()
​```

> 返回指向容器最后一个元素的反向迭代器
>
> **Returns:**
>
> 指向容器最后一个元素的迭代器

##### rend, crend

```C++
ReverseIterator rend()
ConstReverseIterator crend()
​```

> 返回指向容器第一个元素之前元素的反向迭代器
>
> **Returns:**
>
> 指向容器第一个元素之前元素的反向迭代器

## Macros

### platon assertion

```C++
#define PlatonAssert(A, ...)
#define PlatonAssertEQ(A, B, ...)
#define PlatonAssertNE(A, B, ...)
​```

Example:

```C++
void test_assert() {
  PlatonAssert(10 > 0);
  PlatonAssertEQ(10, 10);
  PlatonAssertNE(10, 11);
}
​```

### RETURN

```C++
#define RETURN(ret)
​```

`return`的包装, 关闭内存回收操作, 确保返回值不会被回收.

Example:

```C++
char* getStr() {
  std::string str("hello world");
  RETURN(str.c_str());
}
​```

### PLATON_EVENT

```C++
#define PLATON_EVENT(NAME, ...)
​```

定义`event`

**Parameters:**

- **NAME** - 函数名称
- **...** - 参数类型列表

Example:

```C++
class Test : public platon::Contract {
 public:
   void Say(const char* name) {
     std::string say("Hello, ");
     say += name;
     platon::println(say);
     PLATON_EVENT(say_event, const char*);
   }
};
​```

### PLATON_EMIT_EVENT

```C++
#define PLATON_EMIT_EVENT(NAME, ...)
​```

触发`event`

**Parameters:**

- **NAME** - 函数名称
- **...** - 参数列表

Example:

```C++
class Test : public platon::Contract {
 public:
   void Say(const char* name) {
     std::string say("Hello, ");
     say += name;
     platon::println(say);
     PLATON_EVENT(say_event, const char*);
     PLATON_EMIT_EVENT(say_event, say.c_str());
   }
};
​```

### PLATON_SERIALIZE

```C++
#define PLATON_SERIALIZE(TYPE, MEMBERS)
​```

为指定的类型的成员定义序列化/反序列化API

**Parameters:**

- **TYPE** - 将要定义序列化/反序列化的类型
- **MEMBERS** -  成员列表: (field1)(field2)(field3)

Example:

```C++
struct Test {
  int a;
  std::string b;

  PLATON_SERIALIZE(Test, (a)(b));
}

void use_test {
  char ut_name[] = "use_test";
  platon::StorateType<ut_name, Test> ut;

  *ut.a = 1;
  *ut.b = "hello";

  ...
}
​```

### PLATON_SERIALIZE_DERIVED

```C++
#define PLATON_SERIALIZE_DERIVED(TYPE, BASE, MEMBERS)
​```

为派生类的成员定义序列化/反序列化API

**Parameters:**

- **TYPE** - 将要定义序列化/反序列化的类型
- **BASE** - 基类列表: (base1)(base2)(base3)
- **MEMBERS** - 成员列表: (field1)(field2)(field3)

Example:

```C++
struct TestA {
  int a;
  std::string b;

  PLATON_SERIALIZE(Test, (a)(b));
}

struct TestB : public TestA {
  int c;
  int d;

  PLATON_SERIALIZE_DERIVED(TestB, (TestA), (c)(d));
}

void use_test {
  char ut_name[] = "use_test";
  platon::StorateType<ut_name, TestB> ut;

  *ut.a = 1;
  *ut.b = "hello";
  *ut.c = 2;
  *ut.d = 3;

  ...
}
​```

### PLATON_ABI

```C++
#define PLATON_ABI(NAME, MEMBER)
​```

声明合约abi

**Parameters:**

- **NAME** - 合约类型名称(包括命名空间)
- **MEMBER** - 成员函数名称

Example:

```C++
#include <palton/platon.hpp>

namespace test_ns {
class TestContract : public platon::Contract {
 public:
   void get() {}
   void set(int) {}
};
}

PLATON_ABI(test_ns::TestContract, get);
PLATON_ABI(test_ns::TestContract, set);
​```

## 操作符

### operator `""_n`

`""_n`操作符将字符串字面量转换为字符串常量(const char*), 用于定义/声明
`platon::StorageType` `platon::db::Map` `platon::db::List` `platon::db::Array`等.

Example:

```C++
#include <platon/platon.hpp>

typedef platon::StorageType<"test"_n, uint8_t> TestUint8;
typedef platon::db::Map<"test_map"_n, std::string, std:string> TestMap;
typedef platon::db::List<"test_list"_n, std::string> TestList;
typedef platon::db::Array<"test_array"_n, std::string, 10> TestArray;
​```

## 属性指定符

### [[platon::constant]]

`[[platon::constant]]`用来修饰函数, 承诺该函数不修改stateDB(即不调用setState).
仅在在生成abi时生效, 使用该属性修饰的函数的constant被标记为true.

**Notes:** `[[platon::constant]]`也可以使用`CONSTANT`代替.

Example:

```C++
#include <platon/platon.hpp>
using namespace platon;

class Example : public Contract {
 public:
 virtual void init() override {}

 [[platon::constant]]
 void hi(const char* name) {
   println("hello ", name);
 }

 CONSTANT void hello() {
   println("Hello, PlatON!!!")
 }
};

PLATON_ABI(Example, hi);
PLATON_ABI(Example, hello);
​```

生成的abi(**注意constant**):

```json
[
    {
        "name": "hi",
        "inputs": [
            {
                "name": "name",
                "type": "string"
            }
        ],
        "outputs": [],
        "constant": "true",
        "type": "function"
    },
    {
        "name": "hello",
        "inputs": [],
        "outputs": [],
        "constant": "true",
        "type": "function"
    }
]
​```

```

```