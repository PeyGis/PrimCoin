const PrimCoin = artifacts.require("PrimCoin");

module.exports = function (deployer) {
  deployer.deploy(PrimCoin);
};
