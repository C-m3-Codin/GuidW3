// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"inputs":[{"internalType":"address[]","name":"mainNodeAddress","type":"address[]"},{"internalType":"string[]","name":"institutionType","type":"string[]"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"int32","name":"","type":"int32"}],"name":"certificates","outputs":[{"internalType":"int32","name":"certificateId","type":"int32"},{"internalType":"int256","name":"certType","type":"int256"},{"internalType":"int256","name":"dateIssue","type":"int256"},{"internalType":"int256","name":"dateExpire","type":"int256"},{"internalType":"address","name":"issuer","type":"address"},{"internalType":"address","name":"issedAgainst","type":"address"},{"internalType":"bool","name":"isPublic","type":"bool"},{"internalType":"string","name":"data","type":"string"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"institutionProfile","outputs":[{"internalType":"bool","name":"isVerified","type":"bool"},{"internalType":"string","name":"institutionType","type":"string"},{"internalType":"bool","name":"mainInstitution","type":"bool"},{"internalType":"int256","name":"typeInt","type":"int256"},{"internalType":"address","name":"verifier","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"userProfiles","outputs":[{"internalType":"address","name":"userAddress","type":"address"},{"internalType":"string","name":"userName","type":"string"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"RegisterUser","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"institutionType","type":"string"}],"name":"RegisterInstitution","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"int32","name":"_certificateId","type":"int32"},{"internalType":"address","name":"_institutionAddress","type":"address"}],"name":"grantCertificateAccessInstitution","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"int32","name":"ceri","type":"int32"}],"name":"getCertifDebug","outputs":[{"components":[{"internalType":"int32","name":"certificateId","type":"int32"},{"internalType":"int256","name":"certType","type":"int256"},{"internalType":"int256","name":"dateIssue","type":"int256"},{"internalType":"int256","name":"dateExpire","type":"int256"},{"internalType":"address","name":"issuer","type":"address"},{"internalType":"address","name":"issedAgainst","type":"address"},{"internalType":"address[]","name":"taggedInstutions","type":"address[]"},{"internalType":"bool[]","name":"taggeInstitutionApproved","type":"bool[]"},{"internalType":"bool","name":"isPublic","type":"bool"},{"internalType":"address[]","name":"accessGranted","type":"address[]"},{"internalType":"string","name":"data","type":"string"}],"internalType":"struct Guide.Certificate","name":"cert","type":"tuple"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"int256","name":"certType","type":"int256"},{"internalType":"int256","name":"dateIssue","type":"int256"},{"internalType":"int256","name":"dateExpire","type":"int256"},{"internalType":"address","name":"issedAgainst","type":"address"},{"internalType":"address[]","name":"taggedInstutions","type":"address[]"},{"internalType":"bool","name":"isPublic","type":"bool"},{"internalType":"string","name":"data","type":"string"}],"name":"publishCertificate","outputs":[{"internalType":"int32","name":"","type":"int32"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"issedAgainst","type":"address"}],"name":"GrantVerification","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"getRole","outputs":[{"components":[{"internalType":"bool","name":"isVerified","type":"bool"},{"internalType":"string","name":"institutionType","type":"string"},{"internalType":"bool","name":"mainInstitution","type":"bool"},{"internalType":"int256","name":"typeInt","type":"int256"},{"internalType":"address","name":"verifier","type":"address"}],"internalType":"struct Guide.Institution","name":"","type":"tuple"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[{"internalType":"int32","name":"certificateId","type":"int32"},{"internalType":"address","name":"account","type":"address"}],"name":"grantCertificateaccess","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"int32","name":"certIdCurrent","type":"int32"}],"name":"getCertificate","outputs":[{"components":[{"internalType":"int32","name":"certificateId","type":"int32"},{"internalType":"int256","name":"certType","type":"int256"},{"internalType":"int256","name":"dateIssue","type":"int256"},{"internalType":"int256","name":"dateExpire","type":"int256"},{"internalType":"address","name":"issuer","type":"address"},{"internalType":"address","name":"issedAgainst","type":"address"},{"internalType":"address[]","name":"taggedInstutions","type":"address[]"},{"internalType":"bool[]","name":"taggeInstitutionApproved","type":"bool[]"},{"internalType":"bool","name":"isPublic","type":"bool"},{"internalType":"address[]","name":"accessGranted","type":"address[]"},{"internalType":"string","name":"data","type":"string"}],"internalType":"struct Guide.Certificate","name":"","type":"tuple"}],"stateMutability":"view","type":"function","constant":true},{"inputs":[],"name":"getCurrentUserCertificateIDs","outputs":[{"internalType":"int32[]","name":"","type":"int32[]"}],"stateMutability":"view","type":"function","constant":true}]',
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
  Future<Certificates> certificates(BigInt $param0,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'cd58b0b5'));
    final params = [$param0];
    final response = await read(function, params, atBlock);
    return Certificates(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<InstitutionProfile> institutionProfile(_i1.EthereumAddress $param1,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '24986631'));
    final params = [$param1];
    final response = await read(function, params, atBlock);
    return InstitutionProfile(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '8da5cb5b'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<UserProfiles> userProfiles(_i1.EthereumAddress $param2,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '332d56d7'));
    final params = [$param2];
    final response = await read(function, params, atBlock);
    return UserProfiles(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> RegisterUser(
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '189e92ae'));
    final params = [];
    return write(credentials, transaction, function, params);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> RegisterInstitution(String institutionType,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[6];
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
    final function = self.abi.functions[7];
    assert(checkSignature(function, '3b03d1e8'));
    final params = [_certificateId, _institutionAddress];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getCertifDebug(BigInt ceri, {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[8];
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
      BigInt dateIssue,
      BigInt dateExpire,
      _i1.EthereumAddress issedAgainst,
      List<_i1.EthereumAddress> taggedInstutions,
      bool isPublic,
      String data,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[9];
    assert(checkSignature(function, '0f261a3b'));
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

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> GrantVerification(_i1.EthereumAddress issedAgainst,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[10];
    assert(checkSignature(function, '314e6673'));
    final params = [issedAgainst];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getRole(_i1.EthereumAddress account,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[11];
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
    final function = self.abi.functions[12];
    assert(checkSignature(function, '5e64f86a'));
    final params = [certificateId, account];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<dynamic> getCertificate(BigInt certIdCurrent,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[13];
    assert(checkSignature(function, 'c0cf2af6'));
    final params = [certIdCurrent];
    final response = await read(function, params, atBlock);
    return (response[0] as dynamic);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<BigInt>> getCurrentUserCertificateIDs(
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[14];
    assert(checkSignature(function, '96bee603'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<BigInt>();
  }
}

class Certificates {
  Certificates(List<dynamic> response)
      : certificateId = (response[0] as BigInt),
        certType = (response[1] as BigInt),
        dateIssue = (response[2] as BigInt),
        dateExpire = (response[3] as BigInt),
        issuer = (response[4] as _i1.EthereumAddress),
        issedAgainst = (response[5] as _i1.EthereumAddress),
        isPublic = (response[6] as bool),
        data = (response[7] as String);

  final BigInt certificateId;

  final BigInt certType;

  final BigInt dateIssue;

  final BigInt dateExpire;

  final _i1.EthereumAddress issuer;

  final _i1.EthereumAddress issedAgainst;

  final bool isPublic;

  final String data;
}

class InstitutionProfile {
  InstitutionProfile(List<dynamic> response)
      : isVerified = (response[0] as bool),
        institutionType = (response[1] as String),
        mainInstitution = (response[2] as bool),
        typeInt = (response[3] as BigInt),
        verifier = (response[4] as _i1.EthereumAddress);

  final bool isVerified;

  final String institutionType;

  final bool mainInstitution;

  final BigInt typeInt;

  final _i1.EthereumAddress verifier;
}

class UserProfiles {
  UserProfiles(List<dynamic> response)
      : userAddress = (response[0] as _i1.EthereumAddress),
        userName = (response[1] as String);

  final _i1.EthereumAddress userAddress;

  final String userName;
}
