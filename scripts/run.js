const main = async () => {
    const waveContract = await hre.ethers.deployContract("WavePortal");
    await waveContract.waitForDeployment();
    console.log("Contract deployed to:", waveContract.target);
};

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});