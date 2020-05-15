class OrthogonalLayout: Layout {
  let rows: Int
  let columns: Int
  let wrapRows: Bool
  let wrapColumns: Bool

  init(rows: Int, columns: Int, wrapRows: Bool = false, wrapColumns: Bool = false) {
    self.rows = rows
    self.columns = columns
    self.wrapRows = wrapRows
    self.wrapColumns = wrapColumns
  }

  func build(_ grid: Grid) {
    for row in 0..<rows {
      for column in 0..<columns {
        let location = GridLocation(row: row, column: column)
        let cell = OrthogonalCell(location: location)
        let _ = grid.add(cell)

        let north = GridLocation(row: row-1, column: column)
        if let north = grid.at(north) as? OrthogonalCell {
          cell.north = north
          north.south = cell
        }

        let west = GridLocation(row: row, column: column-1)
        if let west = grid.at(west) as? OrthogonalCell {
          cell.west = west
          west.east = cell
        }

        if wrapColumns && column+1 == columns {
          let startCol = GridLocation(row: row, column: 0)
          let startCell = grid.at(startCol) as! OrthogonalCell
          cell.east = startCell
          startCell.west = cell
        }

        if wrapRows && row+1 == rows {
          let startRow = GridLocation(row: 0, column: column)
          let startCell = grid.at(startRow) as! OrthogonalCell
          cell.south = startCell
          startCell.north = cell
        }
      }
    }
  }

  func renderAsString(_ grid: Grid) -> String {
    var string = ""

    for _ in 0..<columns {
      string += "+---"
    }
    string += "+\n"

    for row in 0..<rows {
      var bottom = "+"

      for column in 0..<columns {
        let loc = GridLocation(row: row, column: column)
        let cell = grid.at(loc) as! OrthogonalCell

        if column == 0 {
          string += (cell.isLinkedWith(cell.west) ? " " : "|")
        }

        string += "   "
        string += cell.isLinkedWith(cell.east) ? " " : "|"

        bottom += cell.isLinkedWith(cell.south) ? "   " : "---"
        bottom += "+"
      }

      string += "\n" + bottom + "\n"
    }

    return string
  }
}
