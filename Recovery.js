var getContractAddress = require("@ethersproject/address").getContractAddress;
var recoverAddress = getContractAddress({
  from: "0x7162416EA8CeB7f6556511436876526dE9c87d0d", // Instance address.
  nonce: 1, // Because it is the first transaction.
});

console.log(recoverAddress);
