const { expect } = require("chai");
const hre = require("hardhat");

describe("GasOutsource", () => {
  let gasOutsource;

  beforeEach("Should deploy the contract", async () => {
    const GasOutsource = await hre.ethers.getContractFactory("GasOutsource");
    gasOutsource = await GasOutsource.deploy();
  })


})

