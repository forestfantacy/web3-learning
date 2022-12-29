// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.5.0 <0.9.0;

contract C1{

    string[] public students = ["tom","mary","bob"];

    function changeByMemory() public view{

        string[] memory memoryStus = students;
        memoryStus[2] = "jenny";

    }

        function changeByStorage() public{

        string[] storage memoryStus = students;
        memoryStus[2] = "jenny";

    }
}