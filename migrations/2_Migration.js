
const guide = artifacts.require("Guide");
  
// module.exports = function (deployer) {
//   deployer.deploy(guide,["0x7d1fbB509D948890007e9cdfBd599e01740f9ba0",
//   "0x6f3b60671597f9aC228B3967c208c91bF55F4dBb",
//   "0xC009792C65581FDaEFC6FD5bEFe4B4e3130E9F42","0x0b75Ad754346b7073dab3f479B4115307840C079"], ["Gov","Med","Edu","Priv"]);
// };


module.exports = function (deployer) {
  deployer.deploy(guide,["0x8610B8EDe20713B20Ed5DAC9352b8f158BF8e62D",
  "0x1aAe884253e741b2e7bE68Dc547b8e49614C22a4",
  "0x7d1fbB509D948890007e9cdfBd599e01740f9ba0"], ["Gov","Med","Edu"]);
};