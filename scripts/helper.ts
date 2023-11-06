import { ethers } from 'ethers'

let deployer = ethers.Wallet.createRandom();
let gover = ethers.Wallet.createRandom();
let tomosign = ethers.Wallet.createRandom();

console.log(deployer.privateKey)
console.log(gover.privateKey)
console.log(tomosign.privateKey)

console.log('-------------')

console.log(deployer.address)
console.log(gover.address)
console.log(tomosign.address)