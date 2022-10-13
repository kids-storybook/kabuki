import Foundation
import SpriteKit

extension SKReferenceNode {
    func getBasedChildNode () -> SKNode? {
        if let child = self.children.first?.children.first {return child}
        else {return nil}
    }
}
