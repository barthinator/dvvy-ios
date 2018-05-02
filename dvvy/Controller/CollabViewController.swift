//
//  CollabViewController.swift
//  dvvy
//
//  Created by David B on 2/6/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//
import UIKit
protocol SwipeCollabDelegate {
    func loadData(collab: CollabModel)
}
class CollabViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, CollabModelDelegate, SwipeableCardViewDataSource {

    
    var allImages = [String: UIImage]()

    var allPosts: [CollabPost] = []
    var cardPosts: [SampleSwipeableCellViewModel] = []
    
    @IBOutlet weak var sortViewBtn: UIButton!
    @IBAction func sortViewBtn(_ sender: Any) {
        collabTableView.isHidden = !collabTableView.isHidden
        super.collabModel.getCollabUpdates()
        swipeableCardView.isHidden = !swipeableCardView.isHidden
    }
    //collab listings view
    @IBOutlet weak var collabTableView: UITableView!
    //cards view
    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!
    
    let cellSpacingHeight: CGFloat = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        //cards
        swipeableCardView.dataSource = self
        swipeableCardView.isHidden = true
        //
        
        //sort button styling
        sortViewBtn.layer.borderWidth = 1
        sortViewBtn.layer.cornerRadius = 5
        sortViewBtn.layer.borderColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0).cgColor
        //
        
        super.collabModel.delegate = self
        super.collabModel.getCollabUpdates()
        collabTableView.delegate = self
        collabTableView.dataSource = self
        collabTableView.register(UINib(nibName: "customListingCell", bundle: nil), forCellReuseIdentifier: "cusListCell")
        self.collabTableView.addSubview(self.refreshControl)
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor(red:1.00, green:0.46, blue:0.37, alpha:1.0)
        
        return refreshControl
    }()
    
    //Used for when refreshed is called, need to query the data here too
    @objc func refreshTable(_ refreshControl: UIRefreshControl){
        collabModel.getCollabUpdates()
        self.collabTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func finishedLoading(_ posts: [CollabPost]?) {
        
        //Grabs the data passed in from the model class and then puts it in the allPosts array
        allPosts = posts!
        
        //Reloads the data after it is all fetched
        self.collabTableView.reloadData()
        
        //Give data to the cards view
        cardPosts = convertPostsToCardData(posts: posts!)
        
        swipeableCardView.reloadData()
    }
    func finishedLoadingImages(_ userImages: [String : UIImage]) {
        self.allImages = userImages
        
        self.collabTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //sections test
    func numberOfSections(in tableView: UITableView) -> Int {
        return allPosts.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cusListCell", for: indexPath) as! customListingCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        //cell.layer.cornerRadius = 60
        cell.lblNameListing.text = allPosts[indexPath.section].name.uppercased()
        cell.imageListing.image = allImages[allPosts[indexPath.section].uid] ?? #imageLiteral(resourceName: "dvvyBtnImg")
        cell.lblNeedTypeCollab.text = allPosts[indexPath.section].category.lowercased()
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configureTableView(){
        collabTableView.rowHeight = UITableViewAutomaticDimension
        collabTableView.estimatedRowHeight = 120.0
    }
    
    func setCollabPosition(index: Int){
        var tempPosts = cardPosts
        
        cardPosts = rearrange(array: cardPosts, fromIndex: index, toIndex: 0)
        swipeableCardView.reloadData()
        
        collabTableView.isHidden = !collabTableView.isHidden
        swipeableCardView.isHidden = !swipeableCardView.isHidden
        
        cardPosts = tempPosts
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = collabTableView.cellForRow(at: indexPath)  as! customListingCell
        let index = indexPath.section
        setCollabPosition(index: index)

    }
    
    func rearrange<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T>{
        var arr = array
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        
        return arr
    }
    
    func convertPostsToCardData(posts: [CollabPost]) -> [SampleSwipeableCellViewModel]{
        var cardPosts : [SampleSwipeableCellViewModel] = []
        for post in posts{
            let cardPost = SampleSwipeableCellViewModel(title: post.name, color: UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0), image: post.userImage, description: post.description, category: post.category)
            cardPosts.append(cardPost)
        }
        return cardPosts
    }
}

extension CollabViewController {
    
    func numberOfCards() -> Int {
        return viewModels.count
    }
    
    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        let viewModel = viewModels[index]
        let cardView = SampleSwipeableCard()
        cardView.viewModel = viewModel
        return cardView
    }
    
    func viewForEmptyCards() -> UIView? {
        return nil
    }
    
}

extension CollabViewController {
    
    var viewModels: [SampleSwipeableCellViewModel] {
        return cardPosts
    }
    
}
