class Cell: Hashable {
  fileprivate(set) var links : Set<Cell> = []
  fileprivate(set) var location : Location

  func hash(into hasher: inout Hasher) {
    hasher.combine(location.hashValue)
  }
    
  var neighbors: Set<Cell> {
    preconditionFailure("neighbors must be overridden in subclasses");
  }

  init(location: Location) {
    self.location = location
  }

  func linkOnceWith(_ neighbor: Cell) {
    links.insert(neighbor)
  }

  func unlinkOnceFrom(_ neighbor: Cell) {
    links.remove(neighbor)
  }

  func linkWith(_ neighbor: Cell) {
    linkOnceWith(neighbor)
    neighbor.linkOnceWith(self)
  }

  func unlinkFrom(_ neighbor: Cell) {
    unlinkOnceFrom(neighbor)
    neighbor.unlinkOnceFrom(self)
  }

  func isLinkedWith(_ neighbor: Cell?) -> Bool {
    if let neighbor = neighbor {
      return links.contains(neighbor)
    } else {
      return false
    }
  }

  func isDeadEnd() -> Bool {
    return links.count == 1
  }

  func reset() {
    links.removeAll()
  }
}

func ==(lhs: Cell, rhs: Cell) -> Bool {
  return lhs.location == rhs.location
}
