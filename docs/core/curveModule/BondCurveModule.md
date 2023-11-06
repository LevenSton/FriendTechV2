# BondCurveModule

*tomo Protocol*

> BondCurveModule

This is a bonding curve contract, the key price increase model according bond curve.



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
function processBuy(address subjectAddress, uint256 amount, uint256 msgValue) external nonpayable returns (uint256, uint256, uint256, uint256)
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
| _1 | uint256 | undefined |
| _2 | uint256 | undefined |
| _3 | uint256 | undefined |

### processSell

```solidity
function processSell(address subjectAddress, uint256 amount) external nonpayable returns (uint256, uint256, uint256)
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
| _1 | uint256 | undefined |
| _2 | uint256 | undefined |

### setFeePercent

```solidity
function setFeePercent(uint256 newProtocolFeePercent, uint256 newSubjectFeePercent) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newProtocolFeePercent | uint256 | undefined |
| newSubjectFeePercent | uint256 | undefined |

### setSubPrice

```solidity
function setSubPrice(address subjectAddress, uint256 price) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | undefined |
| price | uint256 | undefined |



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






### MsgValueNotEnough

```solidity
error MsgValueNotEnough()
```






### NotSupportFunction

```solidity
error NotSupportFunction()
```






### NotTomoV2

```solidity
error NotTomoV2()
```






### ReferralRatioTooHigh

```solidity
error ReferralRatioTooHigh()
```







