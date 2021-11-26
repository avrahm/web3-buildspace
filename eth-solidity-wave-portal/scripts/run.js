const main = async () => {
    // storing the address of the owner of the contract and a random account
    const [owner, randomPerson] = await hre.ethers.getSigners();

    // create a new contract instance
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    waveContract.deployed();

    // logging the address of the contract and owner 
    console.log("Deployed WavePortal contract to: " + waveContract.address);
    console.log("Owner:", owner.address);

    // waiting for the total waves from the contract and setting the value to the variable waveCount
    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log("Retrieved total gm count...", waveCount.toNumber());

    // execute a wave() transaction on the contract to test the messages
    let waveTxn = await waveContract.wave('This is your first message on Blockchain!');
    await waveTxn.wait(); // Wait for the transaction to be mined

    //send another test message using a random address
    waveTxn = await waveContract.connect(randomPerson).wave("What what! Let's GO!");
    await waveTxn.wait(); // Wait for the transaction to be mined

    // log the messages from the contract
    let allWaveMsgs = await waveContract.getAllWaveMsgs();
    console.log(allWaveMsgs);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.error(error);
        process.exit(1);
    }
}

runMain();