import 'dart:convert';
// import 'dart:html';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';

import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class SmartContractController extends GetxController {
  final _rpcUrl = "HTTP://192.168.0.106:7545".obs;
  final String _wsURl = "ws://192.168.0.106:7545";
  final String _privateKey =
      "b5f676dae41411258554065249081daba3bbe2dca43a7c6e9a01526f17a15c25";

  late Web3Client _client;
  late String _abiCode;

  late EthereumAddress _contractAddress;
  late Credentials _credentials;

  late DeployedContract _contract;

  @override
  void onInit() {
    super.onInit();

    linkContract();
  }

  void linkContract() async {
    _client = Web3Client(_rpcUrl.string, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsURl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<EtherAmount> getAccount() async {
    // return _credentials.extractAddress();
    var credentials = EthPrivateKey.fromHex(_privateKey);

// You can now call rpc methods. This one will query the amount of Ether you own
    return await Web3Client(_rpcUrl.string, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsURl).cast<String>();
    }).getBalance(await credentials.extractAddress());
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("build/contracts/Guide.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    // print(_abiCode);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "HelloWorld"), _contractAddress);

    // Extracting the functions, declared in contract.
    // _yourName = _contract.function("yourName");
    // _setName = _contract.function("setName");
    // getName();
  }
}
