//
//  Collab
//  dvvy
//
//  Created by Nathan Frasier on 3/15/18.
//  Copyright © 2018 David Bartholomew. All rights reserved.
//

import Firebase
import FirebaseStorage

struct CollabPost {
    var uid: String
    var description: String
    var title: String
    //var profImage: UIImage
    var datePosted: Date
    var category: String
    var userImage: UIImage
    var name: String
}

protocol CollabModelDelegate: class {
    func finishedLoading(_ posts: [CollabPost]?)
    func finishedLoadingImages(_ userImages: [String: UIImage])
}

class CollabModel {
    var db: Firestore!
    weak var delegate: CollabModelDelegate?
    var posts = [CollabPost]()
    
    let storage = Storage.storage()
    var postAssociatedImage: UIImage = #imageLiteral(resourceName: "dvvyBtnImg")
    var userImages = [String: UIImage]()
    
    init() {
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    // Going to pull from the current user who is logged in
    //Should only pull the most recent 10 or something
    func getCollabUpdates() {
        //Suppose to grab the posts from the world document, then order them by
        //the date posted (only limit to 10 for now)
        
        db.collection("collab").document("global").collection("collabpost").order(by: "datePosted", descending: true).getDocuments(){
            (querySnapshot, err) in
            if let err = err {
                print("Error geting posts: \(err)")
            } else {
                //Clears it out. Maybe its more efficient to check if there is anything new? need to research more
                self.posts = [CollabPost]()
                
                for document in querySnapshot!.documents {
                    
                    var dataDict = document.data()
                    
                    let storageRef = self.storage.reference()
                    
                    // Create a reference to the file you want to download
                    let imgProfRef = storageRef.child("userphotos/\(dataDict["uid"] as! String).jpg")
                    
                    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                    imgProfRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            // Uh-oh, an error occurred!
                            print(error)
                        } else {
                            // Data for "userphotos/uid" is returned
                            self.userImages[dataDict["uid"] as! String] = UIImage(data: data!)!
                            
                            if document == querySnapshot?.documents.last{
                                self.delegate?.finishedLoadingImages(self.userImages)
                            }
                        }
                    }
                    
                    let documentPost = CollabPost(
                        uid: dataDict["uid"] as! String,
                        description: dataDict["description"] as! String,
                        title: dataDict["title"] as! String,
                        datePosted: dataDict["datePosted"] as! Date,
                        category: dataDict["category"] as! String,
                        userImage: self.userImages[dataDict["uid"] as! String] ?? #imageLiteral(resourceName: "dvvyBtnImg"),
                        name: dataDict["name"] as! String
                    )
                    
                    self.posts.append(documentPost)
                }
                self.delegate?.finishedLoading(self.posts)
            }
        }
    }
    
    func makePost(post: CollabPost){
        //Sets the data of the global collab collection
        let ref = db.collection("collab").document("global").collection("collabpost").document()
        ref.setData([
            "uid": post.uid,
            "description": post.description,
            "title": post.title,
            "datePosted": post.datePosted,
            "category": post.category,
            "name": post.name
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    
    
}


