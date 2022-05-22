// struct User{

//       address userAddress;
//       string userName;
//       int32[] certifatesIds;
//   }
import 'package:web3dart/web3dart.dart' as _i1;

class UserProfiles {
  UserProfiles(List<dynamic> response)
      : userAddress = (response[0] as _i1.EthereumAddress),
        userName = (response[1] as String);

  final _i1.EthereumAddress userAddress;

  final String userName;
}
