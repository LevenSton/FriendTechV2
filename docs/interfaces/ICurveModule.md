# ICurveModule

*Tomo Protocol*

> ICurveModule

This is base interface contract for all curve module contracts



## Methods

### getBuyPrice

```solidity
function getBuyPrice(address subjectAddress, uint256 amount) external nonpayable returns (uint256)
```

get the price of buy amount key



#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | Address of subject |
| amount | uint256 | buy amount |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getSellPrice

```solidity
function getSellPrice(address subjectAddress, uint256 amount) external nonpayable returns (uint256)
```

get the price of sell amount key



#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | Address of subject |
| amount | uint256 | sell amount |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### initializeCurveModule

```solidity
function initializeCurveModule(address subjectAddress, bytes data) external nonpayable returns (bytes)
```

Initial curve when initial subject.



#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | Address of subject |
| data | bytes | the initial data for curve |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bytes | undefined |

### processBuy

```solidity
function processBuy(address subjectAddress, uint256 amount, uint256 msgValue) external nonpayable returns (uint256, uint256, uint256, uint256)
```

Check if can buy success from the rule of curve.



#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | Address of subject |
| amount | uint256 | the buy amount |
| msgValue | uint256 | the eth amount user used to buy |

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

Check if can sell success from the rule of curve.



#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | Address of subject |
| amount | uint256 | the buy amount |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |
| _1 | uint256 | undefined |
| _2 | uint256 | undefined |

### processTransfer

```solidity
function processTransfer() external nonpayable returns (bool)
```

return if key can transfer or not.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### setCustomizeFeePercent

```solidity
function setCustomizeFeePercent(address subjectAddress, uint256 newProtocolFeePercent, uint256 newSubjectFeePercent) external nonpayable
```

set customize fee percent for KOL, only can be called from TomoV2 contract



#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | Address of subject |
| newProtocolFeePercent | uint256 | the new protocol fee percent |
| newSubjectFeePercent | uint256 | the new subject fee percent |

### setFeePercent

```solidity
function setFeePercent(uint256 newProtocolFeePercent, uint256 newSubjectFeePercent) external nonpayable
```

set normal fee percent for users



#### Parameters

| Name | Type | Description |
|---|---|---|
| newProtocolFeePercent | uint256 | the new protocol fee percent |
| newSubjectFeePercent | uint256 | the new subject fee percent |

### setSubPrice

```solidity
function setSubPrice(address subjectAddress, uint256 price) external nonpayable
```

set a new subscribe price by subject owner. only support const curve module



#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectAddress | address | Address of subject |
| price | uint256 | the new price |




