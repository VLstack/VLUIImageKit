import UIKit

extension UIImage
{
 /**
  A UIImage instance with corrected orientation.
  If the instance's orientation is already `.up`, it simply returns the original.
  - Returns: An optional UIImage that represents the correctly oriented image.
 */
 public var orientedUp: UIImage?
 {
  if imageOrientation == .up { return self }

  UIGraphicsBeginImageContextWithOptions(size, false, scale)
  draw(in: CGRect(origin: .zero, size: size))
  let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()

  return normalizedImage
 }
}

