const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("hack3r0mAttacker");

  const setup = await ethers.getContractAt( "Setup", "0xA083913ed673b23dC5FB921b3909021CacFD794C" );
  const ctf = await ethers.getContractAt( "BitMania", "0x16051547CbaD42bBec882A7E9e6091796d0D1f50" );

  console.log("solved:", await setup.isSolved());

  await EXPLOIT.deploy(ctf.address);

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
