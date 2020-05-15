class OrthogonalCell: Cell {
  var gridLocation: GridLocation {
    return location as! GridLocation
  }

  var north: OrthogonalCell? = nil
  var south: OrthogonalCell? = nil
  var east: OrthogonalCell? = nil
  var west: OrthogonalCell? = nil

  override var neighbors: Set<Cell> {
    var neighbors: Set<Cell> = Set()
    if let north = north { neighbors.insert(north) }
    if let south = south { neighbors.insert(south) }
    if let east = east { neighbors.insert(east) }
    if let west = west { neighbors.insert(west) }
    return neighbors
  }

  override init(location: Location) {
    super.init(location: location)
  }
}
