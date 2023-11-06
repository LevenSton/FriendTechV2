# TomoV2









## Methods

### BUY_TYPEHASH

```solidity
function BUY_TYPEHASH() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### EIP712_DOMAIN_TYPEHASH

```solidity
function EIP712_DOMAIN_TYPEHASH() external view returns (bytes32)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### _governance

```solidity
function _governance() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### _keySubjectInfo

```solidity
function _keySubjectInfo(address) external view returns (uint256 supply, address curveModule)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| supply | uint256 | undefined |
| curveModule | address | undefined |

### _protocolFeeAddress

```solidity
function _protocolFeeAddress() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### _state

```solidity
function _state() external view returns (enum DataTypes.TomoV2State)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | enum DataTypes.TomoV2State | undefined |

### _tomoSignAddress

```solidity
function _tomoSignAddress() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### balanceOf

```solidity
function balanceOf(address subject, address holder) external view returns (uint256)
```

get balance of subject the holder hold



#### Parameters

| Name | Type | Description |
|---|---|---|
| subject | address | the subject address |
| holder | address | the holder address |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### buyKey

```solidity
function buyKey(DataTypes.BuyKeyData vars) external payable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| vars | DataTypes.BuyKeyData | undefined |

### getCurveModuleAddress

```solidity
function getCurveModuleAddress(address subject) external view returns (address)
```

get curve module address of the subject



#### Parameters

| Name | Type | Description |
|---|---|---|
| subject | address | the subject address |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### getDomainSeparator

```solidity
function getDomainSeparator() external view returns (bytes32)
```

get domain separator




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

### getSupply

```solidity
function getSupply(address subject) external view returns (uint256)
```

get subject supply



#### Parameters

| Name | Type | Description |
|---|---|---|
| subject | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### initialSubject

```solidity
function initialSubject(DataTypes.InitialSubjectData vars) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| vars | DataTypes.InitialSubjectData | undefined |

### initialize

```solidity
function initialize(address governanceContractAddress, address protocolFeeAddress, address tomoSignAddress) external nonpayable
```

initialize smart contract.



#### Parameters

| Name | Type | Description |
|---|---|---|
| governanceContractAddress | address | The governance address to set. |
| protocolFeeAddress | address | The protocol fee address to set. |
| tomoSignAddress | address | The sign address of tomo. |

### sellKey

```solidity
function sellKey(DataTypes.SellKeyData vars) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| vars | DataTypes.SellKeyData | undefined |

### setCurveFeePercent

```solidity
function setCurveFeePercent(address curveModuleAddress, uint256 newProtocolFeePercent, uint256 newSubjectFeePercent) external nonpayable
```

change fee percentage of curve contract



#### Parameters

| Name | Type | Description |
|---|---|---|
| curveModuleAddress | address | address of curve contract |
| newProtocolFeePercent | uint256 | new percentage of protocol |
| newSubjectFeePercent | uint256 | new percentage of subject |

### setCustomizeFeePercent

```solidity
function setCustomizeFeePercent(address curveModuleAddress, address subjectAddress, uint256 newProtocolFeePercent, uint256 newSubjectFeePercent) external nonpayable
```

set customize fee percent for KOL



#### Parameters

| Name | Type | Description |
|---|---|---|
| curveModuleAddress | address | address of curve contract |
| subjectAddress | address | Address of subject |
| newProtocolFeePercent | uint256 | the new protocol fee percent |
| newSubjectFeePercent | uint256 | the new subject fee percent |

### setGovernance

```solidity
function setGovernance(address newGovernance) external nonpayable
```

set new governance address



#### Parameters

| Name | Type | Description |
|---|---|---|
| newGovernance | address | new address |

### setProtocolFeeAddress

```solidity
function setProtocolFeeAddress(address newProtocolFeeAddress) external nonpayable
```

set new protocol fee address



#### Parameters

| Name | Type | Description |
|---|---|---|
| newProtocolFeeAddress | address | new fee address |

### setState

```solidity
function setState(enum DataTypes.TomoV2State newState) external nonpayable
```

set new state of TomoHubEntryPoint



#### Parameters

| Name | Type | Description |
|---|---|---|
| newState | enum DataTypes.TomoV2State | new state |

### setTomoSignAddress

```solidity
function setTomoSignAddress(address newTomoSignAddress) external nonpayable
```

set new tomo sign fee address



#### Parameters

