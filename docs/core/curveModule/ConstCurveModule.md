# ConstCurveModule









## Methods

### TOMOV2

```solidity
function TOMOV2() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### getBuyPrice

```solidity
function getBuyPrice(address subjectAddress, uint256 amount) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | undefined |
| amount | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getSellPrice

```solidity
function getSellPrice(address subjectAddress, uint256 amount) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | undefined |
| amount | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### initializeCurveModule

```solidity
function initializeCurveModule(address subjectAddress, bytes data) external nonpayable returns (bytes)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | undefined |
| data | bytes | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes | undefined |

### processBuy

```solidity
function processBuy(address subjectAddress, uint256 amount, uint256 msgValue) external nonpayable returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | undefined |
| amount | uint256 | undefined |
| msgValue | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### processSell

```solidity
function processSell(address subjectAddress, uint256 amount) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | undefined |
| amount | uint256 | undefined |



## Events

### ModuleBaseConstructed

```solidity
event ModuleBaseConstructed(address indexed tomoV2, uint256 timestamp)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| tomoV2 `indexed` | address | undefined |
| timestamp  | uint256 | undefined |



## Errors

### InitParamsInvalid

```solidity
error InitParamsInvalid()
```






### NotTomoV2

```solidity
error NotTomoV2()
```







