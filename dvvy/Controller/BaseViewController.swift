
import UIKit


class BaseViewController: UIViewController, SlideMenuDelegate, PopUpDelegate {
    
    let collabModel = CollabModel.init()
    let feedModel = FeedModel.init()
    
    var delegate : PopUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        let topViewController : UIViewController = self.navigationController!.topViewController!
        topViewController.isModalInPopover = true
        topViewController.modalPresentationStyle = .overCurrentContext
        switch(index){
        case 1:

            self.openViewControllerBasedOnIdentifier("Messages")

            break
        case 2:

            self.openViewControllerBasedOnIdentifier("Feed")

        case 3:

            self.openViewControllerBasedOnIdentifier("Collab")

            break
        case 4:

            self.openViewControllerBasedOnIdentifier("Submit")

            break
        case 5:

            self.openViewControllerBasedOnIdentifier("Settings")

            break
        case 6:

            self.openViewControllerBasedOnIdentifier("Profile")

            break
        default:
            1 == 1
        }
    }

    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)

        let topViewController : UIViewController = self.navigationController!.topViewController!

        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            print("Same VC")
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }

    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButtonType.system)
        btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        //self.navigationItem.leftBarButtonItem = customBarItem;

        let btnCreate = UIButton(type: UIButtonType.system)
        btnCreate.setImage(#imageLiteral(resourceName: "dvvyBtnImg"), for: UIControlState())
        btnCreate.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnCreate.addTarget(self, action: #selector(BaseViewController.onCreatePostPress(_:)), for: UIControlEvents.touchUpInside)
        let customBarItemRight = UIBarButtonItem(customView: btnCreate)
        //self.navigationItem.rightBarButtonItem = customBarItemRight;

        self.setToolbarItems([customBarItem, customBarItemRight], animated: false)
    }

    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)

        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()

        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()

        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()

        return defaultMenuImage;
    }

    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);

            sender.tag = 0;

            let viewMenuBack : UIView = view.subviews.last!

            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })

            return
        }

        sender.isEnabled = false
        sender.tag = 10

        let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()


        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }

    @objc func onCreatePostPress(_ sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);

            sender.tag = 0;

            let viewMenuBack : UIView = view.subviews.last!

            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })

            return
        }

        sender.isEnabled = false
        sender.tag = 10

        let popVC : PopUpViewController = self.storyboard!.instantiateViewController(withIdentifier: "PostPopUp") as! PopUpViewController
        popVC.collabModel = collabModel
        popVC.btnCreate = sender
        popVC.delegate = self
        self.view.addSubview(popVC.view)
        self.addChildViewController(popVC)
        popVC.view.layoutIfNeeded()


        popVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            popVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }
}
