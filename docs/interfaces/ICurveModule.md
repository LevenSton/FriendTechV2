# ICurveModule

*Tomo Protocol*

> ICurveModule

This is base interface contract for all curve module contracts



## Methods

### getBuyPrice

```solidity
function getBuyPrice(address subjectAddress, uint256 amount) external nonpayable returns (uint256)
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
function getSellPrice(address subjectAddress, uint256 amount) external nonpayable returns (uint256)
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
function initializeCurveModule(address subjectOwner, bytes data) external nonpayable returns (bytes)
```

initialize smart contract.



#### Parameters

| Name | Type | Description |
|---|---|---|
| subjectOwner | address | The address of subject |
| data | bytes | The initial data for his curve |

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




