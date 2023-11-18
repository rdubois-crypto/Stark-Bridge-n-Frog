// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// Uncomment this line to use console.log
//import "hardhat/console.sol";

interface IVerifier {
  function verifyProof(uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[18] memory input) external returns (bool);
}

contract Croa is ERC721, Ownable {
    using Strings for uint256;
    

    struct Properties {
        uint8 frogId;
        uint8 biome;
        uint8 rarity;
        uint8 temperament;
        uint256 jump;
        uint256 speed;
        uint256 intelligence;
        uint256 beauty;
        uint256 timestamp;        
    }

    struct Key {
        uint256 x;
        uint256 y;
    }

    IVerifier public verifier; 
    mapping(uint256 => Properties) public properties;
    mapping(uint256 => Key) public keys;
    string public defaultUrlImage;
    string public urlDomain;
    mapping(uint8 => bytes16) public urlImages;

    constructor(IVerifier _verifier) ERC721("FrogCrypto Onchain", "FROG") Ownable(msg.sender) {
        verifier = _verifier;
    }

    function bye() public onlyOwner {
        selfdestruct(payable(msg.sender));
    }

    function setVerifier (IVerifier _verifier) public onlyOwner {
        verifier = _verifier;
    }

    function setKey (uint256 _keyset, uint256 _x, uint256 _y) public onlyOwner {
        Key memory key;
        key.x = _x;
        key.y = _y;
        keys[_keyset] = key; 
    }

    function setUrlDomain (string memory _urlDomain) public onlyOwner {
        urlDomain = _urlDomain;
    }

    function setUrlImage(uint8 _frogId, bytes16 _uuid) public onlyOwner {
        urlImages[_frogId] = _uuid;
    }

    function uuidToString(bytes16 _data) internal pure returns(string memory) {
        bytes memory HEX = "0123456789abcdef";
        bytes memory str = new bytes(36);
        uint index = 0;
        for (uint i=0; i<16; i++) {
            if ((i == 4) || (i == 6) || (i == 8) || (i == 10)) {
                str[index] = '-';
                index++;
            }
            uint256 localValue = (uint)(uint8(_data[i]));
            str[index] = HEX[localValue >> 4];
            str[index + 1] = HEX[localValue & 0x0f];
            index+=2;
        }
        return (string)(str);
    }

    function getUrlImage(uint8 frogId) internal view returns(string memory) {
        string memory result = urlDomain;
        if (urlImages[frogId] == 0) {
            return defaultUrlImage;
        }
        return string(abi.encodePacked(result, '/', uuidToString(urlImages[frogId])));
    }

    function mint(uint256 keyset, uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[18] memory input) public returns (uint256) {
        verifier.verifyProof(a, b, c, input);
        Key memory key = keys[keyset];
        require((key.x != 0) && (key.y != 0), "Invalid keyset");
        require((input[14] == key.x) && (input[15] == key.y), "Non genuine frog");        
        // Compute a hopefully unique ID for this frog
        uint256 id = (uint256)(keccak256(abi.encodePacked(input[1], input[2], input[3], input[4], input[5], input[6], input[7], input[8], input[9],
        input[10])));
        Properties memory property;
        property.frogId = (uint8)(input[1]);
        property.biome = (uint8)(input[2]);
        property.rarity = (uint8)(input[3]);
        property.temperament = (uint8)(input[4]);
        property.jump = input[5];
        property.speed = input[6];
        property.intelligence = input[7];
        property.beauty = input[8];
        property.timestamp = input[9];
        properties[id] = property;
        _safeMint(address(uint160(uint256(input[17]))), id);
        return id;
    }

    function metadata(uint256 _tokenId) public view returns (string memory) {
        Properties memory property = properties[_tokenId];
        require(property.timestamp != 0, "Frog doesn't exist");
        string[9] memory traitType = [ "FrogId", "Biome", "Rarity", "Temperament", "Jump", "Speed", "Intelligence", "Beauty", "Timestamp"];        
        uint256[9] memory traitValue = [ property.frogId, property.biome, property.rarity, property.temperament, property.jump, property.speed, property.intelligence, property.beauty, property.timestamp];
        string memory attributes;
        for (uint256 i=0; i<9; i++) {
            attributes = string(abi.encodePacked(attributes,
                bytes(attributes).length == 0   ? '{' : ', {',
                    '"trait_type": "', traitType[i],'",',
                    '"value": "', traitValue[i].toString(), '"',
                '}'
            ));
        }        
        return string(abi.encodePacked(
            '{',
                '"name": "Frog #', _tokenId.toString(), '",', 
                '"description": "Onchain Frog",',
                '"image_url": "', getUrlImage(property.frogId), '",',            
                '"external_url": "https://zupass.org",',
                '"attributes": [', attributes, ']'
            '}'
        ));        
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return metadata(tokenId);
    }



}
