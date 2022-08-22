import { ethers } from "hardhat"
import { expect } from "chai"
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers"

import { BigNumber, ContractReceipt } from "ethers";

function paid(receipt: ContractReceipt): BigNumber {
	return receipt.cumulativeGasUsed.mul(receipt.effectiveGasPrice)
}

describe("GasOutsource", () => {
	it("Should deploy GasOutsource and deposit 1 eth", async () => {
		let tx, receipt;

		const [owner, seller, client] = await ethers.getSigners()

		const GasOutsource = await ethers.getContractFactory("GasOutsource")
		const gasOutsource = await GasOutsource.deploy()

		tx = await gasOutsource.connect(client).deposit(seller.address, { value: ethers.utils.parseEther("1") })
		receipt = await tx.wait()

		expect(await gasOutsource.funds(client.address, seller.address)).to.equal(ethers.utils.parseEther("1"))
		expect(await client.getBalance()).to.equal(ethers.utils.parseEther("10000").sub(ethers.utils.parseEther("1")).sub(paid(receipt)))

		describe("AnyContract", () => {
			it("Should deploy AnyContract", async () => {
				const AnyContract = await ethers.getContractFactory("AnyContract")
				const anyContract = await AnyContract.connect(seller).deploy(gasOutsource.address, client.address)

				receipt = await anyContract.deployTransaction.wait()

				console.log('Paid', ethers.utils.formatEther(paid(receipt)), 'eth')
			})
		})
	});
})