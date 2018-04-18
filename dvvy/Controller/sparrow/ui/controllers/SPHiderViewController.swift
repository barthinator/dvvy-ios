import UIKit

class SPHiderViewController: UIViewController {
    
    let activityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    let backgroundView = SPGradeWithBlurView.init()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var durationAnimation: TimeInterval = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        self.backgroundView.setGradeColor(UIColor.black)
        self.activityIndicatorView.alpha = 0
        self.backgroundView.setGradeAlpha(0, blurRaius: 0)
        self.view.addSubview(self.backgroundView)
        
        self.activityIndicatorView.startAnimating()
        self.view.addSubview(self.activityIndicatorView)
        
        self.updateLayout(with: self.view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    private func updateLayout(with size: CGSize) {
        self.backgroundView.frame = CGRect.init(origin: CGPoint.zero, size: size)
        self.activityIndicatorView.center = CGPoint.init(x: size.width / 2, y: size.height / 2)
    }
    
    func present(on viewController: UIViewController) {
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
        viewController.present(self, animated: false) {
            SPAnimation.animate(self.durationAnimation, animations: {
                self.backgroundView.setGradeAlpha(0.5, blurRaius: 8)
            })
            SPAnimation.animate(self.durationAnimation * 1.5, animations: {
                self.activityIndicatorView.alpha = 1
            }, delay: self.durationAnimation / 1.5)
        }
    }
    
    func dismiss() {
        SPAnimation.animate(self.durationAnimation / 1.2, animations: { 
            self.activityIndicatorView.alpha = 0
        })
        SPAnimation.animate(self.durationAnimation, animations: {
            self.backgroundView.setGradeAlpha(0, blurRaius: 0)
        }, delay: 0) {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
