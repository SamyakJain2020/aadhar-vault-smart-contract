// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

contract store{
    struct oraganisationid{
        string name;
        //arry of participants
        string[] participants;
    }
    mapping(string => oraganisationid) oraganisations;

    function registerOrganisation(string memory org_name) public {
        // create id using builtin function
       // oraganisations[id].name = org_name;
        
    }

    function registerParticipant(string memory id,string memory pid) public{
        oraganisations[id].participants.push(pid);
    }

    function getlsOrganisation(string memory oid) public returns (oraganisationid memory) {
        //get partincipants from organosations
    }

    function getlsParticipants(string memory oid) public returns (string[] memory){
        // return line
    }
}