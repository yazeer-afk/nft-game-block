//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import 'hardhat/console.sol';

contract EpicNFTGame is ERC721 {

    struct CharacterAttribute{
        uint characterIndex;
        string name;
        string imageUri;
        uint hp;
        uint maxHp;
        uint attackDamage;
    }

    CharacterAttribute[] defaultCharacters;

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint => CharacterAttribute) public nftAttributeHolder;
    mapping(address => uint) public nftOwners;


    constructor(
        string[] memory names,
        string[] memory imageURIs,
        uint[] memory characterHp,
        uint[] memory characterAtkDmg
    ) ERC721("GameCollectibles", "MC0") {
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
        _tokenIds.increment();
    }

    function mintCharacter(uint _characterIndex) external {
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);

        nftAttributeHolder[newItemId] = CharacterAttribute({
            characterIndex: _characterIndex,
            name: defaultCharacters[_characterIndex].name,
            imageUri: defaultCharacters[_characterIndex].imageUri,
            hp: defaultCharacters[_characterIndex].hp,
            maxHp: defaultCharacters[_characterIndex].maxHp,
            attackDamage: defaultCharacters[_characterIndex].attackDamage
        });

        nftOwners[msg.sender] = newItemId;
        _tokenIds.increment();
    }
}