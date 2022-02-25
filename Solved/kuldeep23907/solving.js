const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("kuldeepAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x0ABBC49482097b530516d385B4dD183b59073f1C" );
  const ctf = await ethers.getContractAt( "Challenge", "0x7DC33b58B3258a745C0ADbfC46d8A4B543254f24" );

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
