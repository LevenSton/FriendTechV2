
import '@nomiclabs/hardhat-ethers';
import { expect } from 'chai';
import { Signer, Wallet } from 'ethers';
import { ethers } from 'hardhat';
import {
  LinearCurveModule,
  LinearCurveModule__factory,
  BondCurveModule,
  BondCurveModule__factory,
  ConstCurveModule,
  ConstCurveModule__factory,
  TomoV2,
  TomoV2__factory,
  TransparentUpgradeableProxy__factory,
  Events,
  Events__factory,
} from '../typechain-types';
import {
  TomoV2State,
  revertToSnapshot,
  takeSnapshot,
} from './helpers/utils';
import { SIGN_PRIVATEKEY, ZERO_ADDRESS } from './helpers/constants';
import hre from 'hardhat'
import {utils} from 'ethers';
import { ERRORS } from './helpers/errors';
import {buildBuySeparator} from './helpers/utils'

export let accounts: Signer[];
export let deployer: Signer;
export let governance: Signer;
export let user: Signer;
export let userTwo: Signer;
export let userThree: Signer;
export let deployerAddress: string;
export let governanceAddress: string;
export let userAddress: string;
export let userTwoAddress: string;
export let userThreeAddress: string;
export let tomoV2Impl: TomoV2;
export let tomoV2Proxy: TomoV2;
export let constCurveModule: ConstCurveModule;
export let linearCurveModule: LinearCurveModule;
export let bondCurveModule: BondCurveModule;
export let eventsLib: Events;

export let abiCoder = hre.ethers.utils.defaultAbiCoder;
export let signWallet: Wallet;

export let buyAmount = 200;
export let buyAmount1 = 220;
export let buyAmountForFragment = 2;
export const TOMO_NAME = 'Tomo';

export function makeSuiteCleanRoom(name: string, tests: () => void) {
  describe(name, () => {
    beforeEach(async function () {
      await takeSnapshot();
    });
    tests();
    afterEach(async function () {
      await revertToSnapshot();
    });
  });
}

before(async function () {
  abiCoder = ethers.utils.defaultAbiCoder;
  accounts = await ethers.getSigners();
  deployer = accounts[0];
  governance = accounts[1];
  user = accounts[2];
  userTwo = accounts[3];
  userThree = accounts[4];

  signWallet = new ethers.Wallet(SIGN_PRIVATEKEY).connect(ethers.provider);

  deployerAddress = await deployer.getAddress();
  governanceAddress = await governance.getAddress();
  userAddress = await user.getAddress();
  userTwoAddress = await userTwo.getAddress();
  userThreeAddress = await userThree.getAddress();

  tomoV2Impl = await new TomoV2__factory(deployer).deploy();

  let data = tomoV2Impl.interface.encodeFunctionData('initialize', [
    governanceAddress, deployerAddress, signWallet.address
  ]);
  let proxy = await new TransparentUpgradeableProxy__factory(deployer).deploy(
    tomoV2Impl.address,
    deployerAddress,
    data
  );
  
  // Connect the hub proxy to the TomoHubEntryPoint factory and the user for ease of use.
  tomoV2Proxy = TomoV2__factory.connect(proxy.address, user);


  constCurveModule = await new ConstCurveModule__factory(deployer).deploy(tomoV2Proxy.address);
  linearCurveModule = await new LinearCurveModule__factory(deployer).deploy(tomoV2Proxy.address);
  bondCurveModule = await new BondCurveModule__factory(deployer).deploy(tomoV2Proxy.address);

  await expect(tomoV2Proxy.connect(governance).setGovernance(userAddress)).to.not.be.reverted;
  await expect(tomoV2Proxy.connect(user).setGovernance(governanceAddress)).to.not.be.reverted;
  await expect(tomoV2Proxy.connect(governance).setState(TomoV2State.Open)).to.not.be.reverted;
  await expect(tomoV2Proxy.connect(governance).whitelistCurveModule(constCurveModule.address,true)).to.not.be.reverted;
  await expect(tomoV2Proxy.connect(governance).whitelistCurveModule(linearCurveModule.address,true)).to.not.be.reverted;
  await expect(tomoV2Proxy.connect(governance).whitelistCurveModule(bondCurveModule.address,true)).to.not.be.reverted;


  await expect(tomoV2Proxy.connect(user).setGovernance(userAddress)).to.be.revertedWithCustomError(tomoV2Proxy, ERRORS.NOT_GOVERNANCE);
  await expect(tomoV2Proxy.connect(user).setState(TomoV2State.Open)).to.be.revertedWithCustomError(tomoV2Proxy, ERRORS.NOT_GOVERNANCE);
  await expect(tomoV2Proxy.connect(user).whitelistCurveModule(bondCurveModule.address,true)).to.be.revertedWithCustomError(tomoV2Proxy, ERRORS.NOT_GOVERNANCE);

  expect(tomoV2Proxy).to.not.be.undefined;

  // Event library deployment is only needed for testing and is not reproduced in the live environment
  eventsLib = await new Events__factory(deployer).deploy();

  const sig = await buildBuySeparator(tomoV2Proxy.address, TOMO_NAME, userAddress, userTwoAddress, buyAmount);
});
