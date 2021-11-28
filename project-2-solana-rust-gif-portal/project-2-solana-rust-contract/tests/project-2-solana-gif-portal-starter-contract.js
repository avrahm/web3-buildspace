const anchor = require('@project-serum/anchor');

const main = async () => {
  console.log("Starting test ...");
// tell Anchor to set our provider. this data comes from solana config get
  anchor.setProvider(anchor.Provider.env());
  
  // automatically compile lib.rs and deploy to a validator
  const program = anchor.workspace.Project2SolanaGifPortalStarterContract;

  // we call our function and await for a validator to "mine" the instruction
  const transaction = await program.rpc.startStuffOff();

  console.log("Transaction:", transaction);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();
