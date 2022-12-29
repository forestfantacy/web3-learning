// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.5.0 <0.9.0;

struct Person{

    string name;
    // string public name;  err
    uint age;
    address addr;

}

contract company{

    Person public employeePerson;

    enum State{Male,Female}

    State personState = State.Male;

    constructor(string memory _name,uint _age){
        employeePerson.name = _name;
        employeePerson.age = _age;
        employeePerson.addr = msg.sender;
    }

    function changePerson(string memory _name,uint _age,address _newaddr) public{
        if(personState == State.Male){
            return;
        }
        
        Person memory other = Person({
            name:_name,
            age:_age,
            addr:_newaddr
        });
        employeePerson = other;
    }
}

contract school{

    Person public studentPerson;

}