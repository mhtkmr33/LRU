import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Usage
        let lru = LRU<Int, String>(maxCapacity: 3)
        lru.set(key: 1, value: "L")
        lru.set(key: 2, value: "R")
        lru.set(key: 3, value: "U")
        lru.getValue(key: 3) // U

    }
}

class Node<T> {
    var value: T
    var next: Node<T>?
    init(value: T, next: Node<T>?) {
        self.value = value
        self.next = next
    }
}

class LinkedList<T> {

    var head: Node<T>?
    var listCount: Int = 0
    
    func addHead(value: T, shouldIncrementListCount: Bool = true) {
        if shouldIncrementListCount { listCount += 1 }
        let newNode = Node(value: value, next: nil)
        if head == nil {
            head = newNode
            return
        }
        let currentHead = head
        head = newNode
        head?.next = currentHead
    }
    
    func moveTohead(node: Node<T>) {
        if head === node { return }
        var currentNode = head
        var previousNode: Node<T>?
        var nextNode: Node<T>?
        while currentNode?.next != nil {
            nextNode = currentNode?.next
            previousNode = currentNode
            if nextNode === node {
                previousNode?.next = nextNode?.next
            }
            currentNode = nextNode
        }
        addHead(value: node.value, shouldIncrementListCount: false)
    }
    
    func removeLastElement() -> Node<T>? {
        var currentNode = head
        var previousNode: Node<T>?
        while currentNode?.next != nil {
            previousNode = currentNode
            currentNode = currentNode?.next
        }
        previousNode?.next = nil
        listCount -= 1
        return currentNode
    }
}

class LRU<Key: Hashable, Value> {
    
    private struct Payload {
        var key: Key
        var value: Value
    }
    
    private let capacity: Int
    private var list = LinkedList<Payload>()
    private var dictionary = [Key: Node<Payload>]()
    
    init(maxCapacity: Int) {
        capacity = maxCapacity
    }

    func set(key: Key, value: Value) {
        let newPayload = Payload(key: key, value: value)
        if let alreadyAddedNode = dictionary[key] {
            alreadyAddedNode.value = newPayload
            list.moveTohead(node: alreadyAddedNode)
        } else {
            list.addHead(value: newPayload)
            dictionary[key] = list.head
        }
        
        if list.listCount > capacity {
            if let lastNode = list.removeLastElement() {
                dictionary[lastNode.value.key] = nil
            }
        }
    }
    
    func getValue(key: Key) {
        if let valueNode = dictionary[key] {
            print(valueNode.value.value)
        } else {
            print("Nothing is here....")
        }
    }
}
