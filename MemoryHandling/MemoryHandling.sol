// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Memory {

    struct RefObj {
        uint value;
    }

    uint public hold;
    //Memory Allocation
    function memoCopy() external {
        RefObj memory o = RefObj({value: 2});
        RefObj memory o1 = o;
        o.value = 5;
        hold = o1.value;
        // Variable "hold" is equal to 5 since it has been used memory allocation
        // First is created a new space in memory with o referencing to it.
        // Then o1 points to that place in memory
        // And hence everytime we modify o or o1 value, we are accessing to the same memory address 
        // making o.value and o1.value equals always, as long they point to the same slots in memory.
    }

    function memoCopy2() external {
        RefObj memory o = RefObj({value: 2});
        RefObj memory o1 = o;
        o.value = 5;
        o = RefObj({value: 7});
        hold = o1.value;
        // Variable "hold" still is equal to 5 because o is pointing to a new created memory space, 
        // and o1 keeps pointing to the previous memory address.
    }

    // Storage Pointing
    RefObj public storageObj;
    function storagePointing() external {
        storageObj = RefObj({value: 2});
        RefObj storage o1 = storageObj;
        storageObj.value = 5;
        hold = o1.value;
        // Variable "hold" is equal to 5 since o1 is pointing to a storage memory which has been allocated 
        // in the construction of the contract. So both o1 and storageObj are pointing to the same obj 
    }

    function storagePointing2() external {
        RefObj memory o = RefObj({value: 2});
        storageObj = o;
        o.value = 5;
        hold = storageObj.value;
        // Variable "hold" is equal to 2 because when a memory object is assigned to a storage object a copy of 
        // the memory object is saved in the storage object memory address,
        // hence o and storageObj are pointing to different memory address. 
        // This happens because the storage memory is created when contract is contructed, and no new storage
        // memory can be created, that is why a copy is made to the previously storage memory allocated everytime 
        // we assign a value to a storage variable. 
    }

    function storagePointing3() external {
        storageObj = RefObj({value: 2});
        RefObj storage o1 = storageObj;
        storageObj.value = 5;
        storageObj = RefObj({value: 7});
        hold = o1.value;
        // Variable "hold" is equal to 7 since like before a copy is made to the storage memory address
        // and due o1 is pointing to that memory address, even if we assign a new value to storageObj
        // a copy is made to that memory place, making o1 and storageObj always point to the same place 
        // in memory. 
    }

    // Memory Pointing
     function memoryPointing() external {
        storageObj = RefObj({value: 2});
        RefObj memory o1 = storageObj;
        storageObj.value = 5;
        hold = o1.value;
        // Variable "hold" is equal to 2 because when a storage object is assigned to a memory object a new local memory space is 
        // created to hold a copy of the object. And so, o1 and storageObj are pointing to different memory spaces.
    }

    //Storage allocation
    RefObj public storageObj2;

    function storageAllocation() external {
        storageObj = RefObj({value: 2});
        storageObj2 = storageObj;
        storageObj.value = 5;
        hold = storageObj2.value;
        // Variable "hold" is equal to 2 because, like said before, the storage memory is created in contract construction time
        // and copies are made to that memory place everytime an assign is made. Making storageObj and storageObj2 point to 
        // different memory address. 
    }
    
}