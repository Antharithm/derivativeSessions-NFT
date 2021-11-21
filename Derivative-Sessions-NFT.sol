pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/drafts/Counters.sol";

contract DerivativeSessions is ERC721Full {

    using Counters for Counters.Counter;
    Counters.Counter token_ids;

    struct Artwork {
        string name;
        string artist;
        uint appraisal_value;
    }
/*
    ipfs://bafkreihhxtl7nzep2t4akvlrjs72slrefeshoznqg47p5or5himh4d6vw4
    Derivative Sessions Logo ^^^
    
    ipfs://bafybeify7jbo3zmbyctq33abz5sdxeulfliowkdsxv5ykvaa5ld5vkz3ra
    Conscious Tortoise artwork ^^^
    
    ipfs://bafybeigjqgeb6iyifi7rfavjxnsfxtdh2r5ewce4c5zxhshqlho43k3mga
    Emagination artwork ^^^
    
    ipfs://bafybeih4b2u3onjlc7pcs26ydohxasnimddeh4nzvbwgeozcdql4iczd5q
    Expansion Project - The Garden (demo) audio ^^^
    
    ipfs://bafybeigjqgeb6iyifi7rfavjxnsfxtdh2r5ewce4c5zxhshqlho43k3mga
    Expansion Project - Emagination audio ^^^
*/
    mapping(uint => Artwork) public art_collection;

    event Appraisal(uint token_id, uint appraisal_value, string report_uri);
    
    constructor() ERC721Full("DerivativeToken", "DVS") public { }

    function registerArtwork(
        address owner, 
        string memory name, 
        string memory artist, 
        uint initial_value, 
        string memory token_uri
    )   
        public 
        returns(uint) 
    {
        token_ids.increment();
        uint token_id = token_ids.current();

        _mint(owner, token_id);
        _setTokenURI(token_id, token_uri);

        art_collection[token_id] = Artwork(name, artist, initial_value);

        return token_id;
    }

    function newAppraisal(uint token_id, uint new_value, string memory report_uri) public returns(uint) {
        art_collection[token_id].appraisal_value = new_value;

        emit Appraisal(token_id, new_value, report_uri);

        return art_collection[token_id].appraisal_value;
    }
}
