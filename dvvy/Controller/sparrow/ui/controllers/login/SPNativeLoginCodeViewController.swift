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
class SPNativeLoginCodeViewController: UITableViewController {
    
    weak var delegate: SPLoginCodeControllerDelegate?
    var content: SPNativeLoginNavigationController.LoginCodeContent!
    
    private let textFieldTableViewCellIdentifier: String = "textFieldTableViewCellIdentifier"
    private let buttonTableViewCellIdentifier: String = "buttonTableViewCellIdentifier"
    private let bottomTextTableViewCellIdentificator: String = "bottomTextTableViewCellIdentificator"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self.navigationController as! SPNativeLoginNavigationController
        self.content = self.delegate?.loginCodeContent
        self.view.backgroundColor = SPNativeStyleKit.Colors.customGray
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
        }
        
        self.navigationItem.title = self.content.navigationTitle
        
        self.tableView.backgroundColor = SPNativeStyleKit.Colors.customGray
        self.tableView.delaysContentTouches = false
        self.tableView.allowsSelection = false
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView.init()
        
        self.tableView.register(SPFormTextFiledTableViewCell.self, forCellReuseIdentifier: self.textFieldTableViewCellIdentifier)
        self.tableView.register(SPFormButtonTableViewCell.self, forCellReuseIdentifier: self.buttonTableViewCellIdentifier)
        self.tableView.register(SPFormBottomTextTableViewCell.self, forCellReuseIdentifier: self.bottomTextTableViewCellIdentificator)
        
        self.dismissKeyboardWhenTappedAround()
        
        self.updateLayout(with: self.view.frame.size)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? SPFormTextFiledTableViewCell  {
            cell.textField.becomeFirstResponder()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (contex) in
            self.updateLayout(with: size)
        }, completion: nil)
    }
    
    private func updateLayout(with size: CGSize) {}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: self.textFieldTableViewCellIdentifier, for: indexPath as IndexPath)
        
        var labelWidth: CGFloat = 0
        for text in [self.content.buttonTitle] {
            let font = UIFont.system(type: .Regular, size: 17)
            let fontAttributes = [NSAttributedStringKey.font: font]
            let calculatedSize = NSString.init(string: text).size(withAttributes: fontAttributes)
            labelWidth.setIfFewer(when: calculatedSize.width + 1)
        }
        
        switch indexPath {
        case IndexPath.init(row: 0, section: 0):
            if let codeCell = cell as? SPFormTextFiledTableViewCell {
                codeCell.label.text = self.content.codeTitle
                codeCell.textField.placeholder = self.content.codePlaceholder
                codeCell.textField.keyboardType = self.content.codeKeyboardType
                codeCell.textField.delegate = self
                codeCell.textField.returnKeyType = .next
                codeCell.textField.autocapitalizationType = .none
                codeCell.textField.autocorrectionType = .no
                codeCell.textField.isSecureTextEntry = true
                codeCell.fixWidthLabel = labelWidth
            }
            break
        case IndexPath.init(row: 1, section: 0):
            cell = tableView.dequeueReusableCell(withIdentifier: self.bottomTextTableViewCellIdentificator, for: indexPath as IndexPath)
            if let bottomTextCell = cell as? SPFormBottomTextTableViewCell {
                bottomTextCell.label.text = self.content.commentTitle
            }
        case IndexPath.init(row: 0, section: 1):
            cell = tableView.dequeueReusableCell(withIdentifier: self.buttonTableViewCellIdentifier, for: indexPath as IndexPath)
            if let enterButtonCell = cell as? SPFormButtonTableViewCell {
                enterButtonCell.button.setTitle(self.content.buttonTitle, for: .normal)
                enterButtonCell.separatorInset.left = 0
                enterButtonCell.button.addTarget(self, action: #selector(self.enterAction), for: .touchUpInside)
            }
            break
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    @objc func enterAction() {
        var сodeCell: SPFormTextFiledTableViewCell? = nil
        var buttonCell: SPFormButtonTableViewCell? = nil
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? SPFormTextFiledTableViewCell  {
            сodeCell = cell
        }
        
        if сodeCell?.textField.isEmptyText ?? false {
            сodeCell?.highlighted()
            return
        }
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as? SPFormButtonTableViewCell  {
            buttonCell = cell
        }
        
        buttonCell?.button.setLoadingMode()
        
        сodeCell?.textField.isEnabled = false
        
        self.delegate?.login(with: сodeCell?.textField.text ?? "") { (oAuthState) in
            
            buttonCell?.button.unsetLoadingMode()
            
            if oAuthState != SPOauthState.succsess {
                UIAlertController.show(
                    title: self.content.errorOauthTitle,
                    message: self.content.errorOauthSubtitle,
                    buttonTitle: self.content.errorOauthButtonTitle,
                    on: self
                )
                сodeCell?.textField.isEnabled = true
                сodeCell?.textField.becomeFirstResponder()
            }
        }
    }
}

@available(iOS 9.0, *)
extension SPNativeLoginCodeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.superview == self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0))?.contentView {
            if let passwordCell = self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as? SPFormTextFiledTableViewCell  {
                passwordCell.textField.becomeFirstResponder()
                return false
            }
        }
        
        if textField.superview == self.tableView.cellForRow(at: IndexPath.init(row: 1, section: 0))?.contentView  {
            textField.resignFirstResponder()
            self.enterAction()
            return true
        }
        
        return true
    }
}

@available(iOS 9.0, *)
protocol SPLoginCodeControllerDelegate: class {
    
    var loginCodeContent: SPNativeLoginNavigationController.LoginCodeContent {get}
    
    func login(with code: String, complection: @escaping (SPOauthState)->())
}


