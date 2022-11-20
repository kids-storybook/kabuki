import Foundation
import SpriteKit

extension SKLabelNode {

    func addStroke(color: UIColor, width: CGFloat) {

        guard let labelText = self.text else { return }

        let font = UIFont(name: self.fontName!, size: self.fontSize)

        let attributedString: NSMutableAttributedString
        if let labelAttributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .strokeColor: color,
            .strokeWidth: -width,
            .font: font!,
            .foregroundColor: self.fontColor!]
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }

    func textFadeInOut(start: TimeInterval) {
        let fadeStartTime = SKAction.wait(forDuration: start)
        let fadeIn = SKAction.fadeIn(withDuration: 1.5)
        let bridgeTime = SKAction.wait(forDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 1.5)
        let sequence = SKAction.sequence([fadeStartTime, fadeIn, bridgeTime, fadeOut])
        self.run(sequence)
    }
}
