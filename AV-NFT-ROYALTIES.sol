pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/drafts/Counters.sol";

//based off of the crypto fax contract
contract StreamToken is ERC721Full {

    constructor() ERC721Full("StreamToken", "SAV") public { }

    using Counters for Counters.Counter;
    Counters.Counter token_ids;

    struct Art {
      //Implement artwork struct
      string hash;
      uint plays;
      // ^ represents the number of PLAYS for this ART has based on its HASH
    }

    // Stores token_id => Art
    // Only permanent data that you would need to use in a smart contract later should be stored on-chain
    mapping(uint => Art) public arts;

    // log and report the plays or streams
    // events allow apps to update and monitor given values on the blockchain
    event Plays(uint token_id, string report_uri);

    function registerArtwork(address owner, string memory hash, string memory token_uri) public returns(uint) {
        token_ids.increment();
        uint token_id = token_ids.current();

        _mint(owner, token_id);
        _setTokenURI(token_id, token_uri);

        arts[token_id] = Art(hash, 0);

        return token_id;
    }

    function recordStream(uint token_id, string memory report_uri) public returns(uint) {
       //Implement recordStream
       arts[token_id].plays += 1;
       
       // permanently associates the report_uri with the token_id on-chain via Events for a lower gas-cost than storing directly within this contract
       emit Plays(token_id, report_uri);
       
       return arts[token_id].plays;
    }
}