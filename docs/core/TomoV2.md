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
function _state() external view returns (enum DataTypes.TomoV2EntryPointState)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | enum DataTypes.TomoV2EntryPointState | undefined |

### _tomoSignAddress

```solidity
function _tomoSignAddress() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### buyKey

```solidity
function buyKey(DataTypes.BuyKeyData vars) external payable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| vars | DataTypes.BuyKeyData | undefined |

### getDomainSeparator

```solidity
function getDomainSeparator() external view returns (bytes32)
```

**************************** *****QUERY VIEW FUNCTIONS*** ****************************




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

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

### setGovernance

```solidity
function setGovernance(address newGovernance) external nonpayable
```

*********************** *****GOV FUNCTIONS***** ***********************



#### Parameters

| Name | Type | Description |
|---|---|---|
| newGovernance | address | undefined |

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
function setState(enum DataTypes.TomoV2EntryPointState newState) external nonpayable
```

set new state of TomoHubEntryPoint



#### Parameters

| Name | Type | Description |
|---|---|---|
| newState | enum DataTypes.TomoV2EntryPointState | new state |

### setTomoSignAddress

```solidity
function setTomoSignAddress(address newTomoSignAddress) external nonpayable
```

set new tomo sign fee address



#### Parameters

| Name | Type | Description |
|---|---|---|
| newTomoSignAddress | address | new tomo-sign address |

### whitelistCurveModule

```solidity
function whitelistCurveModule(address curveModule, bool whitelist) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| curveModule | address | undefined |
| whitelist | bool | undefined |



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

### ProcotolFeeAddressSet

```solidity
event ProcotolFeeAddressSet(address indexed caller, address indexed prevProcotolFeeAddress, address indexed newProcotolFeeAddress, uint256 timestamp)
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
event StateSet(address indexed caller, enum DataTypes.TomoV2EntryPointState indexed prevState, enum DataTypes.TomoV2EntryPointState indexed newState, uint256 timestamp)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| caller `indexed` | address | undefined |
| prevState `indexed` | enum DataTypes.TomoV2EntryPointState | undefined |
| newState `indexed` | enum DataTypes.TomoV2EntryPointState | undefined |
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



## Errors

### CannotInitImplementation

```solidity
error CannotInitImplementation()
```






### CurveModuleNotWhitelisted

```solidity
error CurveModuleNotWhitelisted()
```






### Initialized

```solidity
error Initialized()
```






### InsufficientKeyAmount

```solidity
error InsufficientKeyAmount()
```






### NotGovernance

```solidity
error NotGovernance()
```






### Paused

```solidity
error Paused()
```






### SubjectAlreadyInitial

```solidity
error SubjectAlreadyInitial()
```






### SubjectNotInitial

```solidity
error SubjectNotInitial()
```






