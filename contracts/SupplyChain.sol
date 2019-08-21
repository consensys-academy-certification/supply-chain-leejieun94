// Implement the smart contract SupplyChain following the provided instructions.
// Look at the tests in SupplyChain.test.js and run 'truffle test' to be sure that your contract is working properly.
// Only this file (SupplyChain.sol) should be modified, otherwise your assignment submission may be disqualified.

pragma solidity ^0.5.0;

contract SupplyChain {

  // Create a variable named 'itemIdCount' to store the number of items and also be used as reference for the next itemId.
  address payable owner = msg.sender;
  uint [] itemIdCount;
  uint itemId;
  uint price_add = 1 finney;

  // Create an enumerated type variable named 'State' to list the possible states of an item (in this order): 'ForSale', 'Sold', 'Shipped' and 'Received'.
  enum State {ForSale, Sold, Shipped, Received}

  // Create a struct named 'Item' containing the following members (in this order): 'name', 'price', 'state', 'seller' and 'buyer'.
  struct Item{
      string name;
      uint price;
      State state;
      bool seller;
      bool buyer;
  }

  // Create a variable named 'items' to map itemIds to Items.
  mapping(uint=>Item) items;

  // Create an event to log all state changes for each item.



  // Create a modifier named 'onlyOwner' where only the contract owner can proceed with the execution.
  modifier onlyOwner() {
      require(msg.sender == owner);
      _;
  }

  // Create a modifier named 'checkState' where the execution can only proceed if the respective Item of a given itemId is in a specific state.
 /* modifier checkState() {
      require((items[msg.sener].state==State.ForSale));
      _;
  }
*/
  // Create a modifier named 'checkCaller' where only the buyer or the seller (depends on the function) of an Item can proceed with the execution.
  modifier checkCaller(uint _id) {
      require((items[_id].seller==true)||(items[_id].buyer==true));
          _;
  }

  // Create a modifier named 'checkValue' where the execution can only proceed if the caller sent enough Ether to pay for a specific Item or fee.
  modifier checkValue() {
      require(items[itemId].price>=price_add);
      _;
  }


  // Create a function named 'addItem' that allows anyone to add a new Item by paying a fee of 1 finney. Any overpayment amount should be returned to the caller. All struct members should be mandatory except the buyer.
  function addItem (string memory _nm, uint _pr, State _st, bool _se, bool _bu) checkValue  payable public  {

      Item memory newItem;
      newItem.name = _nm;
      newItem.price = _pr;
      newItem.state = _st;
      newItem.seller = _se;
      newItem.buyer = _bu;
      uint newItemID = itemId;
      items[newItemID] = newItem;
      itemIdCount[newItemID]++;
      itemId++;

      if(newItem.seller==true){
          if(newItem.price>price_add){
              address(msg.sender).transfer(newItem.price-price_add);
          }
      }

  }
  // Create a function named 'buyItem' that allows anyone to buy a specific Item by paying its price. The price amount should be transferred to the seller and any overpayment amount should be returned to the buyer.
  function buyItem (uint _id) payable public {
   require(itemIdCount[_id]>0);
   require(msg.value>=items[_id].price);
  }
  // Create a function named 'shipItem' that allows the seller of a specific Item to record that it has been shipped.

  // Create a function named 'receiveItem' that allows the buyer of a specific Item to record that it has been received.

  // Create a function named 'getItem' that allows anyone to get all the information of a specific Item in the same order of the struct Item.

  // Create a function named 'withdrawFunds' that allows the contract owner to withdraw all the available funds.

}
