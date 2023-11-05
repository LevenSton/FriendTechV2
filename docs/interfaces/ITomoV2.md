# ITomoV2

*Tomo Protocol*

> ITomoV2

This is the entrypoint contract for the TomoV2 contract, the main entry point for Create/Buy/Sell Key. You&#39;ll find all the events and external functions, as well as the reasoning behind them here.



## Methods

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

*********************** *****VIEW FUNCTIONS***** ***********************




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



