class PolarLocation: Location {
  let ring: Int
  let spoke: Int

  override var hashValue: Int {
    return ring * 1000 + spoke
  }

  init(ring: Int, spoke: Int) {
    self.ring = ring
    self.spoke = spoke
  }

  func change(ringBy ring: Int = 0, spokeBy spoke: Int = 0) -> PolarLocation {
    return PolarLocation(ring: self.ring + ring, spoke: self.spoke + spoke);
  }

  override func isEqual(_ location: Location) -> Bool {
    if let location = location as? PolarLocation {
      return (ring == location.ring) && (spoke == location.spoke)
    } else {
      return false
    }
  }
}
