const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("band0xAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x46C9489797c5647F850dD3A5bcB13C240bcd383A" );
  const ctf = await ethers.getContractAt( "BecomeMaster", "0xD2034a50C5Adc8A190D4f8c8EE18643Ab8A0ff05" );

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
