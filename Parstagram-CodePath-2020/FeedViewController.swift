//
//  FeedViewController.swift
//  Parstagram-CodePath-2020
//
//  Created by Alan Cao on 7/10/20.
//  Copyright © 2020 Alan Cao. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            self.posts = posts!
            self.tableView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row] 
        cell.usernameLabel.text = post["author"] as? String ?? ""
        cell.captionLabel.text = post["caption"] as? String ?? ""
        
        let imageFile = post["image"] as! PFFileObject
        let URLString = imageFile.url!
        let url = URL(string: URLString)
        
        cell.postImageView.af_setImage(withURL: url!)
        
        return cell
    }
}
