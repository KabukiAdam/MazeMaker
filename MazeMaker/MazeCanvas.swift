import Foundation
import UIKit

class MazeCanvas: UIView {
  let generator: GeometryGenerator

  init(geometry: GeometryGenerator) {
    self.generator = geometry
    super.init(frame: generator.bounds)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("decoder init must be defined")
  }

  override func draw(_ rect: CGRect) {
    let ctx = UIGraphicsGetCurrentContext()!
    generator.render(ctx)
  }
}
