// import 'dart:html';

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guide/Constants/Constants.dart';
import 'package:guide/Guide.g.dart';
import 'package:guide/Model/CertificateModel.dart';
import 'package:guide/Model/Institution.dart';
import 'package:web3dart/web3dart.dart';

import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class SmartContractController extends GetxController {
  var loadedAccount = "notRq".obs;
  var roleRequested = "notRq".obs;
  var certRequested = "notRq".obs;
  var profileRequest = "notRq".obs;
  var viewProfileRequest = "notRq".obs;
  var fetchAllCertRequest = "notRq".obs;
  var isInstituiton = false.obs;
  //  Rx<InstitutionProfile> instProfile = ;
  final Rx<InstitutionProfile?> instProfile = (null as InstitutionProfile?).obs;
  final Rx<InstitutionProfile?> viewInstitutionProfile =
      (null as InstitutionProfile?).obs;
  // var instProfile = false.obs;
  Rx<List?> requestedVerificationIds = (null as List<dynamic>?).obs;

  Rx<List?> certIds = (null as List<dynamic>?).obs;
  Rx<List?> role = (null as List<dynamic>?).obs;
  Rx<List?> certificates = (null as List<Certificates>?).obs;
  Rx<List?> certificatesRequestVerification = (null as List<Certificates>?).obs;
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

    print(response);
  }

  getRequestedCerts() async {
// userAddress
    print("user address the ${userAddress}");
    // final sendFunction = _contract.function('certTagRequest');
    print(" got to getRequest Certs ${userAddress}");
    ContractFunction _function = _contract.function('getCertReqestList');
    var a = await _client.call(
        contract: _contract,
        function: _function,
        params: [userAddress.value],
        sender: userAddress.value);
    requestedVerificationIds.value = a[0];
    print(" cert ids for request are ${a}");
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

  allVerificationRequestedCertificates() async {
    fetchAllCertRequest.value = "loading";
    print(" All verifcation Request Cert ${requestedVerificationIds.value}");
    // certificatesRequestVerification
    List<Certificates> temp = [];
    final sendFunction = _contract.function('getCertificate');
    for (int i = 0; i < requestedVerificationIds.value!.length; i++) {
      print("object ${requestedVerificationIds.value![i]}");
      List<dynamic> a = (await _client.call(
          contract: _contract,
          function: sendFunction,
          params: [requestedVerificationIds.value![i]],
          sender: userAddress.value));
      print(a);
      Certificates temp2 = Certificates(a[0]);
      print("a fetched ${i} is ${a}");
      temp.add(temp2);
    }
    certificatesRequestVerification.value = temp;
    fetchAllCertRequest.value = "fetched";
  }

  searchCertificate(BigInt certIdtoSearch) async {
    final sendFunction = _contract.function('getCertificate');
    try {
      List<dynamic> a = (await _client.call(
          contract: _contract,
          function: sendFunction,
          params: [certIdtoSearch],
          sender: userAddress.value));
      return a;
    } catch (error) {
      return "You do not have access to Certificate";
    }
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
          params: [certIds.value![i]],
          sender: userAddress.value));

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

  publishCertificate(
      BigInt certType,
      String dateIssue,
      String dateExpire,
      EthereumAddress issedAgainst,
      List<EthereumAddress> taggedInstutions,
      bool isPublic,
      String data) async {
    var a = await guideAuto.publishCertificate(certType, dateIssue, dateExpire,
        issedAgainst, taggedInstutions, isPublic, data,
        credentials: _credentials);
    ContractFunction _function = _contract.function('publishCertificate');
    // String response = await _client.sendTransaction(
    //     _credentials,
    //     Transaction.callContract(
    //         contract: _contract,
    //         function: _function,
    //         parameters: [
    //           certType,
    //           dateIssue,
    //           dateExpire,
    //           issedAgainst,
    //           taggedInstutions,
    //           isPublic,
    //           data,
    //         ],
    //         gasPrice: EtherAmount.inWei(BigInt.from(3000000))));
    print(a);
  }

  geCurrenttinstitutionProfile(EthereumAddress insaddress) async {
    profileRequest.value = "Requested";
    InstitutionProfile v = await guideAuto.institutionProfile(insaddress);
    print(" institution profile = ${v.isVerified}");
    instProfile.value = v;
    profileRequest.value = "lodaed";
  }

  getAnyinstitutionProfile(EthereumAddress insaddress) async {
    viewProfileRequest.value = "Requested";
    InstitutionProfile v = await guideAuto.institutionProfile(insaddress);
    print(" institution profile = ${v.isVerified}");
    viewInstitutionProfile.value = v;
    viewProfileRequest.value = "lodaed";
  }

  approveCertificate(EthereumAddress address, BigInt certNumber) async {
    await guideAuto.approveCertificate(certNumber, address,
        credentials: _credentials);
  }
}
