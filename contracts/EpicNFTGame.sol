//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import 'hardhat/console.sol';

contract EpicNFTGame{

    struct CharacterAttribute{
        uint characterIndex;
        string name;
        string imageUri;
        uint hp;
        uint maxHp;
        uint attackDamage;
    }

    CharacterAttribute[] defaultCharacters;

    constructor(
        string[] memory names,
        string[] memory imageURIs,
        uint[] memory characterHp,
        uint[] memory characterAtkDmg
    ){
        for (uint256 index = 0; index < names.length; index += 1) {
            CharacterAttribute memory attributes = CharacterAttribute({
                characterIndex: index,
                name: names[index],
                imageUri: imageURIs[index],
                hp: characterHp[index],
                maxHp: characterHp[index],
                attackDamage: characterAtkDmg[index]
            });

            defaultCharacters.push(attributes);

            console.log("Done initializing %s w/ HP %s, img %s", attributes.name, attributes.hp, attributes.imageUri);
        }
    }
}