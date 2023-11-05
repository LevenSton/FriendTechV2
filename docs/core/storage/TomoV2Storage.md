# TomoV2Storage

*Tomo Protocol*

> TomoV2Storage

This is an abstract contract that *only* contains storage for the TomoV2 contract. This *must* be inherited last (bar interfaces) in order to preserve the TomoV2 storage layout. Adding storage variables should be done solely at the bottom of this contract.



## Methods

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




