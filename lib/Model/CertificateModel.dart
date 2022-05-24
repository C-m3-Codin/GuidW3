import 'package:web3dart/web3dart.dart' as _i1;

class Certificates {
  Certificates(List<dynamic> response)
      : certificateId = (response[0] as BigInt),
        certType = (response[1] as BigInt),
        dateIssue = (response[2] as String),
        dateExpire = (response[3] as String),
        issuer = (response[4] as _i1.EthereumAddress),
        issedAgainst = (response[5] as _i1.EthereumAddress),
        isPublic = (response[6] as bool),
        data = (response[7] as String),
        taggedInstutions = response[8],
        taggeInstitutionApproved = response[9],
        accessGranted = response[10];
  //  address[] taggedInstutions;
  //       bool [] taggeInstitutionApproved;
  //        address[] accessGranted;
  final BigInt certificateId;
  final List<dynamic> taggedInstutions;
  final List<dynamic> taggeInstitutionApproved;
  final List<dynamic> accessGranted;
  final BigInt certType;

  final String dateIssue;

  final String dateExpire;

  final _i1.EthereumAddress issuer;

  final _i1.EthereumAddress issedAgainst;

  bool isPublic;

  final String data;
}
