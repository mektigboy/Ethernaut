var bytecode = "600a600c600039600a6000f3602a60505260206050f3";
var txn = await web3.eth.sendTransaction({ from: player, data: bytecode });
var solverAddress = txn.contractAddress;
await contract.setSolver(solverAddress);
