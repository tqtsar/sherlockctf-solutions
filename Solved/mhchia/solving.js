const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("mhchiaAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x6c06959586640De3BcdE69BDcEbF2efDa5d3983B" );
  const ctf = await ethers.getContractAt( "CrowdFunding", "0xC2c83168E3bf85A5DEabF25f9f9873085C201C79" );

  console.log("solved:", await setup.isSolved());

  await EXPLOIT.deploy(ctf.address, { value: 3 });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
