//
//  IntroViewController.swift
//  TIH API via present
//
//  Created by Ryan Lin on 2023/3/21.

import UIKit
import SafariServices

class IntroViewController: UIViewController {
    
    @IBOutlet weak var colorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introTextView: UITextView!
    @IBOutlet var starImageView: [UIImageView]!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var pageIndicator: UIPageControl!
    @IBOutlet weak var onePhotoActivityIndicator: UIActivityIndicatorView!
    
    var APIValue = ""
    var hotel: Hotel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatedUI()
    }
    
    func updatedUI() {
        onePhotoActivityIndicator.hidesWhenStopped = true
        
        nameLabel.text = hotel?.name
        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        nameLabel.textColor = .white
        nameLabel.contentMode = .center
        nameLabel.backgroundColor = .systemTeal
        
        colorImageView.backgroundColor = .systemTeal
        
        introTextView.text = hotel?.body
        
        ratingLabel.text = hotel?.rating.description
        ratingLabel.font = .systemFont(ofSize: 12, weight: .regular)
        
        pageIndicator.hidesForSinglePage = true
        pageIndicator.numberOfPages = hotel!.images.count
        pageIndicator.pageIndicatorTintColor = .systemGray5
        pageIndicator.currentPageIndicatorTintColor = .systemCyan
        
        for star in starImageView {
            star.image = UIImage(systemName: "star")
            star.tintColor = .systemGray5
        }
        
        let rating = hotel!.rating
        let intStarRating = Int(rating)
        let starRagne = intStarRating-1
        
        if rating != 0 {
            for star in 0...starRagne {
                starImageView[star].tintColor = .systemYellow
                starImageView[star].image = UIImage(systemName: "star.fill")
                
                if rating - Double(intStarRating) > 0 {
                    starImageView[intStarRating].tintColor = .systemYellow
                    starImageView[intStarRating].image = UIImage(systemName: "star.leadinghalf.filled")
                }
            }
        }
        
      
        
        if hotel!.group != "" {
            groupLabel.text = "SG Clean"
            groupLabel.frame = CGRect(x: 245, y: 195, width: 95, height: 30)
            groupLabel.layer.cornerRadius = 15
            groupLabel.clipsToBounds = true
            groupLabel.backgroundColor = UIColor(red: 131/255, green: 181/255, blue: 87/255, alpha: 1)
            groupLabel.font = .systemFont(ofSize: 17, weight: .heavy)
            groupLabel.textAlignment = .center
            groupLabel.textColor = .white
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //用segue的終點型別分辨要傳什麼資料
        if let destoination = segue.destination as? ReviewTableViewController {
            destoination.reviews = hotel!.reviews
        } else if let destination = segue.destination as? MapViewController {
            destination.hotel = hotel
        }
    }
    //決定segue要不要執行
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //用identifier分辨是哪一條segue，及是否為空array
        if identifier == "reviewSegue", hotel?.reviews.isEmpty == true {
            let alert = UIAlertController(title: "NO REVIEW YET !", message: "To return, click on Close ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default))
            present(alert, animated: true)
            return false
        }
        return true
    }
    
    @IBAction func pressWebsiteButton(_ sender: Any) {
        
        if hotel?.officialWebsite.contains("https://") == false {
            let urlString = "https://\(hotel!.officialWebsite)"
            print(urlString)
            if let url = URL(string: urlString) {
                let browser = SFSafariViewController(url: url)
                present(browser, animated: true)
            }
        } else {
            if let url = URL(string: hotel!.officialWebsite) {
                let browser = SFSafariViewController(url: url)
                present(browser, animated: true)
            }
        }
    }
}
