//  struct Institution{
//       bool isVerified;
//       string institutionType;
//       bool mainInstitution;
//       int typeInt;
//       address verifier;
//   }

import 'package:web3dart/credentials.dart';

class Institution {
  bool isVerified;
  String institutionType;
  bool mainInstitution;
  int typeInt;
  EthereumAddress verifier;

  Institution(
      {required this.institutionType,
      required this.isVerified,
      required this.mainInstitution,
      required this.typeInt,
      required this.verifier});
}
