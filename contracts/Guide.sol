// SPDX-License-Identifier: MIT 
pragma solidity >=0.7.0 <0.9.0;

contract Guide {

    address public owner;
    int32 certId;
    // uint public last_completed_migration;

    
    struct User{

        address userAddress;
        string userName;
        int32[] certifatesIds;
    }

    struct Certificate{        
        int32 certificateId;
        int certType;
        int256 dateIssue;
        int256 dateExpire;
        address issuer;
        address issedAgainst;
        address[] taggedInstutions;
        bool [] taggeInstitutionApproved;
        bool isPublic;
        address[] accessGranted;
        string data;

    }

    struct Institution{    
        bool isVerified;
        string institutionType;
        bool mainInstitution;
        int typeInt;
        address verifier;
    }

    mapping (address=>User) public userProfiles;
    mapping(address=>Institution) public institutionProfile;  
    mapping(int32=>Certificate) public certificates;  
    
    mapping(address => int32[]) certTagRequest;         

    constructor(address[] memory mainNodeAddress,string[] memory institutionType) public {
        certId=0;
        owner = msg.sender;
      
        for (uint256 i = 0; i < mainNodeAddress.length; ++i) {
             _grantVerification(mainNodeAddress[i],institutionType[i],true,owner);
        }
    }


    // modifier to check if certificate is of the requester
    modifier ownerOfCertificate(int32 _certificateId,address msgSender) {
        require(certificates[_certificateId].issedAgainst == msgSender,"You are not the owner of this certificate");
        _;
    }
    

// modifier to restrict restrict institution only events    
    modifier restrictInstitutionOnly(address _institutionAddress) {
        require(
            institutionProfile[_institutionAddress].typeInt >0,
            "Not requested verification by MainNode"
        );
        _;
    }
    
    // Register User profile with the system
    function  RegisterUser()public returns(address) {

      User storage newUser = userProfiles[msg.sender];
        newUser.userAddress = msg.sender;
        newUser.userName = "";  
        
        return userProfiles[msg.sender].userAddress;

    }


    // Register Institution with address
    // Institution not verified first
    // Institution type is not main node
    function  RegisterInstitution(string  memory institutionType)public returns(address) {

      Institution storage newIns = institutionProfile[msg.sender];
    
        newIns.isVerified = false;
        newIns.institutionType = institutionType;
        newIns.mainInstitution = false;
        newIns.typeInt = 0;
        // newIns.verifier = ;
  

    }


// give access to different institution to access certificate
// add modifier to confirm its institution
function grantCertificateAccessInstitution(int32 _certificateId,address _institutionAddress)public ownerOfCertificate(_certificateId,msg.sender)restrictInstitutionOnly(_institutionAddress){ 
    certificates[_certificateId].accessGranted.push(_institutionAddress);
}



function getCertifDebug(int32 ceri) public view returns(Certificate memory cert){
    return certificates[ceri];
}
    // publish cer to mapping
    // send requstt to tagged institutions
    function publishCertificate(int certType,int256 dateIssue,int256 dateExpire,address issedAgainst,address[] memory taggedInstutions,bool isPublic,string memory data)  public returns(int32) {
        // publishCertificate(121,34123,456,accounts[8],[],true,"dam againsome shit here too").send({from:accounts[0],gas:3000000}
        // int32 certId=0;
        certId++;

        Certificate storage newCert = certificates[certId];
        newCert.certificateId = certId;
            newCert.certType = certType;
            newCert.dateIssue = dateIssue;
            newCert.dateExpire = dateExpire;
            newCert.issuer = msg.sender;
            newCert.issedAgainst = issedAgainst;
            newCert.taggedInstutions = taggedInstutions;
            newCert.isPublic = isPublic;
            newCert.accessGranted = [msg.sender,issedAgainst];
            newCert.data = data;
            
        //  making all approvals false
        // TODO all false except institutionitself
        for(uint256 i = 0; i < taggedInstutions.length; ++i){
            if(taggedInstutions[i] != msg.sender){
                newCert.taggeInstitutionApproved[i] = true;
                continue;
            }
            newCert.taggeInstitutionApproved[i] = false;
        }

        userProfiles[issedAgainst].certifatesIds.push(certId);
        requestCertTagVerification(certId,taggedInstutions);


        // certificates[certId] = cert;
        return certId;
    }

    // Requests Tagged Institutions verifies the certificates
    function requestCertTagVerification(int32  requestedCertId,address[] memory instAddress) internal {
        for (uint256 i = 0; i < instAddress.length; ++i) {
            certTagRequest[instAddress[i]].push(requestedCertId);
        }

    }
   
    function GrantVerification(address issedAgainst)external restrictInstitutionOnly(msg.sender){   

        _grantVerification(issedAgainst,institutionProfile[issedAgainst].institutionType,false,msg.sender);
       

    }        

    // verified a node as a main node
    function _grantVerification(address  account, string memory role,bool firstNode,address issuer) internal{
        
    //  emit GrantRole(_role,_account);
    if(firstNode){

    Institution memory book2= Institution(true,role,true,1,owner);
    institutionProfile[account]=book2;
    }
    else{
        Institution memory book2= Institution(true,role,false,1,issuer);
        institutionProfile[account]=book2;
    }
    }

     function getRole(address account) public view returns (Institution memory){
    
        // return institutionProfile[account].isVerified? "verified" : "not verified";
        return institutionProfile[account];

    }

    // access granting for a certificate
    // grant access if the certificate is issued to the function caller 
    function grantCertificateaccess(int32 certificateId,address account) public ownerOfCertificate(certificateId,msg.sender){


        certificates[certificateId].accessGranted.push(account);
      
    }
    
    // return certifactes if the certificate is given access to be viewed;
    function getCertificate(int32 certIdCurrent) public  view returns (Certificate memory){

        // !TODO create access control dont just return all certificates
        // current implementation of looping and searching high on gas

        // certificates[certId].accessGranted.push(msg.sender);
        if(certificates[certIdCurrent].isPublic){
            return certificates[certIdCurrent];
        }
        else
        {  for (uint i; i < certificates[certIdCurrent].accessGranted.length; i++) {
            if(certificates[certIdCurrent].accessGranted[i]==msg.sender){
                return certificates[certIdCurrent];
            }

        }       
        }
         require(false,"You do not have access to this certificate");


        // return certificates[certId];
    }

    function getCurrentUserCertificateIDs() public view returns(int32[] memory){
        return userProfiles[msg.sender].certifatesIds;    
        }
    
    modifier restrictedOwner() {
        require(
            msg.sender == owner,
            "This function is restricted to the contract's owner"
        );
        _;
    }

    
}
