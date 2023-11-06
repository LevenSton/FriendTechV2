// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

//import {ILensNFTBase} from "../../interfaces/ILensNFTBase.sol";
import {Errors} from "../../libraries/Errors.sol";
import {DataTypes} from "../../libraries/DataTypes.sol";
import {Events} from "../../libraries/Events.sol";

/**
 * @title TomoV2Base
 * @author tomo Protocol
 *
 * @notice This is an abstract base contract to be inherited by TomoV2 contract, it includes all function that can verify the signature of tomo
 * verify signature by tomo.
 */
abstract contract TomoV2Base {
    bytes32 private constant DOMAIN_NAME = keccak256("Tomo");
    bytes32 internal constant EIP712_REVISION_HASH = keccak256("1");
    bytes32 public constant BUY_TYPEHASH =
        keccak256(
            abi.encodePacked(
                "BuyKey(address subject,address sender,uint256 amount)"
            )
        );
    bytes32 public constant EIP712_DOMAIN_TYPEHASH =
        keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );

    /**
     * @dev Wrapper for ecrecover to reduce code size, used in meta-tx specific functions.
     */
    function _validateRecoveredAddress(
        bytes32 digest,
        address expectedAddress,
        DataTypes.EIP712Signature calldata sig
    ) internal pure {
        address recoveredAddress = ecrecover(digest, sig.v, sig.r, sig.s);
        if (
            recoveredAddress == address(0) ||
            recoveredAddress != expectedAddress
        ) revert Errors.SignatureInvalid();
    }

    /**
     * @dev Calculates EIP712 DOMAIN_SEPARATOR based on the current contract and chain ID.
     */
    function _calculateDomainSeparator() internal view returns (bytes32) {
        return
            keccak256(
                abi.encode(
                    EIP712_DOMAIN_TYPEHASH,
                    DOMAIN_NAME,
                    EIP712_REVISION_HASH,
                    block.chainid,
                    address(this)
                )
            );
    }

    /**
     * @dev Calculates EIP712 digest based on the current DOMAIN_SEPARATOR.
     *
     * @param hashedMessage The message hash from which the digest should be calculated.
     *
     * @return bytes32 A 32-byte output representing the EIP712 digest.
     */
    function _calculateDigest(
        bytes32 hashedMessage
    ) internal view returns (bytes32) {
        bytes32 digest;
        unchecked {
            digest = keccak256(
                abi.encodePacked(
                    "\x19\x01",
                    _calculateDomainSeparator(),
                    hashedMessage
                )
            );
        }
        return digest;
    }
}
