//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

enum Status {
    Absent,
    Present
}
struct MANUFACTURER {
    string name;
    uint256 id;
    address[] MANUFACTURERUSERS;
    address MANUFACTURERADMIN;
}
struct MEDICINE {
    string name;
    uint256 id;
    string batch_no;
    string expiry_date;
    string manufacture_date;
    string price;
    string manufacturer_id;
    address manufacturer_address;
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

contract medicPlus {
    address public Ayush;
    uint256 private ID;
    uint256 private DID;
    uint256 private PID;
    uint256 private MID;

    constructor() {
        ID = 0;
        DID = 0;
        PID = 0;
        MID = 0;
        Ayush = msg.sender; // Contract owner
    }

    mapping(uint256 => MANUFACTURER) private manufacturers;
    mapping(uint256 => MEDICINE) private medicines;

    event ManufacturerRegistered(uint256 id, string name);
    event MedicineRegistered(uint256 id, string name);

    // setter functions
    // regsiter manufacturer
    function registerManufacturer(string memory _name, uint256 _id) public {
        require(
            manufacturers[_id].MANUFACTURERADMIN == address(0),
            "Manufacturer Already Registered"
        );
        MID++;
        manufacturers[MID].name = _name;
        manufacturers[MID].id = _id;
        manufacturers[MID].MANUFACTURERADMIN = msg.sender;
        emit ManufacturerRegistered(MID, _name);
    }

    // register medicine

    function registerMedicine(
        string memory _name,
        string memory _batch_no,
        string memory _expiry_date,
        string memory _manufacture_date,
        string memory _price,
        string memory _manufacturer_id // string memory _manufacturer_address
    ) public {
        // require(
        //     medicines[ID].manufacturer_address == address(0),
        //     "Medicine Already Registered"
        // );
        ID++;
        medicines[ID].name = _name;
        medicines[ID].id = ID;
        medicines[ID].batch_no = _batch_no;
        medicines[ID].expiry_date = _expiry_date;
        medicines[ID].manufacture_date = _manufacture_date;
        medicines[ID].price = _price;
        medicines[ID].manufacturer_id = _manufacturer_id;
        medicines[ID].manufacturer_address = msg.sender;
        emit MedicineRegistered(ID, _name);
    }

    // get manufacturer
    function getManufacturer(
        uint256 _id
    ) public view returns (string memory, uint256, address) {
        return (
            manufacturers[_id].name,
            manufacturers[_id].id,
            manufacturers[_id].MANUFACTURERADMIN
        );
    }

    // get all medicines
    function getAllMedicines() public view returns (MEDICINE[] memory) {
        MEDICINE[] memory _medicines = new MEDICINE[](ID);
        for (uint256 i = 1; i <= ID; i++) {
            _medicines[i - 1] = medicines[i];
        }
        return _medicines;
    }

    // get all manufacturers
    function getAllManufacturers() public view returns (MANUFACTURER[] memory) {
        MANUFACTURER[] memory _manufacturers = new MANUFACTURER[](ID);
        for (uint256 i = 1; i <= ID; i++) {
            _manufacturers[i - 1] = manufacturers[i];
        }
        return _manufacturers;
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
x
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
