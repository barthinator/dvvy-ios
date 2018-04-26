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

struct SPAppStore {
    
    static func open(appId: String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)"),
            UIApplication.shared.canOpenURL(url) {
            print(url)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static func icon(appId: String, complection: @escaping(String?) -> Void) {
        let url = URL(string: "https://itunes.apple.com/by/app/id\(appId)")!
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if data == nil {  complection(nil) }
            else {
                let string = String(data: data!, encoding: .utf8)
                if string == nil { complection(nil) }
                else {
                    let pattern = "<meta itemprop=\"image\" content=\"(.*?)\">"
                    let regex = try? NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators)
                    if regex == nil { complection(nil) }
                    else {
                        let matches = regex!.matches(in: string!, options: [], range: NSRange.init(location: 0, length: string!.utf16.count))
                        print(matches)
                        if let match = matches.first {
                            let range = match.range(at: 1)
                            
                            if let swiftRange = range.range(for: string!) {
                                let name = string!.substring(with: swiftRange)
                                complection(name)
                            } else { complection(nil) }
                            
                        } else { complection(nil) }
                    }
                }
            }
            }.resume()
    }
}

extension NSRange {
    func range(for str: String) -> Range<String.Index>? {
        guard location != NSNotFound else { return nil }
        
        guard let fromUTFIndex = str.utf16.index(str.utf16.startIndex, offsetBy: location, limitedBy: str.utf16.endIndex) else { return nil }
        guard let toUTFIndex = str.utf16.index(fromUTFIndex, offsetBy: length, limitedBy: str.utf16.endIndex) else { return nil }
        guard let fromIndex = String.Index(fromUTFIndex, within: str) else { return nil }
        guard let toIndex = String.Index(toUTFIndex, within: str) else { return nil }
        
        return fromIndex ..< toIndex
    }
}
