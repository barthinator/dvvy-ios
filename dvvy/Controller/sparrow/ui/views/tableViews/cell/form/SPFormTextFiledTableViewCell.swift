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

class SPFormTextFiledTableViewCell: UITableViewCell {
    
    let label: UILabel = UILabel()
    let textField = UITextField.init()
    
    var fixWidthLabel: CGFloat? = nil
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.white
        self.label.textAlignment = .right
        self.label.text = "Label"
        self.label.font = UIFont.system(type: .Regular, size: 17)
        self.contentView.addSubview(self.label)
        
        self.textField.font = UIFont.system(type: .Regular, size: 17)
        self.textField.placeholder = "Placeholder"
        self.contentView.addSubview(self.textField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var labelWidth: CGFloat = self.contentView.frame.width * 0.21
        if let width = self.fixWidthLabel {
            labelWidth = width
        }
        self.label.frame = CGRect.init(x: self.layoutMargins.left, y: 0, width: labelWidth, height: self.contentView.frame.height)
        let space: CGFloat = 15
        self.textField.frame = CGRect.init(x: self.label.frame.bottomXPosition + space, y: 0, width: self.contentView.frame.width - self.label.frame.bottomXPosition - self.layoutMargins.right - space, height: self.contentView.frame.height)
    }
}
