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

@available(iOS 9.0, *)
class SPTextAndImageDinamicHeightTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let iconImageView = SPDownloadingImageView.init()
    let button = UIButton.init(type: UIButtonType.system)
    
    var isShowSeparator: Bool = true {
        didSet {
            layoutSubviews()
        }
    }
    
    private var baseSpace: CGFloat = 15
    private let spaceTopAndBottom: CGFloat = 15 / 1.3
    private let spaceBetweenImageAndTitles: CGFloat = 15
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.white
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(self.iconImageView)
        self.iconImageView.contentMode = .scaleAspectFill
        self.iconImageView.setNativeStyle()
        self.iconImageView.layer.cornerRadius = 12
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.iconImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        self.iconImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: self.spaceTopAndBottom).isActive = true
        self.iconImageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        self.iconImageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        self.iconImageView.bottomAnchor.constraint(lessThanOrEqualTo: marginGuide.bottomAnchor, constant: -(spaceTopAndBottom)).isActive = true
        
        contentView.addSubview(self.titleLabel)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.system(type: .DemiBold, size: 16)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: spaceBetweenImageAndTitles).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: self.spaceTopAndBottom).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        contentView.addSubview(self.subtitleLabel)
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.font = UIFont.system(type: .Regular, size: 13)
        self.subtitleLabel.textColor = UIColor.lightGray
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.subtitleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        self.subtitleLabel.topAnchor.constraint(equalTo:  titleLabel.bottomAnchor, constant: self.baseSpace / 3).isActive = true
        
        self.contentView.addSubview(self.button)
        self.button.setTitle("Action", for: .normal)
        self.button.titleLabel?.font = UIFont.system(type: .DemiBold, size: 14)
        self.button.titleLabel?.numberOfLines = 0
        self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        self.button.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        self.button.topAnchor.constraint(equalTo:  subtitleLabel.bottomAnchor, constant: self.baseSpace / 2).isActive = true
        self.button.bottomAnchor.constraint(lessThanOrEqualTo: marginGuide.bottomAnchor, constant: -(self.spaceTopAndBottom - 7)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImageView.setLoadingMode()
        self.isShowSeparator = true
        self.titleLabel.text = ""
        self.subtitleLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.isShowSeparator {
             self.separatorInset.left = self.iconImageView.frame.bottomXPosition + self.spaceBetweenImageAndTitles
        } else {
             self.separatorInset.left = self.frame.width
        }
    }
}
