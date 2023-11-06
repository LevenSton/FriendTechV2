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

  const ConstCuveModule = await getContractFromArtifact(
    hre,
    "ConstCuveModule"
  )
  const LinearCuveModule = await getContractFromArtifact(
    hre,
    "LinearCuveModule"
  )
  const BondCuveModule = await getContractFromArtifact(
    hre,
    "BondCuveModule"
  )

  //set three curve module to be whitelist
  await TomoV2Proxy.whitelistCurveModule(ConstCuveModule.address, true);
  await TomoV2Proxy.whitelistCurveModule(LinearCuveModule.address, true);
  await TomoV2Proxy.whitelistCurveModule(BondCuveModule.address, true);

  //set state to open
  await TomoV2Proxy.setState(0);
}

// This is kept during an upgrade. So no upgrade tag.
deployFn.tags = ['PrepareEnv']

export default deployFn
