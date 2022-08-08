// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// for Hardhat
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

//for remix
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

enum Status {
    ACTIVE,
    INACTIVE
}

//  Status = [ACTIVE, INACTIVE]

struct ORG {
    string ORGNAME;
    uint256 ORGID;
    mapping(address => Status) ORGUSERS;
    mapping(address => Status) ORGADMINS;
    address[] users;
    address[] admins;
}

struct user {
    string name;
    address ad;
    string AadharRef;
}

contract DataVault is AccessControl{
    mapping(uint256 => ORG) oraganisations;
    uint256[] organisationIds;

    mapping(address => user) users;
    address[] usersIds;

    event OrganisationRegistered(uint256 orgid, string orgname);
    event UserRegistered(address user, string name, string AadharRef);

    modifier isAdmin(uint256 id) {
        require(
            msg.sender == address(this) &&
                oraganisations[id].ORGADMINS[msg.sender] == Status.ACTIVE,
            "User Not an Active Organisation Admin"
        );
        _;
    }
    modifier isActiveUser(uint256 id) {
        require(
            msg.sender == address(this) &&
                oraganisations[id].ORGUSERS[msg.sender] == Status.ACTIVE,
            "User Not an Active Organisation User"
        );
        _;
    }
    modifier isActive(uint256 id) {
        require(
            oraganisations[id].ORGUSERS[msg.sender] == Status.ACTIVE ||
                oraganisations[id].ORGADMINS[msg.sender] == Status.ACTIVE,
            "User Not an Active Organisation User or Admin"
        );
        _;
    }

    function registerOrganisation(string memory org_name)
        public
        returns (uint256)
    {
        organisationIds.push();
        uint256 index = organisationIds.length - 1;
        address admin = msg.sender;

        oraganisations[index].ORGNAME = org_name;
        oraganisations[index].ORGID = organisationIds.length;
        oraganisations[index].ORGUSERS[admin] = Status.ACTIVE;
        oraganisations[index].ORGADMINS[admin] = Status.ACTIVE;
        oraganisations[index].users.push(admin);
        oraganisations[index].admins.push(admin);
        organisationIds[index] = organisationIds.length;

        emit OrganisationRegistered(oraganisations[index].ORGID, org_name);
        return oraganisations[index].ORGID;
    }

    // organistion active ORGADMIN can add to ORGUSERS to the organisation
    function addOrgUser(uint256 id, address user)
        public
        isAdmin(id)
        returns (bool)
    {
        // using modifier to check if user is admin
        oraganisations[id].ORGUSERS[user] = Status.ACTIVE;
        oraganisations[id].users.push(user);
        emit UserRegistered(user, users[user].name, users[user].AadharRef);
        return true;
    }

    // organistion active ORGADMIN can add to ORGADMINS to the organisation
    function addOrgAdmin(uint256 id, address admin)
        public
        isAdmin(id)
        returns (bool)
    {
        // using modifier to check if user is admin
        oraganisations[id].ORGADMINS[admin] = Status.ACTIVE;
        oraganisations[id].admins.push(admin);
        return true;
    }

    // Register User with custom Aadhar Reference
    function registerUser(string memory name, string memory AadharRef)
        public
        returns (address)
    {
        usersIds.push();
        uint256 index = usersIds.length - 1;
        address user = msg.sender;
        users[user].name = name;
        users[user].ad = user;
        users[user].AadharRef = AadharRef;
        usersIds[index] = user;
        emit UserRegistered(user, name, AadharRef);
        return usersIds[index];
    }

    // Register User with default Aadhar Reference as msg.sender (User Wallet Address)
    function registerUser(string memory name) public returns (address) {
        usersIds.push();
        uint256 index = usersIds.length - 1;
        address user = msg.sender;
        users[user].name = name;
        users[user].ad = user;

        // TODO BY @raenyx AND SOHAM
        users[user].AadharRef = ""; // to convert address(msg.sender) to string

        usersIds[index] = user;
        emit UserRegistered(user, name, users[user].AadharRef);
        return usersIds[index];
    }

    // fetching user details using user address/id
    function getUser(address a) public view returns (user memory) {
        return users[a];
    }

    // fetching user aadharRef using user address/id
    function getUserAadharRef(address a) public view returns (string memory) {
        return users[a].AadharRef;
    }

    //get all orgusers of an organisation
    function getAllOrgUsers(uint256 id) public view returns (address[] memory) {
        return oraganisations[id].users;
    }

    //get all orgadmins of an organisation
    function getAllOrgAdmins(uint256 id)
        public
        view
        returns (address[] memory)
    {
        return oraganisations[id].admins;
    }

    // get all organisations in the system
    function getAllOrganisations() public view returns (uint256[] memory) {
        return organisationIds;
    }

    // get all users in the system
    function getAllUsers() public view returns (address[] memory) {
        return usersIds;
    }

    // Function IsUserRegisteredForOrganization -> Check if the user is registered for the organisation
    function isUserRegisteredForOrganization(uint256 id, address user)
        public
        view
        returns (bool)
    {
        return oraganisations[id].ORGUSERS[user] == Status.ACTIVE;
    }
    
    //function to set user inactive only done by admin @raenyx @soham
    //function to set admin inactive Only done by admin (Check if admin is not making himself inactive) @raenyx @soham

}
