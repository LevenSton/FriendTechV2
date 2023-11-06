/* Imports: Internal */
import { DeployFunction } from 'hardhat-deploy/dist/types'
import {
  deployAndVerifyAndThen,
  getContractFromArtifact
} from '../scripts/deploy-utils';

const deployFn: DeployFunction = async (hre) => {
    
  const {deployer} = await hre.getNamedAccounts()
  const TomoV2Proxy = await getContractFromArtifact(
    hre,
    "TomoV2Proxy",
    {
      iface: 'TomoV2',
      signerOrProvider: deployer,
    }
  )
  
  await deployAndVerifyAndThen({
      hre,
      name: "BondCurveModule",
      contract: 'BondCurveModule',
      args: [TomoV2Proxy.address],
  })
}

// This is kept during an upgrade. So no upgrade tag.
deployFn.tags = ['BondCurveModule']

export default deployFn
