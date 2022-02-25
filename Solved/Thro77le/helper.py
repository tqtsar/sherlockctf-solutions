from web3 import Web3

# goerli
deployingAddr = "FD4f30C20dA65a37fd74d55B257442a08469e6A6"
addrbytes = bytes.fromhex(deployingAddr)
bytecode = "6080604052348015600f57600080fd5b50603f80601d6000396000f3fe6080604052600080fdfea264697066735822122051263de48b020bfd029cc7b233b6549029f593de824f0aec76af62fef252447264736f6c63430008040033"
           
hashbytecode = Web3.keccak(hexstr=bytecode)
salt = 1

header = bytes.fromhex("ff") + addrbytes

while 1:
    salthex = Web3.toHex(salt)[2:]
    saltbytes = '0' * (64 - len(salthex)) + salthex

    predicted = Web3.toHex(Web3.keccak( header + bytes.fromhex(saltbytes) + hashbytecode))[-40:]

    if "f0b1d" in predicted:
        print("0x" + predicted)
        print(saltbytes)
        exit()
    else:
        salt = salt+1