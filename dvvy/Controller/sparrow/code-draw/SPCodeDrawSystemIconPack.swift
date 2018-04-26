// The MIT License (MIT)
// Copyright © 2017 Ivan Vorobei (hello@ivanvorobei.by)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

extension SPCodeDraw {
    
    public class SystemIconPack : NSObject {
        
        //// Cache
        
        private struct Cache {
            static let gradient: CGGradient = CGGradient(colorsSpace: nil, colors: [UIColor.red.cgColor, UIColor.red.cgColor] as CFArray, locations: [0, 1])!
        }
        
        //// Gradients
        
        @objc dynamic public class var gradient: CGGradient { return Cache.gradient }
        
        //// Drawing Methods
        
        @objc dynamic public class func drawShare(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100), resizing: ResizingBehavior = .aspectFit, color: UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)) {
            //// General Declarations
            let context = UIGraphicsGetCurrentContext()!
            
            //// Resize to Target Frame
            context.saveGState()
            let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 100, height: 100), target: targetFrame)
            context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
            context.scaleBy(x: resizedFrame.width / 100, y: resizedFrame.height / 100)
            
            
            //// Clip 2 Drawing
            let clip2Path = UIBezierPath()
            clip2Path.move(to: CGPoint(x: 38.59, y: 33.54))
            clip2Path.addLine(to: CGPoint(x: 38.59, y: 38.16))
            clip2Path.addLine(to: CGPoint(x: 24.9, y: 38.16))
            clip2Path.addLine(to: CGPoint(x: 24.9, y: 90.08))
            clip2Path.addLine(to: CGPoint(x: 75.1, y: 90.08))
            clip2Path.addLine(to: CGPoint(x: 75.1, y: 38.16))
            clip2Path.addLine(to: CGPoint(x: 61.41, y: 38.16))
            clip2Path.addLine(to: CGPoint(x: 61.41, y: 33.54))
            clip2Path.addLine(to: CGPoint(x: 80, y: 33.54))
            clip2Path.addLine(to: CGPoint(x: 80, y: 95))
            clip2Path.addLine(to: CGPoint(x: 20, y: 95))
            clip2Path.addLine(to: CGPoint(x: 20, y: 33.54))
            clip2Path.addLine(to: CGPoint(x: 38.59, y: 33.54))
            clip2Path.close()
            clip2Path.move(to: CGPoint(x: 52.27, y: 61.81))
            clip2Path.addLine(to: CGPoint(x: 47.73, y: 61.81))
            clip2Path.addLine(to: CGPoint(x: 47.73, y: 14.88))
            clip2Path.addLine(to: CGPoint(x: 40.08, y: 22.75))
            clip2Path.addLine(to: CGPoint(x: 37.14, y: 19.73))
            clip2Path.addLine(to: CGPoint(x: 50, y: 6.5))
            clip2Path.addLine(to: CGPoint(x: 62.86, y: 19.73))
            clip2Path.addLine(to: CGPoint(x: 59.92, y: 22.75))
            clip2Path.addLine(to: CGPoint(x: 52.27, y: 14.88))
            clip2Path.addLine(to: CGPoint(x: 52.27, y: 61.81))
            clip2Path.close()
            color.setFill()
            clip2Path.fill()
            
            context.restoreGState()
            
        }
        
        
        
        
        @objc(StyleKitNameResizingBehavior)
        public enum ResizingBehavior: Int {
            case aspectFit /// The content is proportionally resized to fit into the target rectangle.
            case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
            case stretch /// The content is stretched to match the entire target rectangle.
            case center /// The content is centered in the target rectangle, but it is NOT resized.
            
            public func apply(rect: CGRect, target: CGRect) -> CGRect {
                if rect == target || target == CGRect.zero {
                    return rect
                }
                
                var scales = CGSize.zero
                scales.width = abs(target.width / rect.width)
                scales.height = abs(target.height / rect.height)
                
                switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
                }
                
                var result = rect.standardized
                result.size.width *= scales.width
                result.size.height *= scales.height
                result.origin.x = target.minX + (target.width - result.width) / 2
                result.origin.y = target.minY + (target.height - result.height) / 2
                return result
            }
        }
    }
}
