//
//  ListingViewController.swift
//  Poppy
//
//  Created by Avi Patel on 4/3/22.
//

import UIKit
import Firebase
import AlamofireImage


class ListingViewController: UITableViewController {
    var listings:[[String:Any]] = [[String:Any]]()
    @IBAction func Logout(_ sender: Any) {
        do {
            try Firebase.Auth.auth().signOut()
        } catch {
            print("No user signed in")
        }
        let main = UIStoryboard(name: "Main", bundle: nil)
        let LoginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.listings.removeAll()
        
        let listingRef = Firestore.firestore().collection("listing")
        
        listingRef.limit(to: 20).getDocuments{QuerySnapshot, error in
            if let err = error {
                print("error retrieving listings")
                return
            }
            for document in QuerySnapshot!.documents {
                let filler = UserDefaults.standard.integer(forKey: "Filter")
                
                if(filler == 0){
                    self.listings.append(document.data())
                } else if (filler == 1){
                    if (document.data()["PriorUse"] as! String == "New") {
                        self.listings.append(document.data())
                    }
                } else {
                    if (document.data()["PriorUse"] as! String == "Used") {
                        self.listings.append(document.data())
                    }
                }
            }
            self.tableView.reloadData()
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return self.listings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell
        let listing = self.listings[indexPath.row]
        
        let user_id = listing["user_id"] as? String ?? ""
        let userRef = Firestore.firestore().collection("users").document(user_id)
        var condition2 = ""
                
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                print("Document data: \(dataDescription)")
                cell.titleLabel.text = listing["listingTitle"] as? String ?? ""
                cell.descriptionLabel.text = listing["descrip"] as? String ?? ""
                cell.priceLabel.text = "$\(listing["price"]!)"
                
                
                let username = dataDescription?["name"] as? String ?? ""
                cell.sender_label.text = "Posted by \(username)"
                let PriorUse = listing["PriorUse"] as? String ?? ""
                let age = "\(listing["age"]!) Years Old"
                let itemsSold = "\((dataDescription?["itemsSold"])!) Items Sold"
                let condition = listing["condition"] as? String ?? ""
//                print(PriorUse)
//                condition2 = PriorUse
//                print(condition2)
                cell.detailsLabel.text = "\(PriorUse) \u{2022} \(age) \u{2022} \(itemsSold) \u{2022} \(condition)"
                guard let url = URL(string: "\(listing["image"] as? String ?? "")") else {
                    print("can't get image url")
                    cell.productImage.image = UIImage(named: "image_placeholder")!
                    return
                }
                
                cell.productImage.af.setImage(withURL: url)
                
            } else {
                print("Document does not exist")
            }
        }

        // Configure the cell...
        
        //if(filler == 3){
        return cell
        //}
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let cell = sender as? UITableViewCell {
            let indexPath = tableView.indexPath(for: cell)!
            let listing = listings[indexPath.row]
            let itemViewerViewController = segue.destination as! ItemViewerViewController
            itemViewerViewController.listing = listing
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    

}
