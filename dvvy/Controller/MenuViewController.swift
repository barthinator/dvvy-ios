//
//  MenuViewController.swift
//  dvvy
//
//  Created by David B on 2/4/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import UIKit

//This delegate is responsible for calling the slide function passed through a seperate view controller
protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UserModelDelegate {
    
    func finishLoadingFollowers(followers: [String]) {
        
    }
    


    /**
     *  Array to display menu options
     */
    @IBOutlet var tblMenuOptions : UITableView!

    /**
     *  Transparent button to hide menu
     */
    @IBOutlet var btnCloseMenuOverlay : UIButton!

    /**
     *  Array containing menu options
     */
    var arrayMenuOptions = [Dictionary<String,String>]()

    /**
     *  Menu button which was tapped to display the menu
     */
    var btnMenu : UIButton!

    /**
     *  Delegate of the MenuVC
     */
    var delegate : SlideMenuDelegate?

    var userInfo = User(first: "not", last: "correct")
    let userModel = UserModel.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        userModel.delegate = self
        userModel.getUser(uid: UserDefaults.standard.value(forKey: "currentUser") as! String)

        tblMenuOptions.tableFooterView = UIView()
        tblMenuOptions.backgroundColor = UIColor(red:0.22, green:0.22, blue:0.22, alpha:1.0)
        tblMenuOptions.tintColor = UIColor.white
        btnCloseMenuOverlay.alpha = 1
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        // Do any additional setup after loading the view.
        tblMenuOptions.rowHeight = UITableViewAutomaticDimension
        tblMenuOptions.estimatedRowHeight = 140
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }

    func updateArrayMenuOptions(){
        //Pass in icon with ["title":"Name", "icon":"Name"]
        arrayMenuOptions.append(["head": UserDefaults.standard.value(forKey: "currentUser") as! String])
        arrayMenuOptions.append(["title":"Messages"])
        arrayMenuOptions.append(["title":"Feed"])
        arrayMenuOptions.append(["title":"Collab"])
        arrayMenuOptions.append(["title":"Submit"])
        arrayMenuOptions.append(["title":"Settings"])
        arrayMenuOptions.append(["title":"Profile"])
        print(arrayMenuOptions)

        tblMenuOptions.reloadData()
    }

    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0

        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!

        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear

        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        //let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView

        //To enable icons
        //imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)

        if (indexPath.row == 0){
            let headCell = tableView.dequeueReusableCell(withIdentifier: "head") as! SideUserCell
            headCell.backgroundColor = UIColor.clear
            headCell.userLbl.text = userInfo.first + " " + userInfo.last
            headCell.userLbl.textColor = UIColor.white
            return headCell
        }
        else{
            lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func finishedLoading(user: User) {
        userInfo = user
        self.tblMenuOptions.reloadData()
    }
}
