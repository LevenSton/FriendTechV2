// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

library Errors {
    error Paused();
    error NotGovernance();
    error CannotInitImplementation();
    error Initialized();
    error SignatureInvalid();
    error CurveModuleNotWhitelisted();
    error SubjectAlreadyInitial();
    error NotTomoV2();
    error InitParamsInvalid();
    error SubjectNotInitial();
    error InsufficientKeyAmount();
    error MsgValueNotEnough();
    error ReferralRatioTooHigh();
    error FeePercentTooHigh();
    error NotSupportFunction();
    error ExceedMaxAcceptPrice();
    error EthValueNotEnough();
    error ConstCurveCanSell();
    error LessThanMinAcceptPrice();
}
