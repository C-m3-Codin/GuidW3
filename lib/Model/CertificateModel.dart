import 'package:web3dart/credentials.dart';

class CertificateModel {
  // String certName = 'initial';
  String certID = 'id initial';
  int dateIssue;
  int dateExpire;
  EthereumAddress issuer;
  EthereumAddress issuedAgainst;
  List<EthereumAddress> taggedInstutions;
  List<bool> taggeInstitutionApproved;
  bool isPublic;
  List<EthereumAddress> accessGranted;
  String date;

  CertificateModel(
      {required this.accessGranted,
      required this.certID,
      // required this.certName,
      required this.date,
      required this.dateExpire,
      required this.dateIssue,
      required this.isPublic,
      required this.issuedAgainst,
      required this.issuer,
      required this.taggeInstitutionApproved,
      required this.taggedInstutions});
}



    // int32 certificateId;
    //     int certType;
    //     int256 dateIssue;
    //     int256 dateExpire;
    //     address issuer;
    //     address issedAgainst;
    //     address[] taggedInstutions;
    //     bool [] taggeInstitutionApproved;
    //     bool isPublic;
    //     address[] accessGranted;
    //     string data;