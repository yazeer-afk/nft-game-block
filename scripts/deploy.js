const run = async () => {

    const nameList = ['Hu Tao', 'Itto', 'Sucrose']
    const imageList = [
        'https://static.wikia.nocookie.net/gensin-impact/images/5/50/Character_Hu_Tao_Portrait.png/revision/latest?cb=20210227222357',
        'https://static.wikia.nocookie.net/gensin-impact/images/a/ae/Character_Arataki_Itto_Game.png/revision/latest?cb=20211214145927',
        'https://static.wikia.nocookie.net/gensin-impact/images/d/d1/Character_Yae_Miko_Game.png/revision/latest?cb=20220218065514'
    ]

    const hpList = [100, 200, 300]
    const atkList = [100, 50, 25]  

    const gameContractFactory = await hre.ethers.getContractFactory("EpicNFTGame")
    const gameContract = await gameContractFactory.deploy(nameList, imageList, hpList, atkList)
    await gameContract.deployed()

    console.log("Contract deployed to: ", gameContract.address)

    let txn;
    txn = await gameContract.mintCharacter(2)
    txn.wait()

    const returnedToken = await gameContract.tokenURI(2)
    console.log("Token URI", returnedToken)
}

const bootstrap = async () => {

    try {
        await run()
        process.exit(0)
    } catch (err) {
        console.log(err)
        process.exit(1)
    }
}

bootstrap()