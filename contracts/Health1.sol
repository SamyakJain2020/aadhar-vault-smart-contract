//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

enum Status {
    Absent,
    Present
}
struct Doctor {
    address doctorAddress;
    uint256 DoctorID;
    string ID;
}
struct Patient {
    address patientAddress;
    uint256 PatientID;
    string ID;
    string[] OCRDATA;
    string[] PRESCRIPTION;
}

contract medicPlus1 {
    address public Ayush;
    uint256 private DID;
    uint256 private PID;

    constructor() {
        DID = 0;
        PID = 0;
        Ayush = msg.sender; // Contract owner
    }

    mapping(address => Doctor) private doctors;
    mapping(address => Patient) private patients;
    address[] private doctorAddresses;
    address[] private patientAddresses;

    // create array of patients and doctors

    // regsiter doctor
    function registerDoctor(uint256 _DoctorID, string memory _ID) public {
        require(
            doctors[msg.sender].doctorAddress == address(0),
            "User Already Registered as a Doctor"
        );
        doctors[msg.sender].doctorAddress = msg.sender;
        doctors[msg.sender].DoctorID = _DoctorID;
        doctors[msg.sender].ID = _ID;
        doctorAddresses.push(msg.sender);
        DID++;
    }

    // register patient
    function registerPatient(uint256 _PatientID, string memory _ID) public {
        require(
            patients[msg.sender].patientAddress == address(0),
            "User Already Registered as a Patient"
        );
        patients[msg.sender].patientAddress = msg.sender;
        patients[msg.sender].PatientID = _PatientID;
        patients[msg.sender].ID = _ID;
        patientAddresses.push(msg.sender);
        PID++;
    }

    // add ocr data
    function addOCRData(string memory _data) public {
        require(
            patients[msg.sender].patientAddress != address(0),
            "USER NOT REGISTERED as a Patient"
        );
        patients[msg.sender].OCRDATA.push(_data);
    }

    // add prescription
    function addPrescription(
        string memory _data
    ) public returns (string[] memory) {
        require(
            patients[msg.sender].patientAddress != address(0),
            "USER NOT REGISTERED as a Patient"
        );
        patients[msg.sender].PRESCRIPTION.push(_data);
        return patients[msg.sender].PRESCRIPTION;
    }

    // getter functions
    // get doctor
    function getDoctor(uint256 _id) public view returns (Doctor memory) {
        return doctors[doctorAddresses[_id]];
    }

    // get patient
    function getPatient(uint256 _id) public view returns (Patient memory) {
        return patients[patientAddresses[_id]];
    }

    // get ocr data
    function getOCRData(uint256 _id) public view returns (string[] memory) {
        return patients[doctorAddresses[_id]].OCRDATA;
    }

    // get prescription
    function getPrescription(
        uint256 _id
    ) public view returns (string[] memory) {
        return patients[doctorAddresses[_id]].PRESCRIPTION;
    }

    // get all doctors
    function getAllDoctors() public view returns (Doctor[] memory) {
        Doctor[] memory _doctors = new Doctor[](DID);
        for (uint256 i = 0; i < DID; i++) {
            _doctors[i] = doctors[doctorAddresses[i]];
        }
        return _doctors;
    }

    // get all patients
    function getAllPatients() public view returns (Patient[] memory) {
        Patient[] memory _patients = new Patient[](PID);
        for (uint256 i = 0; i < PID; i++) {
            _patients[i] = patients[patientAddresses[i]];
        }
        return _patients;
    }
}
