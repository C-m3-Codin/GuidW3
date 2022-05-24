// import 'dart:html';

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guide/Constants/Constants.dart';
import 'package:guide/Guide.g.dart';
import 'package:guide/Model/CertificateModel.dart';
import 'package:web3dart/web3dart.dart';

import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class SmartContractController extends GetxController {
  var loadedAccount = "notRq".obs;
  var roleRequested = "notRq".obs;
  var certRequested = "notRq".obs;
  var fetchAllCertRequest = "notRq".obs;
  var isInstituiton = false.obs;

  Rx<List?> certIds = (null as List<dynamic>?).obs;
  Rx<List?> role = (null as List<dynamic>?).obs;
  Rx<List?> certificates = (null as List<Certificates>?).obs;

  // var _role = "notRquested".obs;
  final _rpcUrl = "HTTP://192.168.0.106:7545".obs;
  final String _wsURl = "ws://192.168.0.106:7545";
  late String _privateKey;

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
    await getDeployedContract();
    // await getCredentials();
    // await getAccountBalance();
    // await getAccountType();
    // guideAuto = Guide(address: _contract.address, client: _client);
  }

  linkContractAfterAuth() async {
    loadedAccount.value = "loading";
    _privateKey = privateKey;
    await getCredentials();
    await getAccountBalance();
    await getAccountType();
    guideAuto = Guide(address: _contract.address, client: _client);

    loadedAccount.value = "loaded";
    print("loading all of it ${loadedAccount.value}");
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

  grantCertificateAccessTo(
    BigInt certificateId,
    EthereumAddress to,
  ) async {
    String response = await guideAuto.grantCertificateaccess(certificateId, to,
        credentials: _credentials);

    // String response = await _client.sendTransaction(
    //     _credentials,
    //     Transaction.callContract(
    //         contract: _contract,
    //         function: ,
    //         parameters: [BigInt.from(incrementBy)]));

    print(response);
  }

  getCertIds() async {
    print(
        "contract address ${_contractAddress} and userAddress is ${userAddress.value}");

    certRequested.value = "Requested";
    // guideAuto.getCurrentUserAddress();
    final sendFunction = _contract.function('getCurrentUserCertificateIDs');
    var a = await _client.call(
        contract: _contract,
        function: sendFunction,
        params: [],
        sender: userAddress.value);
    // List<dynamic> a = await  guideAuto.getCurrentUserCertificateIDs();
    certIds.value = a[0];
    print("got cert ids ${a}");
    certRequested.value = "Fetched";
  }

  fetchAllCertificates() async {
    fetchAllCertRequest.value = "Requested";
    List<Certificates> temp = [];
    final sendFunction = _contract.function('getCertificate');
    print("number of certificates are ${certIds.value!.length}");
    for (int i = 0; i < certIds.value!.length; i++) {
      print("object ${certIds.value![i]}");
      List<dynamic> a = (await _client.call(
          contract: _contract,
          function: sendFunction,
          params: [certIds.value![i]]));

      print(a);
      Certificates temp2 = Certificates(a[0]);
      print("a fetched ${i} is ${a}");
      temp.add(temp2);
    }
    certificates.value = temp;
    fetchAllCertRequest.value = "fetched";
    print(
        " fetched certificate  ${certificates.value?.length} and temp is ${temp?.length}");
  }

  getAccountType() async {
    ContractFunction _function = _contract.function('isInstitution');
    var response = await _client.call(
        contract: _contract, function: _function, params: [userAddress.value]);
    isInstituiton.value = response[0];
    print(" is the account Institution ${response}");
  }

  toggleIsPublic(BigInt certIdCurrent) async {
    var a = await guideAuto.toggleisPublic(certIdCurrent,
        credentials: _credentials);
    print("is public function ${a}");
    var cert = await _client.call(
        contract: _contract,
        function: _contract.function('certificates'),
        params: [certIdCurrent]);
    print("certificate is ${cert}");
  }
}
