/* Imports: Internal */
import { DeployFunction } from 'hardhat-deploy/dist/types'
import {
  getContractFromArtifact
} from '../scripts/deploy-utils'

const deployFn: DeployFunction = async (hre) => {

  const {governance} = await hre.getNamedAccounts()

  const TomoV2Proxy = await getContractFromArtifact(
    hre,
    "TomoV2Proxy",
    {
      iface: 'TomoV2',
      signerOrProvider: governance,
    }
  )

  const ConstCurveModule = await getContractFromArtifact(
    hre,
    "ConstCurveModule"
  )
  const LinearCurveModule = await getContractFromArtifact(
    hre,
    "LinearCurveModule"
  )
  const BondCurveModule = await getContractFromArtifact(
    hre,
    "BondCurveModule"
  )

  //set three curve module to be whitelist
  await TomoV2Proxy.whitelistCurveModule(ConstCurveModule.address, true);
  await TomoV2Proxy.whitelistCurveModule(LinearCurveModule.address, true);
  await TomoV2Proxy.whitelistCurveModule(BondCurveModule.address, true);

  //set state to open
  await TomoV2Proxy.setState(0);
}

// This is kept during an upgrade. So no upgrade tag.
deployFn.tags = ['PrepareEnv']

export default deployFn
