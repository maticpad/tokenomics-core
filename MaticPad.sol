// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "./Token.sol";
import "./NativeMetaTransaction.sol";
import "./ContentMixin.sol";

contract MATICPAD is MATICPADTOKEN, NativeMetaTransaction, ContextMixin {
    constructor() MATICPADTOKEN() {
        _initializeEIP712(name());
    }

    function _msgSender()
        internal
        view
        override
        returns (address sender)
    {
        return ContextMixin.msgSender();
    }
}
