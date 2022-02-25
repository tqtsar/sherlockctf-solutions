const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("PeterisPrieditisAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x64A9fcaD8D299aF9B1a96dA17458c0b3D876b687" );
  const ctf = await ethers.getContractAt( "StableSwap2", "0x94f12A6fb7D9B0cBBc43CdDC6A4827649f757c72" );

  console.log("solved:", await setup.isSolved());

  await EXPLOIT.deploy(setup.address);

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
