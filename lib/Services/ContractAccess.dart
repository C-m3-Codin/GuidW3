import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' show join, dirname;
import 'package:flutter/services.dart';
import 'package:guide/Constants/Constants.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract(
    {String contractAddress =
        "0x45c7DC5c7CB32f989C64cE20269E714dcf0886f6"}) async {
  String abi = await rootBundle.loadString("assets/Guide.json");
  String contractAddress = "0x45c7DC5c7CB32f989C64cE20269E714dcf0886f6";

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

Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
  DeployedContract contract = await loadContract();
  ContractFunction contractFunction = contract.function(functionName);
  print(ethClient);
  dynamic result = await ethClient.call(
      contract: contract, function: contractFunction, params: args);
  print(result.toString());

  return result;
}
