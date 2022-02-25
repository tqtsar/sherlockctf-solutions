const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("Baraa42Attacker");

  const setup = await ethers.getContractAt( "Setup", "0xFfb20eF6668F8160934FD84b60F3DeD127F787Aa" );
  const ctf = await ethers.getContractAt( "Casino", "0x664152c40e3ba69f3791dd07edb6dbf4444ccf23" );

  console.log("solved:", await setup.isSolved());

  await EXPLOIT.deploy(ctf.address, { value: parseEther("1") });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
