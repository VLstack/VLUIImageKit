import UIKit

extension UIImage
{
 public func resized(in size: CGSize) -> UIImage
 {
  guard size.width > 0 && size.height > 0 else { return self }
  guard size.width < self.size.width || size.height < self.size.height else { return self }

  let aspectRatio = self.size.width / self.size.height
  guard aspectRatio != 0 else { return self }

  var newSize = size
  if aspectRatio > 1
  {
   newSize.height = size.width / aspectRatio
  }
  else if aspectRatio < 1
  {
   newSize.width = size.height * aspectRatio
  }

  UIGraphicsBeginImageContextWithOptions(newSize, true, 0.0)
  self.draw(in: CGRect(origin: .zero, size: newSize))
  let resized = UIGraphicsGetImageFromCurrentImageContext()
  UIGraphicsEndImageContext()

  return resized ?? self
 }

 public func downsized(height: CGFloat) -> UIImage
 {
  guard self.size.height > 0,
        height < self.size.height
  else { return self }

  let aspectRatio = self.size.width / self.size.height
  let size = CGSize(width: height * aspectRatio, height: height)

  return self.resized(in: size)
 }

 public func downsized(width: CGFloat) -> UIImage
 {
  guard self.size.width > 0,
        width < self.size.width
  else { return self }

  let aspectRatio = self.size.height / self.size.width
  let size = CGSize(width: width, height: width * aspectRatio)

  return self.resized(in: size)
 }

 public func downsized(max maxDimension: CGFloat) -> UIImage
 {
  guard self.size.height > 0,
        maxDimension < max(self.size.width, self.size.height)
  else { return self }

  let aspectRatio = self.size.width / self.size.height
  guard aspectRatio > 0 else { return self }

  let size: CGSize
  if self.size.width > self.size.height
  {
   size = CGSize(width: maxDimension, height: maxDimension / aspectRatio)
  }
  else
  {
   size = CGSize(width: maxDimension * aspectRatio, height: maxDimension)
  }

  return self.resized(in: size)
 }
}
