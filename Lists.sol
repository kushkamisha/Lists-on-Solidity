pragma solidity ^0.4.19;

contract LinkedList {

    struct Node {
        int data;
        bytes32 prev;
    }
  
//   event Push(bytes32 head, int data, bytes32 prev);

    uint public length = 0;
    bytes32 public head;
    mapping (bytes32 => Node) public nodes;
    
    function LinkedList() public {}
    
    function push_front(int data) public returns (bool) {
        Node memory node = Node(data, head);
        bytes32 id = keccak256(node.data, now, length);
        nodes[id] = node;
        head = id;
        length += 1;
        // emit Push(head, node.data, node.prev);
    }
  
    function print() public constant returns (int[]) {
        int[] memory list = new int[](length);
        bytes32 currentNode = head;
          
        for (uint i = 0; i < length; ++i) {
            list[i] = nodes[currentNode].data;
            currentNode = nodes[currentNode].prev;
        }
          
        return list;
    }
  
    function get(uint n) public constant returns (int, bool) {
        bytes32 currentNode = head;
        uint index = 0;
        
        if (n >= length) {
            return (-1, false);
        }
        
        for (uint i = 0; i < n; ++i) {
            currentNode = nodes[currentNode].prev;
        }
        
        return (nodes[currentNode].data, true);
    }
  
}


contract DoublyLinkedList {

    struct Node {
        int data;
        bytes32 prev;
        bytes32 next;
    }
  
//   event Push(bytes32 head, int data, bytes32 prev);

    uint public length = 0;
    bytes32 public head;
    mapping (bytes32 => Node) public nodes;
    
    function DoublyLinkedList() public {}
    
    function push_front(int data) public returns (bool) {
        Node memory node = Node(data, head, head);
        bytes32 id = keccak256(node.data, now, length);
        nodes[id] = node;
        head = id;
        length += 1;
        // emit Push(head, node.data, node.prev);
    }
  
    function print() public constant returns (int[]) {
        int[] memory list = new int[](length);
        bytes32 currentNode = head;
          
        for (uint i = 0; i < length; ++i) {
            list[i] = nodes[currentNode].data;
            currentNode = nodes[currentNode].prev;
        }
          
        return list;
    }
  
    function get(uint n) public constant returns (int, bool) {
        bytes32 currentNode = head;
        uint index = 0;
        
        if (n >= length) {
            return (-1, false);
        }
        
        for (uint i = 0; i < n; ++i) {
            currentNode = nodes[currentNode].prev;
        }
        
        return (nodes[currentNode].data, true);
    }
 
}