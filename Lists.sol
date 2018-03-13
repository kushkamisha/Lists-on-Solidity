pragma solidity ^0.4.19;

contract LinkedList {

    struct Node {
        int data;
        bytes32 prev;
    }
  
    event Push(bytes32 head, int data, bytes32 prev);

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
        emit Push(head, node.data, node.prev);
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
        
        if (n >= length) {
            return (-1, false);
        }
        
        for (uint i = 0; i < n; ++i) {
            currentNode = nodes[currentNode].prev;
        }
        
        return (nodes[currentNode].data, true);
    }
  
}

/**
 * Doubly linked list
 */
contract DoublyLinkedList {
    // Simple node structure
    struct Node {
        int data;
        bytes32 prev;
        bytes32 next;
    }
  
    // Push event, when push back or push front element to the list
    event Push(bytes32 head, int data, bytes32 prev, bytes32 next);

    uint public length = 0; // length of the list
    bytes32 public head; // head of the list
    bytes32 public tail; // tail of the list
    mapping (bytes32 => Node) public nodes; // dictionary of nodes (node hash, node)
    
    function DoublyLinkedList() public {}
    
    // Push back element to the list
    function push(int data) public returns (bool) {
        Node memory currentNode = Node(data, tail, 0x0);
        bytes32 currentNodeHash = keccak256(currentNode.data, now, length);
        nodes[currentNodeHash] = currentNode;
        if (head == 0x0) {
            head = currentNodeHash;
        }
        nodes[tail].next = currentNodeHash;
        tail = currentNodeHash;
        length++;
        emit Push(head, currentNode.data, currentNode.prev, currentNode.next);
    }
    
    // Push front element to the list
    function push_front(int data) public returns (bool) {
        Node memory currentNode = Node(data, 0x0, head);
        bytes32 currentNodeHash = keccak256(currentNode.data, now, length);
        nodes[currentNodeHash] = currentNode;
        if (tail == 0x0) {
            tail = currentNodeHash;
        }
        nodes[head].prev = currentNodeHash;
        head = currentNodeHash;
        length++;
        emit Push(head, currentNode.data, currentNode.prev, currentNode.next);
    }
  
    // Show all list
    function print() public constant returns (int[]) {
        int[] memory list = new int[](length);
        bytes32 currentNode = head;
          
        for (uint i = 0; i < length; ++i) {
            list[i] = nodes[currentNode].data;
            currentNode = nodes[currentNode].next;
        }
          
        return list;
    }
  
    // Get list element by index
    function get(uint n) public constant returns (int, bool) {
        bytes32 currentNode;
        uint i;
        
        if (n >= length) {
            return (-1, false);
        }
        
        if (n < length / 2) {
            currentNode = head;
            
            for (i = 0; i < n; ++i) {
                currentNode = nodes[currentNode].next;
            }
        } else {
            currentNode = tail;
            
            for (i = length; i > n; --i) {
                currentNode = nodes[currentNode].prev;
            }
        }
        
        return (nodes[currentNode].data, true);
    }
 
}