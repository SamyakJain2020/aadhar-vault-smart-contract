pragma solidity ^0.8.9;
import "@openzeppelin/contracts/utils/Strings.sol";

// Import this file to use console.log
import "hardhat/console.sol";
 struct oraganisationid{
        string name;
        address[] ORGUSER;// active inactive
        address ORGADMIN;
    }
      struct user{
        string name;
        string add;
        address wallet;
    string Aadhar_no;
    }
contract store{


//     struct Org {
// ...
// }
// mapping(address => Org) organisations;
// address[] organisationIds;

    uint randomid = 0;
    mapping(string => oraganisationid) oraganisations;
    mapping(address => user) users;
   
    function registerOrganisation(string memory org_name) public returns (string memory){
        // create id using builtin function
        
        randomid++; 
        // string memory id = Strings.toString(randomid);
        // string memory id =  Strings.toString(keccak256(abi.encodePacked(block.timestamp,org_name,randomid)));
        string memory id = string(abi.encodePacked(keccak256(abi.encodePacked(block.timestamp,org_name,randomid))));
        oraganisations[id].name = org_name;
        return id;//emit event
    }

    function registerParticipant(string memory oid,string memory pid) public {
        // oraganisations[oid].participants.push(pid);//emit event
    }

    function getlsOrganisation(string memory oid) public view returns (oraganisationid memory) {
        //get partincipants from organosations
        return oraganisations[oid];//emit event
    }

    // function getlsParticipants(string memory oid) public view returns (string[] memory){
    //     // return line
    //     return oraganisations[oid].participants;
    // }
}

/*
Q) Vault kya hota hai ?, What Functionalities can be stored in the Data Vault ?
Q) Functioning of the Data Vault ?
Q) SSI for Proxy Authentication ?
Q) Is this a Digi Locker Type thing ?
Q) Create a Source of Truth for the Data Vault -> Blockchian solution
Q) How to add data in the Data Vault in the Blockchain ? -> By consumer Agency
Q) How to check Validity of the Data in the Data Vault in the Blockchain -> No validation
Q) Which Blockcahin -> public/Private ->
Q) Prototype of the Data Vault ->
Q) OpenZeppelin Access Modifier -> For Access Control of the vault -> org Access Control given to ORGADMIN and ORGUSER(with access to the vault)
Q) Retriving access control of the vault ->



APIs:
1. SSI APIs for Rwact
2. Auth API for Server Side Authentication -> Sign a message in React 
                                           -> SuperAccess (Gov), Partisipant Access (OrgAdmin)(Data Add, Data Update)
3. We can Provide this a B(Gov)2B(Gov) Api based Service
4. We can Provide this a B(Gov)2B(User) Frontend based Txn
5. It can be implemented in any Platform


SIH:
1. Bisness Logic ,costing and scale
2. UI -> React -> USE A ADMIN THME
3. Do both the things (B2B + B2C)
4. 1st PITCH -> Ideation + Bussiness 8 min pitch -> Mockups , NonTech Stuff , Prod Functionalities -> Business Case -> 60% prod 40% TEch
5. Final Pitch -> To present it to all the Evaluators (PRE-Prepare Slides) <Blockchain , PUblic Usecase>
6. Development Eval -> Postman Output , Frontend UI Demo , <Visual IMpact> , Put Dummy Data in the BlockChain for Best USe case Senario + Partical Functioning demo
7. Final Presentation -> Presentation + Full Demo

8. IDEA SHOULD BE CONCRETE + 1 EXPERT
9. DONT SHOW -VE STUFF BUT -----> Cost Analysis -> 1 unit = ? matic -> Gas Analisis -> OR Private Blockcahin Running Cost
10. Split the Work -> Pass the Question -> Keep Each Others back
*/

