// const { default: userEvent } = require('@testing-library/user-event');
const Web3 = require('web3')
const web3 = new Web3('http://192.168.0.106:7545')
let contractAbi = require('../build/contracts/Guide.json').abi
// console.log(contractAbi)
// contract address 0x45c7DC5c7CB32f989C64cE20269E714dcf0886f6
let contract = new web3.eth.Contract(contractAbi, "0x23256097B60857005910de7785747730491D32fb")
// let role  = await
 contract.methods.getRole("0x7d1fbB509D948890007e9cdfBd599e01740f9ba0").call().then(console.log)



 var accounts=[
    '0x7d1fbB509D948890007e9cdfBd599e01740f9ba0',
    '0x6f3b60671597f9aC228B3967c208c91bF55F4dBb',
    '0xC009792C65581FDaEFC6FD5bEFe4B4e3130E9F42',
    '0x0b75Ad754346b7073dab3f479B4115307840C079',
    '0x7Ac281C7b1bB16f90ee1900EF3e8793fbc57429c',
    '0xF17aAd8EF8275c1d4F12296f6E6b3CA843474501',
    '0x69f4E0af68AebB959d06C37545bd7DB4FeB81A93',
    '0x333B1b7aA8AbAa0e63368Ef1e1dEBE58ae11270C',
    '0xd430d224465e53013D49679b173d7E2c9f63394e',
    '0x7415B775776bcBd2e4A966E8638427E3Dcaacd56' 
  ];


// var accounts=[]
async function getAccounts(){
     accounts = await web3.eth.getAccounts()
    console.log(accounts)
}

async function createUser(){
    let result  =  await contract.methods.RegisterUser().send({from:accounts[8]});
    console.log(accounts[8]+"creted user");
}



async function getUsersCertIds(acco){
     await contract.methods.getCurrentUserCertificateIDs().call({from:acco}).then(console.log);
    // console.log("user cert Ids" + result);
}



async function publishCertificates(to,from,data,visibility){

    let result = await contract.methods.publishCertificate(121,34123,456,to,[],visibility,data).send({from:from,gas:3000000}).then(console.log);
    console.log(to + "got certificate from "+from + "    "  );
}

async function getCertificate(n,from){
     contract.methods.getCertificate(n).call({from:from}).then(console.log).then(console.log);
 
    // return result;
}

// getAccounts()



// ?publish cert
publishCertificates(accounts[8],accounts[1],"some cert here again 2",false).then((result)=>{
console.log(result)
}
);




// getUsersCertIds("0xd430d224465e53013D49679b173d7E2c9f63394e")



// getCertificate(4,accounts[8])

web3.eth.getBalance(accounts[0]).then((bal)=>console.log("bal :"+bal));



// createUser();
// created 0xd430d224465e53013D49679b173d7E2c9f63394e


// function publishCertificate(int certType,int256 dateIssue,int256 dateExpire,
// address issedAgainst,address[] memory taggedInstutions,bool isPublic,string memory data)



