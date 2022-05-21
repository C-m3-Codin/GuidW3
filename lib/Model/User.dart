// struct User{

//       address userAddress;
//       string userName;
//       int32[] certifatesIds;
//   }

import 'package:web3dart/credentials.dart';

class User {
  EthereumAddress address;
  String userName;
  List<int> certificatIds;

  User(
      {required this.address,
      required this.certificatIds,
      required this.userName});
}
