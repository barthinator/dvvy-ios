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

class SPShareView: UIView {
    
    let titleLabel: UILabel = UILabel.init()
    let buttonsView = SPShareButtonsView.init()
    let bottomLabel = UILabel.init()
    
    init() {
        super.init(frame: CGRect.zero)
        self.addSubview(self.buttonsView)
        self.titleLabel.font = UIFont.system(type: .Bold, size: 14)
        self.titleLabel.textColor = SPNativeStyleKit.Colors.black
        self.titleLabel.text = "Title"
        self.titleLabel.numberOfLines = 0
        self.titleLabel.setCenteringAlignment()
        self.addSubview(self.titleLabel)
        
        self.bottomLabel.font = UIFont.system(type: .Regular, size: 14)
        self.bottomLabel.textColor = SPNativeStyleKit.Colors.gray
        self.bottomLabel.text = "Bottom text"
        self.bottomLabel.numberOfLines = 0
        self.bottomLabel.setCenteringAlignment()
        self.addSubview(self.bottomLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.frame = CGRect.init(x: 0, y: 0, width: self.frame.width * 0.8, height: 0)
        self.titleLabel.sizeToFit()
        self.titleLabel.setXCenteringFromSuperview()
        
        let widthForButtonsView: CGFloat = min(self.frame.width * 0.8, 300)
        self.buttonsView.frame = CGRect.init(x: 0, y: self.titleLabel.frame.bottomYPosition + 30, width: widthForButtonsView, height: 40)
        self.buttonsView.setXCenteringFromSuperview()
        
        self.bottomLabel.frame = CGRect.init(x: 0, y: self.buttonsView.frame.bottomYPosition + 20, width: self.frame.width * 0.7, height: 0)
        self.bottomLabel.sizeToFit()
        self.bottomLabel.setXCenteringFromSuperview()
    }
    
    override func sizeToFit() {
        super.sizeToFit()
        self.layoutSubviews()
        self.setHeight(self.bottomLabel.frame.bottomYPosition)
    }
}

class SPShareButtonsView: SPAligmentView {
    
    let whatsappButton = SPSocialIconButton.init(type: SPSocialNetwork.whatsapp)
    let telegramButton = SPSocialIconButton.init(type: SPSocialNetwork.telegram)
    let vkButton = SPSocialIconButton.init(type: SPSocialNetwork.vk)
    let facebookButton = SPSocialIconButton.init(type: SPSocialNetwork.facebook)
    let viberButton = SPSocialIconButton.init(type: SPSocialNetwork.viber)
    
    init() {
        super.init(aliment: .horizontal)
        self.addButton(for: .whatsapp)
        self.addButton(for: .viber)
        self.addButton(for: .telegram)
        self.addButton(for: .vk)
        self.addButton(for: .facebook)
        for button in [self.whatsappButton, self.viberButton, self.telegramButton, self.vkButton, self.facebookButton] {
            button.backgroundColor = SPNativeStyleKit.Colors.blue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addButton(for type: SPSocialNetwork) {
        switch type {
        case .facebook:
            self.addSubview(self.facebookButton)
        case .whatsapp:
            self.addSubview(self.whatsappButton)
        case .telegram:
            self.addSubview(self.telegramButton)
        case .viber:
            self.addSubview(self.viberButton)
        case .vk:
            self.addSubview(self.vkButton)
        }
    }
    
    public func removeButton(for type: SPSocialNetwork) {
        switch type {
        case .facebook:
            self.facebookButton.removeFromSuperview()
        case .whatsapp:
            self.whatsappButton.removeFromSuperview()
        case .telegram:
            self.telegramButton.removeFromSuperview()
        case .viber:
            self.viberButton.removeFromSuperview()
        case .vk:
            self.vkButton.removeFromSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for button in [self.whatsappButton, self.telegramButton, self.vkButton, self.facebookButton, self.viberButton] {
            button.setNeedsDisplay()
            
            let currentCenter = button.center
            button.setWidth(button.frame.height)
            button.center = currentCenter
        }
    }
}
