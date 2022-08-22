import { ethers } from "hardhat"
import { expect } from "chai"
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers"

describe("GasOutsource", () => {
	it("Should deploy and deposit 1 eth", async () => {
		let tx;

		const [addr1, addr2] = await ethers.getSigners()

		const GasOutsource = await ethers.getContractFactory("GasOutsource")
		const gasOutsource = await GasOutsource.deploy()

		console.log(gasOutsource.address)

		tx = await gasOutsource.deposit(addr2.address, { value: ethers.utils.parseEther("1") })
		console.log(await tx.wait())

		expect(await gasOutsource.funds(addr1.address, addr2.address)).to.equal(ethers.utils.parseEther("1"))

		describe("AnyContract", () => {

		})
	});
})