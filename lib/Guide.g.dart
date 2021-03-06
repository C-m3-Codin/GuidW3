// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:guide/Model/CertificateModel.dart';
import 'package:guide/Model/Institution.dart';
import 'package:guide/Model/User.dart';
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"inputs":[{"internalType":"address[]","name":"mainNodeAddress","type":"address[]"},{"internalType":"string[]","name":"institutionType","type":"string[]"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"certTagRequest","outputs":[{"internalType":"int32","name":"","type":"int32"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"int32","name":"","type":"int32"}],"name":"certificates","outputs":[{"internalType":"int32","name":"certificateId","type":"int32"},{"internalType":"int256","name":"certType","type":"int256"},{"internalType":"string","name":"dateIssue","type":"string"},{"internalType":"string","name":"dateExpire","type":"string"},{"internalType":"address","name":"issuer","type":"address"},{"internalType":"address","name":"issedAgainst","type":"address"},{"internalType":"bool","name":"isPublic","type":"bool"},{"internalType":"string","name":"data","type":"string"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"institutionProfile","outputs":[{"internalType":"bool","name":"isVerified","type":"bool"},{"internalType":"string","name":"institutionType","type":"string"},{"internalType":"bool","name":"mainInstitution","type":"bool"},{"internalType":"int256","name":"typeInt","type":"int256"},{"internalType":"address","name":"verifier","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"isInstitution","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"userProfiles","outputs":[{"internalType":"address","name":"userAddress","type":"address"},{"internalType":"string","name":"userName","type":"string"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"addr","type":"address"}],"name":"getCertReqestList","outputs":[{"internalType":"int32[]","name":"","type":"int32[]"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"name","type":"string"}],"name":"RegisterUser","outputs":[{"components":[{"internalType":"address","name":"userAddress","type":"address"},{"internalType":"string","name":"userName","type":"string"},{"internalType":"int32[]","name":"certifatesIds","type":"int32[]"}],"internalType":"struct Guide.User","name":"","type":"tuple"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"institutionType","type":"string"}],"name":"RegisterInstitution","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"int32","name":"_certificateId","type":"int32"},{"internalType":"address","name":"_institutionAddress","type":"address"}],"name":"grantCertificateAccessInstitution","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"int32","name":"ceri","type":"int32"}],"name":"getCertifDebug","outputs":[{"components":[{"internalType":"int32","name":"certificateId","type":"int32"},{"internalType":"int256","name":"certType","type":"int256"},{"internalType":"string","name":"dateIssue","type":"string"},{"internalType":"string","name":"dateExpire","type":"string"},{"internalType":"address","name":"issuer","type":"address"},{"internalType":"address","name":"issedAgainst","type":"address"},{"internalType":"bool","name":"isPublic","type":"bool"},{"internalType":"string","name":"data","type":"string"},{"internalType":"address[]","name":"taggedInstutions","type":"address[]"},{"internalType":"bool[]","name":"taggeInstitutionApproved","type":"bool[]"},{"internalType":"address[]","name":"accessGranted","type":"address[]"}],"internalType":"struct Guide.Certificate","name":"cert","type":"tuple"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"int256","name":"certType","type":"int256"},{"internalType":"string","name":"dateIssue","type":"string"},{"internalType":"string","name":"dateExpire","type":"string"},{"internalType":"address","name":"issedAgainst","type":"address"},{"internalType":"address[]","name":"taggedInstutions","type":"address[]"},{"internalType":"bool","name":"isPublic","type":"bool"},{"internalType":"string","name":"data","type":"string"}],"name":"publishCertificate","outputs":[{"internalType":"int32","name":"","type":"int32"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_institutionAddress","type":"address"}],"name":"fetchCertTagRequest","outputs":[{"internalType":"int32[]","name":"certIds","type":"int32[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"issedAgainst","type":"address"}],"name":"GrantVerification","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"getRole","outputs":[{"components":[{"internalType":"bool","name":"isVerified","type":"bool"},{"internalType":"string","name":"institutionType","type":"string"},{"internalType":"bool","name":"mainInstitution","type":"bool"},{"internalType":"int256","name":"typeInt","type":"int256"},{"internalType":"address","name":"verifier","type":"address"}],"internalType":"struct Guide.Institution","name":"","type":"tuple"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"int32","name":"certificateId","type":"int32"},{"internalType":"address","name":"account","type":"address"}],"name":"grantCertificateaccess","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"int32","name":"certIdCurrent","type":"int32"}],"name":"getCertificate","outputs":[{"components":[{"internalType":"int32","name":"certificateId","type":"int32"},{"internalType":"int256","name":"certType","type":"int256"},{"internalType":"string","name":"dateIssue","type":"string"},{"internalType":"string","name":"dateExpire","type":"string"},{"internalType":"address","name":"issuer","type":"address"},{"internalType":"address","name":"issedAgainst","type":"address"},{"internalType":"bool","name":"isPublic","type":"bool"},{"internalType":"string","name":"data","type":"string"},{"internalType":"address[]","name":"taggedInstutions","type":"address[]"},{"internalType":"bool[]","name":"taggeInstitutionApproved","type":"bool[]"},{"internalType":"address[]","name":"accessGranted","type":"address[]"}],"internalType":"struct Guide.Certificate","name":"","type":"tuple"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"int32","name":"certIdCurrent","type":"int32"}],"name":"toggleisPublic","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getCurrentUserCertificateIDs","outputs":[{"internalType":"int32[]","name":"","type":"int32[]"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"int32","name":"certificateId","type":"int32"},{"internalType":"address","name":"institutionTagged","type":"address"}],"name":"approveCertificate","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getCurrentUserAddress","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true}]',
    'Guide');

class Guide extends _i1.GeneratedContract {
  Guide(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> certTagRequest(_i1.EthereumAddress $param0, BigInt $param1,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'e98a73b4'));
    final params = [$param0, $param1];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Certificates> certificates(BigInt $param2,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, 'cd58b0b5'));
    final params = [$param2];
    final response = await read(function, params, atBlock);
    return Certificates(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<InstitutionProfile> institutionProfile(_i1.EthereumAddress $param3,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '24986631'));
    final params = [$param3];
    final response = await read(function, params, atBlock);
    return InstitutionProfile(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<bool> isInstitution(_i1.EthereumAddress $param4,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '0331df07'));
    final params = [$param4];
    final response = await read(function, params, atBlock);
    return (response[0] as bool);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '8da5cb5b'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<UserProfiles> userProfiles(_i1.EthereumAddress $param5,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '332d56d7'));
    final params = [$param5];
    final response = await read(function, params, atBlock);
    return UserProfiles(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> getCertReqestList(_i1.EthereumAddress addr,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '0d849d12'));
    final params = [addr];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> RegisterUser(String name,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '48c415ec'));
    final params = [name];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> RegisterInstitution(String institutionType,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '9f4900e0'));
    final params = [institutionType];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> grantCertificateAccessInstitution(
      BigInt _certificateId, _i1.EthereumAddress _institutionAddress,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '3b03d1e8'));
    final params = [_certificateId, _institutionAddress];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getCertifDebug(BigInt ceri, {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[11];
    assert(checkSignature(function, '0f229e58'));
    final params = [ceri];
    final response = await read(function, params, atBlock);
    return (response[0] as dynamic);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> publishCertificate(
      BigInt certType,
      String dateIssue,
      String dateExpire,
      _i1.EthereumAddress issedAgainst,
      List<_i1.EthereumAddress> taggedInstutions,
      bool isPublic,
      String data,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[12];
    assert(checkSignature(function, 'e926e540'));
    final params = [
      certType,
      dateIssue,
      dateExpire,
      issedAgainst,
      taggedInstutions,
      isPublic,
      data
    ];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<BigInt>> fetchCertTagRequest(
      _i1.EthereumAddress _institutionAddress,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, '6ff37c85'));
    final params = [_institutionAddress];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<BigInt>();
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> GrantVerification(_i1.EthereumAddress issedAgainst,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '314e6673'));
    final params = [issedAgainst];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getRole(_i1.EthereumAddress account,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[15];
    assert(checkSignature(function, '44276733'));
    final params = [account];
    final response = await read(function, params, atBlock);
    return (response[0] as dynamic);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> grantCertificateaccess(
      BigInt certificateId, _i1.EthereumAddress account,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[16];
    assert(checkSignature(function, '5e64f86a'));
    final params = [certificateId, account];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getCertificate(BigInt certIdCurrent,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[17];
    assert(checkSignature(function, 'c0cf2af6'));
    final params = [certIdCurrent];
    final response = await read(function, params, atBlock);
    return (response[0] as dynamic);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> toggleisPublic(BigInt certIdCurrent,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[18];
    assert(checkSignature(function, 'd90bd6b0'));
    final params = [certIdCurrent];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<BigInt>> getCurrentUserCertificateIDs(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[19];
    assert(checkSignature(function, '96bee603'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<BigInt>();
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> approveCertificate(
      BigInt certificateId, _i1.EthereumAddress institutionTagged,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[20];
    assert(checkSignature(function, '7d0a7b2f'));
    final params = [certificateId, institutionTagged];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> getCurrentUserAddress(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[21];
    assert(checkSignature(function, 'b2c4c52f'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as _i1.EthereumAddress);
  }
}
