pragma solidity ^0.4.21;

/**
 * Doubly linked list with Int data
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

/**
 * Doubly linked list with String data
 */ 
contract DoublyLinkedListString {
    
    // Simple node structure
    struct Node {
        string data;
        bytes32 prev;
        bytes32 next;
    }
  
    // Push event, when push back or push front element to the list
    event PushString(bytes32 head, string data, bytes32 prev, bytes32 next);

    uint public length = 0; // length of the list
    bytes32 public head; // head of the list
    bytes32 public tail; // tail of the list
    mapping (bytes32 => Node) public nodes; // dictionary of nodes (node hash, node)
    
    // Push back element to the list
    function push(string data) public returns (bool) {
        Node memory currentNode = Node(data, tail, 0x0);
        bytes32 currentNodeHash = keccak256(currentNode.data, now, length);
        nodes[currentNodeHash] = currentNode;
        if (head == 0x0) {
            head = currentNodeHash;
        }
        nodes[tail].next = currentNodeHash;
        tail = currentNodeHash;
        length++;
        emit PushString(head, currentNode.data, currentNode.prev, currentNode.next);
    }
    
    // Push front element to the list
    function push_front(string data) public returns (bool) {
        Node memory currentNode = Node(data, 0x0, head);
        bytes32 currentNodeHash = keccak256(currentNode.data, now, length);
        nodes[currentNodeHash] = currentNode;
        if (tail == 0x0) {
            tail = currentNodeHash;
        }
        nodes[head].prev = currentNodeHash;
        head = currentNodeHash;
        length++;
        emit PushString(head, currentNode.data, currentNode.prev, currentNode.next);
    }
  
    // Get list element by index
    function get(uint n) constant public returns (string) {
        bytes32 currentNode;
        uint i;
        
        if (n >= length) {
            return ":(";
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

contract DllForDlls {
    
    // Simple node structure
    struct Node {
        DoublyLinkedList dll;
        bytes32 prev;
        bytes32 next;
    }
  
    // Push event, when push back or push front element to the list
    event PushToDllOfDlls(bytes32 head, DoublyLinkedList dll, bytes32 prev, bytes32 next);

    uint public length = 0; // length of the list
    bytes32 public head; // head of the list
    bytes32 public tail; // tail of the list
    mapping (bytes32 => Node) public nodes; // dictionary of nodes (node hash, node)
    
    // Push back element to the list
    function push(DoublyLinkedList dll) public {
        Node memory currentNode = Node(dll, tail, 0x0);
        bytes32 currentNodeHash = keccak256(currentNode.dll, now, length);
        nodes[currentNodeHash] = currentNode;
        if (head == 0x0) {
            head = currentNodeHash;
        }
        nodes[tail].next = currentNodeHash;
        tail = currentNodeHash;
        length++;
        emit PushToDllOfDlls(head, currentNode.dll, currentNode.prev, currentNode.next);
    }
  
    // Show all list
    // function print() public constant returns (int[]) {
    //     int[] memory list = new int[](length);
    //     bytes32 currentNode = head;
          
    //     for (uint i = 0; i < length; ++i) {
    //         list[i] = nodes[currentNode].data;
    //         currentNode = nodes[currentNode].next;
    //     }
          
    //     return list;
    // }
  
    // Get list by index
    function get(uint n) constant public returns (DoublyLinkedList) {
        bytes32 currentNode;
        uint i;
        
        // if (n >= length) {
        //     return -1;
        // }
        
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
        
        DoublyLinkedList askedList = nodes[currentNode].dll;
        
        return askedList;
    }
    
}

contract ContractsArray {
    
    DllForDlls table = new DllForDlls();
    
    uint public numberOfCols = 0;
    
    // Adds column to the end of the table
    function addColumn() public {
        table.push(new DoublyLinkedList());
        numberOfCols++;
    }
    
    // Adds data to the end of the column getted by index
    function addToColumn(uint index, int data) public {
        DoublyLinkedList column = table.get(index);
        column.push(data);
    }
    
    // Get cell by column index and row index
    function get(uint columnIndex, uint rowIndex) constant public returns(int) {
        DoublyLinkedList column = table.get(columnIndex);
        int value = column.get(rowIndex);
        
        return value;
    }
    
}