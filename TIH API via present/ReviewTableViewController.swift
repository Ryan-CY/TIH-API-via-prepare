//
//  ReviewTableViewController.swift
//  TIH API via prepare
//
//  Created by Ryan Lin on 2023/3/23.
//

import UIKit

class ReviewTableViewController: UITableViewController {
    
    var reviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        tableView.allowsSelection = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviews.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ReviewTableViewCell.self)", for: indexPath) as! ReviewTableViewCell
        
        // Configure the cell...
        let review = reviews[indexPath.row]
        cell.authorNameLabel.text = review.authorName
        cell.authorNameLabel.frame = CGRect(x: 10, y: 30, width: 150, height: 25)
        cell.authorNameLabel.adjustsFontSizeToFitWidth = true
        
        cell.ratingLabel.text = review.rating.description
        cell.ratingLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        
        cell.textTextView.text = review.text
        cell.textTextView.backgroundColor = .systemGray6
        cell.textTextView.textColor = .black
        cell.textTextView.layer.cornerRadius = 10
        
        //顯示時間
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMMM d, yyyy"
        cell.timeLabel.text = newFormatter.string(from: review.time)
        cell.timeLabel.frame = CGRect(x: 30, y: 120, width: 130, height: 25)
        cell.timeLabel.font = .systemFont(ofSize: 13, weight: .regular)
        cell.timeLabel.textAlignment = .right
        
        for star in cell.starImageViews {
            star.image = UIImage(systemName: "")
        }
        
        for star in cell.starImageViews {
            star.image = UIImage(systemName: "star")
            star.tintColor = .systemGray5
        }
        
        let rating = review.rating
        let intStarRating = Int(rating)
        let starRagne = intStarRating-1
        
        for star in 0...starRagne {
            cell.starImageViews[star].tintColor = .systemYellow
            cell.starImageViews[star].image = UIImage(systemName: "star.fill")
            
            if rating - Double(intStarRating) > 0 {
                cell.starImageViews[intStarRating].tintColor = .systemYellow
                cell.starImageViews[intStarRating].image = UIImage(systemName: "star.leadinghalf.filled")
            }
        }
        return cell
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
