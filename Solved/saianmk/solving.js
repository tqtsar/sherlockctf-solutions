const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("saianmkAttacker");

  const setup = await ethers.getContractAt( "Setup", "0xbFB2C43021629C87b83C97F1FAC8D5f6b1078593" );
  const ctf = await ethers.getContractAt( "Combination", "0xB5193e99607e7e63B49ACC48fCe0AC7A3676e4F6" );

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
