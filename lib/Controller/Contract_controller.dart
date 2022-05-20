import 'dart:convert';
// import 'dart:html';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';

import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class SmartContractController extends GetxController {
  var roleRequested = "notRq".obs;
  var certRequested = "notRq".obs;
  Rx<List?> certIds = (null as List<dynamic>?).obs;
  Rx<List?> role = (null as List<dynamic>?).obs;

  // var _role = "notRquested".obs;
  final _rpcUrl = "HTTP://192.168.0.106:7545".obs;
  final String _wsURl = "ws://192.168.0.106:7545";
  final String _privateKey =
      "b5f676dae41411258554065249081daba3bbe2dca43a7c6e9a01526f17a15c25";

  // var  userAddress =  Rx<EthereumAddress>();;
  final Rx<EthereumAddress?> userAddress = (null as EthereumAddress?).obs;
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
    await getAccountBalance();
  }

  Future<EtherAmount> getAccountBalance() async {
    var credentials = EthPrivateKey.fromHex(_privateKey);
    userAddress.value = credentials.address;
    print("value of address is ${userAddress} and ${userAddress.value}");
    return await Web3Client(_rpcUrl.string, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsURl).cast<String>();
    }).getBalance(credentials.address);
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("build/contracts/Guide.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Guide"), _contractAddress);
  }

  getRole() async {
    roleRequested.value = "Requested";
    final sendFunction = _contract.function('getRole');
    print("called get role and user addr is ${userAddress.value}");
    var result = (await _client.call(
        contract: _contract,
        function: sendFunction,
        params: [userAddress.value]));

    // print("got result is ${result}");

    role.value = result;
    roleRequested.value = "Fetched";
    print("get Role result ${result}");
  }

  getCertIds() async {
    certRequested.value = "Requested";
    final certIdFun = _contract.function('getCurrentUserCertificateIDs');
    List<dynamic> a = await _client.call(
        contract: _contract,
        function: certIdFun,
        params: [],
        sender: EthereumAddress.fromHex(
            "0xd430d224465e53013D49679b173d7E2c9f63394e"));
    certIds.value = a;
    print("got cert ids ${a}");

    certRequested.value = "Fetched";
  }
}
