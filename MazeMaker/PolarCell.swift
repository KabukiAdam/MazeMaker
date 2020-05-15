class PolarCell: Cell {
  var polarLocation: PolarLocation {
    return location as! PolarLocation
  }

  var outward: Array<PolarCell> = []
  var inward: PolarCell? = nil
  var cw: PolarCell? = nil
  var ccw: PolarCell? = nil

  override var neighbors: Set<Cell> {
    var neighbors: Set<Cell> = Set(outward)
    if let inward = inward { neighbors.insert(inward) }
    if let cw = cw { neighbors.insert(cw) }
    if let ccw = ccw { neighbors.insert(ccw) }
    return neighbors
  }

  override init(location: Location) {
    super.init(location: location)
  }
}
