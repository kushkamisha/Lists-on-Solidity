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
    
    // Push front element to the list
    // function push_front(int data) public returns (bool) {
    //     Node memory currentNode = Node(data, 0x0, head);
    //     bytes32 currentNodeHash = keccak256(currentNode.data, now, length);
    //     nodes[currentNodeHash] = currentNode;
    //     if (tail == 0x0) {
    //         tail = currentNodeHash;
    //     }
    //     nodes[head].prev = currentNodeHash;
    //     head = currentNodeHash;
    //     length++;
    //     emit Push(head, currentNode.data, currentNode.prev, currentNode.next);
    // }
  
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
        // int askedCell = askedList.get(m);
        
        return askedList;
    }
    
}

contract ContractsArray {
    // DoublyLinkedList[] arr;
    
    // // Get column length by column index
    // function getColumnLength(uint index) constant public returns(uint) {
    //     return arr[index].length();
    // }
    
    // // Adds column to the end of the table
    // function addColumn() public {
    //     arr.push(new DoublyLinkedList());
    // }
    
    // // Adds data to the end of the column getted by index
    // function FirstColumnPush(uint index, int data) public {
    //     DoublyLinkedList dll = arr[index];
    //     dll.push(data);
    // }
    
    // // Get cell by column index and row index
    // function get(uint columnIndex, uint rowIndex) constant public returns(int) {
    //     DoublyLinkedList dll = arr[columnIndex];
    //     int value = dll.get(rowIndex);
        
    //     return value;
    // }
    
    DllForDlls table = new DllForDlls();
    
    // Adds column to the end of the table
    function addColumn() public {
        DoublyLinkedList dll = new DoublyLinkedList();
        table.push(dll);
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