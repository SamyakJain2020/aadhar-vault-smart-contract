// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.9;

// // Import this file to use console.log
// import "hardhat/console.sol";

// contract store{
//     struct oraganisationid{
//         string name;
//         //arry of participants
//         string[] participants;
//     }
//     mapping(string => oraganisationid) oraganisations;

//     function registerOrganisation(string memory org_name) public {
//         // create id using builtin function
//        // oraganisations[id].name = org_name;
        
//     }

//     function registerParticipant(string memory id,string memory pid) public{
//         oraganisations[id].participants.push(pid);
//     }

//     function getlsOrganisation(string memory oid) public returns (oraganisationid memory) {
//         //get partincipants from organosations
//     }

//     function getlsParticipants(string memory oid) public returns (string[] memory){
//         // return line
//     }
// }

pragma solidity ^0.8.9;
import "@openzeppelin/contracts/utils/Strings.sol";

// Import this file to use console.log
import "hardhat/console.sol";

contract store{
    uint randomid = 0;
    struct oraganisationid{
        string name;
        string[] participants;
    }
    mapping(string => oraganisationid) oraganisations;

    function registerOrganisation(string memory org_name) public returns (string memory){
        // create id using builtin function
        
        randomid++; 
        // string memory id = Strings.toString(randomid);
        // string memory id =  Strings.toString(keccak256(abi.encodePacked(block.timestamp,org_name,randomid)));
        string memory id = string(abi.encodePacked(keccak256(abi.encodePacked(block.timestamp,org_name,randomid))));
        oraganisations[id].name = org_name;
        return id;
    }

    function registerParticipant(string memory oid,string memory pid) public {
        oraganisations[oid].participants.push(pid);
    }

    function getlsOrganisation(string memory oid) public view returns (oraganisationid memory) {
        //get partincipants from organosations
        return oraganisations[oid];
    }

    function getlsParticipants(string memory oid) public view returns (string[] memory){
        // return line
        return oraganisations[oid].participants;
    }
}