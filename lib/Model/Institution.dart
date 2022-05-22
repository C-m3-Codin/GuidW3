//  struct Institution{
//       bool isVerified;
//       string institutionType;
//       bool mainInstitution;
//       int typeInt;
//       address verifier;
//   }
import 'package:web3dart/web3dart.dart' as _i1;

class InstitutionProfile {
  InstitutionProfile(List<dynamic> response)
      : isVerified = (response[0] as bool),
        institutionType = (response[1] as String),
        mainInstitution = (response[2] as bool),
        typeInt = (response[3] as BigInt),
        verifier = (response[4] as _i1.EthereumAddress);

  final bool isVerified;

  final String institutionType;

  final bool mainInstitution;

  final BigInt typeInt;

  final _i1.EthereumAddress verifier;
}
