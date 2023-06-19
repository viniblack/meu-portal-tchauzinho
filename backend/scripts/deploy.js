const main = async () => {
    const [deployer] = await hre.ethers.getSigners();
    // 
    let provider = ethers.getDefaultProvider();
    const accountBalance = await provider.getBalance(deployer.address);

    console.log("Deploying contracts with account: ", deployer.address);
    console.log("Account balance: ", accountBalance.toString());

    const Token = await hre.ethers.deployContract("WavePortal");
    const portal = await Token.waitForDeployment();

    console.log("WavePortal address: ", portal.target);
};

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});