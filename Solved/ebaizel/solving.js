const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("ebaizelAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x5364B5A9e489b495CaAE4722e9706C817Cf54433" );
  const ctf = await ethers.getContractAt( "PixelPavel", "0x784B7A7A25ED38EF830AEFe7985c64f3AdF08346" );

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
