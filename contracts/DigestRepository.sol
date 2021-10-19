pragma solidity ^0.8.9;


contract DigestRepository {
  // Contract owner
  address owner;

  // The main storage in the contract. Mapping of hash sum to status. Posible status values are listed below.
  mapping (int256 => uint8) digestStore;

  // Various statuses, can be extended with time.
  uint8 constant UNKNOWN = 0;
  uint8 constant VALID = 1;
  uint8 constant INVALID = 2;
  uint8 constant EXPIRED = 3;


  modifier onlyByOwner()
  {
      require(msg.sender == owner);
      _;
  }

  constructor() {
    owner = msg.sender;
  }

  function getOwner() public view returns(address){
    return owner;
  }

  function addValidDigest(int256 digest) public onlyByOwner {
    digestStore[digest] = VALID;
    emit digestUpdated(digest, VALID);
  }

  function invalidateDigest(int256 digest) public onlyByOwner {
    digestStore[digest] = INVALID;
    emit digestUpdated(digest, INVALID);
  }

  function expireDigest(int256 digest) public onlyByOwner {
    digestStore[digest] = EXPIRED;
    emit digestUpdated(digest, EXPIRED);
  }

  function checkDigest(int256 digest) public view returns(uint8) {
    return digestStore[digest];
  }

  event digestUpdated(int256 digest, uint8 newStatus);

}
