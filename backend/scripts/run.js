const main = async () => {
    const waveContract = await hre.ethers.deployContract("WavePortal");
    await waveContract.waitForDeployment();
    console.log("Contract deployed to:", waveContract.target);

    let waveCount = await waveContract.getTotalWaves();
    console.log(parseInt(waveCount))

    /**
     * Deixe-me enviar alguns tchauzinhos!
     */
    let waveTxn = await waveContract.wave("Uma mensagem!");
    await waveTxn.wait(); // aguarda a transação ser minerada

    const [_, randomPerson] = await hre.ethers.getSigners();
    waveTxn = await waveContract.connect(randomPerson).wave("Outra mensagem!");
    await waveTxn.wait(); // aguarda a transação ser minerada

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);
};

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});