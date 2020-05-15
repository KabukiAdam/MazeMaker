class GridLocation: Location {
  let row: Int
  let column: Int

  override var hashValue: Int {
    return row * 1000 + column
  }

  init(row: Int, column: Int) {
    self.row = row
    self.column = column
  }

  func change(rowBy row: Int = 0, columnBy column: Int = 0) -> GridLocation {
    return GridLocation(row: self.row + row, column: self.column + column);
  }

  override func isEqual(_ location: Location) -> Bool {
    if let location = location as? GridLocation {
      return (row == location.row) && (column == location.column)
    } else {
      return false
    }
  }
}
