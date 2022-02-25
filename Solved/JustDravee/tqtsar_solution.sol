pragma solidity 0.8.4;

import "./SheerLocking.sol";

contract JustDraveeAttacker {

    bytes8 constant key = 0x0100000000000102;
    
    constructor(SheerLocking instance) payable {
        
        instance.unSheerLock1{value: 24725 wei}("Bene", "dict Cumber", "batch is t", "he b", "est", key);
        instance.unSheerLock2("", "", "ice too. I waited so long for  season 4 :'( ", "Jim Moriarty is n", "", key);
        instance.unSheerLock3("The Woman", " is Missy", "", "/", "The Master in Doctor Who", key);
        instance.unSheerLock4("", "", "John Watson had a role in Ali G (Ricky C) ", "", "",  key);
        instance.unSheerLock5("Henry Cavil", "", "l: Sherlock of Ste", "el and Enola's big bro", "", key);
        instance.unSheerLock6("Sir Arthur Conan Doy", "le died in 1930, so copyright on Sher", "", "lock Holmes expired in 2000 in the UK", key);
        instance.unSheerLock7("Jonny Lee M", "iller and Lu", "", "cy Liu were a g", "ood team too!", key);

    }

    receive() external payable { }

}
