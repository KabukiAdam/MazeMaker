enum PriorityWeighting {
  case lowestFirst, highestFirst
}

class PriorityQueue<U: Hashable> {
  typealias Pair = (item: U, priority: Int)

  fileprivate let heap: BinaryHeap<Pair>
  fileprivate var priorities: [U: Int] = [:]

  var isEmpty: Bool {
    return heap.isEmpty
  }

  init(compare: @escaping (Pair, Pair) -> HeapComparisonResult) {
    heap = BinaryHeap<Pair>(compare: compare)
  }

  convenience init(weighting: PriorityWeighting) {
    let lowestFirst = { (a: Pair, b: Pair) -> HeapComparisonResult in
        if a.priority < b.priority {
          return .higher
        } else if a.priority > b.priority {
          return .lower
        } else {
          return .equal
        }
      }

    let highestFirst = { (a: Pair, b: Pair) -> HeapComparisonResult in
      if a.priority > b.priority {
        return .higher
      } else if a.priority < b.priority {
        return .lower
      } else {
        return .equal
      }
    }

    switch weighting {
    case .lowestFirst:
      self.init(compare: lowestFirst)
    case .highestFirst:
      self.init(compare: highestFirst)
    }
  }

  subscript(element: U) -> Int? {
    get {
      return priorities[element]
    }

    set(newValue) {
      let newValue = newValue!

      if let priority = priorities[element] {
        _ = heap.deleteElement((element, priority))
      }

      heap.insert((element, newValue))
      priorities[element] = newValue
    }
  }

  func fromCollection<S: Collection>(_ collection: S) where S.Iterator.Element == Pair {
    priorities.removeAll()

    for pair in collection {
      priorities[pair.item] = pair.priority
    }

    heap.buildHeap(collection)
  }

  func next() -> Pair? {
    if let pair = heap.delete() {
      priorities.removeValue(forKey: pair.item)
      return pair
    }

    return nil
  }
}
