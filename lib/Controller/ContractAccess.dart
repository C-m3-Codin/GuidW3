import 'package:flutter/services.dart';
import 'package:guide/Constants/Constants.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract(
    {String contractAddress =
        "0x7EF370941e9598c1F8f4C1001F150a94779dc4D7"}) async {
  String abi = await rootBundle.loadString("assets/Guide.json");
  // String contractAddress = "0x7EF370941e9598c1F8f4C1001F150a94779dc4D7";

  DeployedContract contract = DeployedContract(
    ContractAbi.fromJson(abi, "Guide"),
    EthereumAddress.fromHex(contractAddress),
  );
  return contract;
}

Future<EtherAmount> connectTOChain(String privateKey) async {
  // start a client we can use to send transactions
  // ethClient = await Web3Client(url, Client());

  final credentials = EthPrivateKey.fromHex(privateKey);
  final address = credentials.address;

  print(address.hexEip55);
  print(await ethClient.getBalance(address));
  EtherAmount balance = await ethClient.getBalance(address);
  return balance;
  // return true;

  // await client.dispose();
}

Future<List<dynamic>> query(
    String functionName, List<dynamic> args, EthereumAddress sender) async {
  DeployedContract contract = await loadContract();
  ContractFunction contractFunction = contract.function(functionName);
  print(ethClient);
  if (args.isEmpty) {
    print("no args");
    List<dynamic> result = await ethClient.call(
        contract: contract,
        function: contractFunction,
        params: [],
        sender: sender);
    print(result);

    return result;
  } else {
    print(args[0]);
    dynamic result = await ethClient.call(
        contract: contract, function: contractFunction, params: args);
    print(result);

    return result;
  }
}

Future<List<dynamic>> queryGetCert(
    String id, EthereumAddress sender, String functionName) async {
  DeployedContract contract = await loadContract();
  ContractFunction contractFunction = contract.function(functionName);
  print(ethClient);

  print("no args");
  List<dynamic> result = await ethClient.call(
      contract: contract,
      function: contractFunction,
      params: [],
      sender: sender);
  print(result);
  return result;
}