| Name | Type | Description |
|---|---|---|
| newTomoSignAddress | address | new tomo-sign address |

### transferKey

```solidity
function transferKey(DataTypes.TransferKeyData vars) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| vars | DataTypes.TransferKeyData | undefined |

### whitelistCurveModule

```solidity
function whitelistCurveModule(address curveModule, bool whitelist) external nonpayable
```

set whitelist curve module address



#### Parameters

| Name | Type | Description |
|---|---|---|
| curveModule | address | address of curve contract |
| whitelist | bool | whitelist or not |



## Events

### CurveModuleWhitelisted

```solidity
event CurveModuleWhitelisted(address indexed curveModule, bool whitelist, uint256 timestamp)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| curveModule `indexed` | address | undefined |
| whitelist  | bool | undefined |
| timestamp  | uint256 | undefined |

### GovernanceSet

```solidity
event GovernanceSet(address indexed caller, address indexed prevGovernance, address indexed newGovernance, uint256 timestamp)
```



*Emitted when the governance address is changed. We emit the caller even though it should be the previous governance address, as we cannot guarantee this will always be the case due to upgradeability.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| caller `indexed` | address | The caller who set the governance address. |
| prevGovernance `indexed` | address | The previous governance address. |
| newGovernance `indexed` | address | The new governance address set. |
| timestamp  | uint256 | The current block timestamp. |

### ProtocolFeeAddressSet

```solidity
event ProtocolFeeAddressSet(address indexed caller, address indexed prevProcotolFeeAddress, address indexed newProcotolFeeAddress, uint256 timestamp)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| caller `indexed` | address | undefined |
| prevProcotolFeeAddress `indexed` | address | undefined |
| newProcotolFeeAddress `indexed` | address | undefined |
| timestamp  | uint256 | undefined |

### StateSet

```solidity
event StateSet(address indexed caller, enum DataTypes.TomoV2State indexed prevState, enum DataTypes.TomoV2State indexed newState, uint256 timestamp)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| caller `indexed` | address | undefined |
| prevState `indexed` | enum DataTypes.TomoV2State | undefined |
| newState `indexed` | enum DataTypes.TomoV2State | undefined |
| timestamp  | uint256 | undefined |

### TomoSignAddressSet

```solidity
event TomoSignAddressSet(address indexed caller, address indexed prevTomoSignAddress, address indexed newTomoSignAddress, uint256 timestamp)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| caller `indexed` | address | undefined |
| prevTomoSignAddress `indexed` | address | undefined |
| newTomoSignAddress `indexed` | address | undefined |
| timestamp  | uint256 | undefined |

### TradeKeySuccess

```solidity
event TradeKeySuccess(address trader, address subjectAddress, address referralAddress, uint256 amount, uint256 price, uint256 timestamp, bool isBuy)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| trader  | address | undefined |
| subjectAddress  | address | undefined |
| referralAddress  | address | undefined |
| amount  | uint256 | undefined |
| price  | uint256 | undefined |
| timestamp  | uint256 | undefined |
| isBuy  | bool | undefined |

### TransferKeySuccess

```solidity
event TransferKeySuccess(address from, address to, address subject, uint256 amount, uint256 timestamp)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| from  | address | undefined |
| to  | address | undefined |
| subject  | address | undefined |
| amount  | uint256 | undefined |
| timestamp  | uint256 | undefined |



## Errors

### CannotInitImplementation

```solidity
error CannotInitImplementation()
```






### CurveModuleNotWhitelisted

```solidity
error CurveModuleNotWhitelisted()
```






### EthValueNotEnough

```solidity
error EthValueNotEnough()
```






### ExceedMaxAcceptPrice

```solidity
error ExceedMaxAcceptPrice()
```






### FeePercentTooHigh

```solidity
error FeePercentTooHigh()
```






### Initialized

```solidity
error Initialized()
```






### InsufficientKeyAmount

```solidity
error InsufficientKeyAmount()
```






### LessThanMinAcceptPrice

```solidity
error LessThanMinAcceptPrice()
```






### NotGovernance

```solidity
error NotGovernance()
```






### Paused

```solidity
error Paused()
```






### SignatureInvalid

```solidity
error SignatureInvalid()
```






### SubjectAlreadyInitial

```solidity
error SubjectAlreadyInitial()
```






### SubjectNotInitial

```solidity
error SubjectNotInitial()
```






### TransferNotSupport

```solidity
error TransferNotSupport()
```







