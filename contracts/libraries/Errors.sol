// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

library Errors {
    error Paused();
    error NotGovernance();
    error CannotInitImplementation();
    error Initialized();
    error InitParamsInvalid();
}
