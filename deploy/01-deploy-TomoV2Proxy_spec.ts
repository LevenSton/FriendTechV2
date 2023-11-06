/* Imports: Internal */
import { DeployFunction } from 'hardhat-deploy/dist/types'
import {
  deployAndVerifyAndThen,
  getContractFromArtifact,
} from '../scripts/deploy-utils'

const deployFn: DeployFunction = async (hre) => {
  const TomoV2Impl = await getContractFromArtifact(
    hre,
    "TomoV2Impl"
  )
  const { deployer,  governance, tomosign} = await hre.getNamedAccounts()

  let data = TomoV2Impl.interface.encodeFunctionData('initialize', [
    governance, deployer, tomosign
  ]);

  await deployAndVerifyAndThen({
    hre,
    name: "TomoV2Proxy",
    contract: 'TransparentUpgradeableProxy',
    args: [TomoV2Impl.address, deployer, data],
  })
}

// This is kept during an upgrade. So no upgrade tag.
deployFn.tags = ['TomoV2Proxy']

export default deployFn
