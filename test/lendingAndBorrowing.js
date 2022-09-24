/* global describe it before ethers */

const {
    getSelectors,
    FacetCutAction,
    removeSelectors,
    findAddressPositionInFacets
  } = require('../scripts/libraries/diamond.js')
  
  const { deployDiamond } = require('../scripts/deploy.js')
  
  const { assert, expect } = require('chai');
const { ethers } = require('hardhat');
  
  describe('DiamondTest', async function () {
    let diamondAddress;
    let diamondCutFacet;
    let diamondLoupeFacet;
    let ownershipFacet
    let lendingFacet;
    let tx;
    let receipt;
    let result;
    const addresses = []
  
    before(async function () {
      diamondAddress = await deployDiamond();
      diamondCutFacet = await ethers.getContractAt('DiamondCutFacet', diamondAddress);
      diamondLoupeFacet = await ethers.getContractAt('DiamondLoupeFacet', diamondAddress);
      ownershipFacet = await ethers.getContractAt('OwnershipFacet', diamondAddress);
      lendingFacet = await ethers.getContractAt("Lending_Borrowing", diamondAddress);
      ERC20 = await ethers.getContractAt('ERC20', '0xc09A7ACB62A4E1a01EF40D4Df1897E042b7761a5') 
    })
  
    it('Testing depositEther', async () => {
        const [signer] = await ethers.getSigners();
        lendingFacet.depositEther({value: ethers.utils.parseEther("1")});

        const provider = await ethers.provider;

        const balance = await provider.getBalance(diamondAddress);

        console.log(balance)

        await expect(balance).to.equal(ethers.utils.parseEther("1"));
    })

    it('testing checkuserbalance', async () =>{
        await expect(checkuserbalance()).to.equal(ethers.utils.parseEther("1"));
    })

    it("testing getFREECOINS", async () =>{
        ERC20._mint(diamondAddress, 500);
        await getFREECOINS();
        const contractbalance = await ERC20.balanceOf(diamondAddress);
        console.log(contractbalance);
    })
})


  