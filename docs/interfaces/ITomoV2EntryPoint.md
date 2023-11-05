# ITomoV2EntryPoint

*Tomo Protocol*

> ITomoV2EntryPoint

This is the entrypoint contract for the TomoV2 contract, the main entry point for Create/Buy/Sell Key. You&#39;ll find all the events and external functions, as well as the reasoning behind them here.



## Methods

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




