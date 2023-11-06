/* Imports: Internal */
import { DeployFunction } from 'hardhat-deploy/dist/types'
import {
  deployAndVerifyAndThen,
} from '../scripts/deploy-utils';

const deployFn: DeployFunction = async (hre) => {
    
    await deployAndVerifyAndThen({
        hre,
        name: "TomoV2Impl",
        contract: 'TomoV2',
        args: [],
    })
}

// This is kept during an upgrade. So no upgrade tag.
deployFn.tags = ['TomoV2Impl']

export default deployFn
