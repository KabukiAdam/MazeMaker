class Location: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(0)
  }
  func isEqual(_ location: Location) -> Bool {
    return hashValue == location.hashValue
  }
}

func ==(lhs: Location, rhs: Location) -> Bool {
  return lhs.isEqual(rhs)
}
