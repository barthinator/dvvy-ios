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

struct SPTelegram {
    
    static func share(text: String) {
        let urlStringEncoded = text.addingPercentEncoding( withAllowedCharacters: .urlHostAllowed)
        let url  = NSURL(string: "tg://msg?text=\(urlStringEncoded!)")
        let tgURL:NSURL? = url
        if UIApplication.shared.canOpenURL(URL(string: "tg://msg?text=test")!) {
            UIApplication.shared.openURL(tgURL! as URL )
        }
    }
    
    static func isSetApp() -> Bool {
        if UIApplication.shared.canOpenURL(URL(string: "tg://msg?text=test")!) {
            return true
        } else {
            return false
        }
    }
    
    static func joinChannel(id: String) {
        let url = "https://t.me/joinchat/\(id)"
        SPOpener.Link.redirectToBrowserAndOpen(link: url)
    }
    
}

