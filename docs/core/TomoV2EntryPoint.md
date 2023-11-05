# TomoV2EntryPoint









## Methods

### _globalLockIndex

```solidity
function _globalLockIndex() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### _governance

```solidity
function _governance() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### _indexToVotePassLockInfo

```solidity
function _indexToVotePassLockInfo(uint256) external view returns (bytes32 subject, uint256 amount, uint256 lockUntil, address owner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| subject | bytes32 | undefined |
| amount | uint256 | undefined |
| lockUntil | uint256 | undefined |
| owner | address | undefined |

### _minPriceKeyCanFragment

```solidity
function _minPriceKeyCanFragment() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

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

### _subjectToFragmentPool

```solidity
function _subjectToFragmentPool(bytes32) external view returns (bytes32 subject, uint256 holdAmount, address poolCreator, address fragmentPoolAddress)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| subject | bytes32 | undefined |
| holdAmount | uint256 | undefined |
| poolCreator | address | undefined |
| fragmentPoolAddress | address | undefined |

### initialize

```solidity
function initialize(address governanceContractAddress, address protocolFeeAddress) external nonpayable
```

initialize smart contract.



#### Parameters

| Name | Type | Description |
|---|---|---|
| governanceContractAddress | address | The governance address to set. |
| protocolFeeAddress | address | The protocol fee address to set. |

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



## Events

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



## Errors

### CannotInitImplementation

```solidity
error CannotInitImplementation()
```






### InitParamsInvalid

```solidity
error InitParamsInvalid()
```






### Initialized

```solidity
error Initialized()
```






### NotGovernance

```solidity
error NotGovernance()
```







