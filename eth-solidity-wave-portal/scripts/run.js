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

    // calling the function wave() and storing the result
    let waveTxn = await waveContract.wave();
    await waveTxn.wait();

    // logging the new value of the variable waveCount
    waveCount = await waveContract.getTotalWaves();

    // caling the function wave() again and storing the result
    waveTxn = await waveContract.connect(randomPerson).wave();
    await waveTxn.wait();

    // logging the new value of the variable waveCount
    waveCount = await waveContract.getTotalWaves()
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