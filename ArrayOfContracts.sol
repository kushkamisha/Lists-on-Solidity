pragma solidity ^0.4.21;

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
    function get(uint n) constant public returns (int) {
        bytes32 currentNode;
        uint i;
        
        if (n >= length) {
            return -1;
        }
        
        if (n < length / 2) {
            currentNode = head;
            
            for (i = 0; i < n; ++i) {
                currentNode = nodes[currentNode].next;
            }
        } else {
            currentNode = tail;
            
            for (i = length-1; i > n; --i) {
                currentNode = nodes[currentNode].prev;
            }
        }
        
        return nodes[currentNode].data;
    }
    
}

contract ContractsArray {
    DoublyLinkedList[] public arr;
    
    function getFirstColumnLength() constant public returns(uint) {
        return arr[0].length();
    }
    
    function addColumn() public {
        arr.push(new DoublyLinkedList());
    }
    
    function FirstColumnPush(int data) public {
        DoublyLinkedList dll = arr[0];
        dll.push(data);
    }
    
    function get(uint index) constant public returns(int) {
        DoublyLinkedList dll = arr[0];
        int value = dll.get(index);
        
        return value;
    }
}
