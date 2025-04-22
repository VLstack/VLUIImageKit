import UIKit
import SwiftUI

extension UIImage
{
 @available(*, deprecated, renamed: "resized(to:contentMode:fillColor:)", message: "use .resized(to:contentMode:fillColor:) instead")
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

 public func resized(to targetSize: CGSize,
                     contentMode: ContentMode = .fill,
                     fillColor: UIColor? = nil) -> UIImage
 {
  guard targetSize.width > 0,
        targetSize.height > 0,
        targetSize.width < self.size.width || targetSize.height < self.size.height
  else { return self }

  let widthRatio = targetSize.width / self.size.width
  let heightRatio = targetSize.height / self.size.height
  let scaleFactor: CGFloat
  
  switch contentMode
  {
   case .fit:
    scaleFactor = min(widthRatio, heightRatio)
   case .fill:
    scaleFactor = max(widthRatio, heightRatio)
   @unknown default:
    scaleFactor = 1.0
  }
  
  let newSize = CGSize(width: self.size.width * scaleFactor,
                       height: self.size.height * scaleFactor)
  
  let renderer = UIGraphicsImageRenderer(size: targetSize)
  return renderer.image
  {
   context in
   if contentMode == .fit,
      let fillColor
   {
    fillColor.setFill()
    context.fill(CGRect(origin: .zero, size: targetSize))
   }
   
   let origin = CGPoint(x: (targetSize.width - newSize.width) / 2,
                        y: (targetSize.height - newSize.height) / 2)
   self.draw(in: CGRect(origin: origin, size: newSize))
  }
 }

 private func scaledSize(for maxDimension: CGFloat, basedOnWidth: Bool) -> CGSize
 {
  guard self.size.width > 0,
        self.size.height > 0
  else { return .zero }

  let aspectRatio = self.size.width / self.size.height
  guard aspectRatio > 0 else { return .zero }

  if basedOnWidth
  {
   return CGSize(width: maxDimension, height: maxDimension / aspectRatio)
  }

  return CGSize(width: maxDimension * aspectRatio, height: maxDimension)
 }

 public func downsized(height: CGFloat) -> UIImage
 {
  guard self.size.height > 0,
        height < self.size.height
  else { return self }

  return self.resized(to: scaledSize(for: height, basedOnWidth: false))
 }

 public func downsized(width: CGFloat) -> UIImage
 {
  guard self.size.width > 0,
        width < self.size.width
  else { return self }

  return self.resized(to: scaledSize(for: width, basedOnWidth: true))
 }

 public func downsized(max maxDimension: CGFloat) -> UIImage
 {
  guard self.size.height > 0,
        maxDimension < max(self.size.width, self.size.height)
  else { return self }

  let size = scaledSize(for: maxDimension, basedOnWidth: self.size.width > self.size.height)

  return self.resized(to: size)
 }
}
