//
//  Heap.swift


public struct Heap<T> {
  // The array that stores the heap's nodes.
  var elements = [T]()

  // Determines whether this is a max-heap (>) or min-heap (<).
  private var isOrderedBefore: (T, T) -> Bool

  // Init for creating an empty heap.
  // The sort function determines whether this is a min-heap or max-heap.
  // For integers, > makes a max-heap, < makes a min-heap.
  public init(sort: (T, T) -> Bool) {
    self.isOrderedBefore = sort
  }

  // Init for creating a heap from an array. 
  public init(array: [T], sort: (T, T) -> Bool) {
    self.isOrderedBefore = sort
    buildHeap(array)
  }


  // Converts an array to a max-heap or min-heap in a bottom-up manner.
  private mutating func buildHeap(array: [T]) {
    elements = array
    for i in (elements.count/2 - 1).stride(through: 0, by: -1) {
        shiftDown(index: i, heapSize: elements.count)
    }
  }

  public var isEmpty: Bool {
    return elements.isEmpty
  }

  public var count: Int {
    return elements.count
  }

  // Returns the index of the parent of the element at index i.
  // The element at index 0 is the root of the tree and has no parent.
  @inline(__always) func indexOfParent(i: Int) -> Int {
     return (i - 1) / 2
    
    // As it was mentioned in the lab description:
    // parent(i) = floor((i - 1)/2)
    // left(i) = 2i + 1
    // right(i) = 2i + 2
    
  }

  // Returns the index of the left child of the element at index i.
  // Note that this index can be greater than the heap size, in which
  // case there is no left child.
  @inline(__always) func indexOfLeftChild(i: Int) -> Int {
    return (2 * i) + 1
  }

  // Returns the index of the right child of the element at index i.
  // Note that this index can be greater than the heap size, in which 
  // case there is no right child.
  @inline(__always) func indexOfRightChild(i: Int) -> Int {
    return (2 * i) + 2
  }

  // Returns the maximum value in the heap (for a max-heap) or the minimum

  public func peek() -> T? {
    return elements.first
  }

  // Adds a new value to the heap. This reorders the heap 
  // so that the max-heap or min-heap property still holds.
  public mutating func insert(value: T) {
    elements.append(value)
    shiftUp(index: elements.count - 1)
  }
  
  public mutating func insert<S: SequenceType where S.Generator.Element == T>(sequence: S) {
    for value in sequence {
      insert(value)
    }
  }

  
  // Allows you to change an element. In a max-heap, the new 
  // element should be larger than the old one; in a min-heap 
  // it should be smaller.
  public mutating func replace(index i: Int, value: T) {
    
    // Until we've reached the element in question
    // (i < elements.count), we determine if the heap is a
    // min or max-heap, then change the value at the index
    // (elements[i] = value) to value. Then we shift everything
    // up by i to accommodate for the replacement node
    
    guard i < elements.count else { return }
    
    assert(isOrderedBefore(value, elements[i]))
    elements[i] = value
    shiftUp(index: i)
    }

  // Removes the root node from the heap. For a max-heap, this
  // is the maximum value; for a min-heap it is the minimum value.
  
  public mutating func remove() -> T? {
    if elements.isEmpty {
        return nil
    }
    else if elements.count == 1 {
        return elements.removeLast()
    }
    else {
        let value = elements[0]
        elements[0] = elements.removeLast()
        shiftDown()
        return value
    }
    
  }

  // Removes an arbitrary node from the heap. 
  
public mutating func removeAtIndex(i: Int) -> T? {
    guard i < elements.count else { return nil }
    
    let size = elements.count - 1
    if i != size {
        let temp = elements[i]
        elements[i] = elements[size]
        elements[size] = temp
        shiftDown(index: i, heapSize: size)
        shiftUp(index: i)
    }
    return elements.removeLast()
  
  }

  // Takes a child node and looks at its parents; if a parent is 
  // not larger (max-heap) or not smaller (min-heap) than the 
  // child, we exchange them.
  
  mutating func shiftUp(index index: Int) {
    var childIndex = index
    let child = elements[childIndex]
    var parentIndex = self.indexOfParent(childIndex)
    
    while childIndex > 0 && isOrderedBefore(child, elements[parentIndex]) == true {
        elements[childIndex] = elements[parentIndex]
        childIndex = parentIndex
        parentIndex = self.indexOfParent(childIndex)
    }
    elements[childIndex] = child
  }

  mutating func shiftDown() {
    shiftDown(index: 0, heapSize: elements.count)
  }

  // Looks at a parent node and makes sure it is still larger 
  // (max-heap) or smaller (min-heap) than its children.

  mutating func shiftDown(index index: Int, heapSize: Int) {
    var parentIndex = index
    while true {
        let leftChildIndex = self.indexOfLeftChild(parentIndex)
        let rightChildIndex = self.indexOfRightChild(parentIndex)
        
        var first = parentIndex
        if leftChildIndex < heapSize && isOrderedBefore(elements[leftChildIndex], elements[first]) {
            first = leftChildIndex
        }
        if rightChildIndex < heapSize && isOrderedBefore(elements[rightChildIndex], elements[first]) {
            first = rightChildIndex
        }
        if first == parentIndex {
            return
        }
        let temp = elements[parentIndex]
        elements[parentIndex] = elements[first]
        elements[first] = temp
        parentIndex = first
    }
  }
}

// MARK: - Searching

extension Heap where T: Equatable {
  // Searches the heap for the given element.

  public func indexOf(element: T) -> Int? {
    return indexOf(element, 0)
  }

  private func indexOf(element: T, _ i: Int) -> Int? {
    if i >= count { return nil }
    if isOrderedBefore(element, elements[i]) { return nil }
    if element == elements[i] { return i }
    if let j = indexOf(element, indexOfLeftChild(i)) { return j }
    if let j = indexOf(element, indexOfRightChild(i)) { return j }
    return nil
  }
}
