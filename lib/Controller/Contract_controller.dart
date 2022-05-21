import 'dart:convert';
// import 'dart:html';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guide/Constants/Constants.dart';
import 'package:guide/Guide.g.dart';
import 'package:guide/Model/CertificateModel.dart';
import 'package:web3dart/web3dart.dart';

import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class SmartContractController extends GetxController {
  var roleRequested = "notRq".obs;
  var certRequested = "notRq".obs;
  var fetchAllCertRequest = "notRq".obs;
  Rx<List?> certIds = (null as List<dynamic>?).obs;
  Rx<List?> role = (null as List<dynamic>?).obs;
  Rx<List?> certificates = (null as List?).obs;

  // var _role = "notRquested".obs;
  final _rpcUrl = "HTTP://192.168.0.106:7545".obs;
  final String _wsURl = "ws://192.168.0.106:7545";
  final String _privateKey = privateKey;

  // var  userAddress =  Rx<EthereumAddress>();;
  final Rx<EthereumAddress?> userAddress = (null as EthereumAddress?).obs;
  late Web3Client _client;
  late String _abiCode;

  late EthereumAddress _contractAddress;
  late Credentials _credentials;

  late DeployedContract _contract;
  late Guide guideAuto;

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
    guideAuto = Guide(address: _contract.address, client: _client);
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
    role.value = await guideAuto.getRole(userAddress.value!);
    roleRequested.value = "Fetched";
    print("get Role result tadaaaah ${role.value}");
  }

  getRole1() async {
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
        sender: userAddress.value);
    certIds.value = a;
    print("got cert ids ${a}");

    certRequested.value = "Fetched";
  }

  fetchAllCertificates() async {
    // List<dynamic> certifactes;
    fetchAllCertRequest.value = "Requested";
    final certIdFun = _contract.function('getCertificate');
    var temp = [];

    print("number of certificates are ${certIds.value!.first.length}");
    for (int i = 0; i < certIds.value!.first.length; i++) {
      List<dynamic> a = await _client.call(
          contract: _contract,
          function: certIdFun,
          params: [certIds.value![0][i]],
          sender: userAddress.value);

      //       int32 certificateId;0
      // int certType;1
      // int256 dateIssue;2
      // int256 dateExpire;3
      // address issuer;4
      // address issedAgainst;5
      // address[] taggedInstutions;6
      // bool [] taggeInstitutionApproved;7
      // bool isPublic;8
      // address[] accessGranted;9
      // string data;10
      CertificateModel Certificate = CertificateModel(
          accessGranted: a[0][9],
          certID: a[0][1],
          date: a[0][10],
          dateExpire: a[0][3],
          dateIssue: a[0][2],
          isPublic: a[0][8],
          issuedAgainst: a[0][5],
          issuer: a[0][4],
          taggeInstitutionApproved: a[0][7],
          taggedInstutions: a[0][6]);
      print("a fetched ${i} is ${a}");
      temp.add(Certificate);
    }
    certificates.value = temp;
    fetchAllCertRequest.value = "fetched";
    print(
        " fetched certificate  ${certificates.value?.length} and temp is ${temp?.length}");
  }
}
