//
//  ReviewTableViewCell.swift
//  TIH API via prepare
//
//  Created by Ryan Lin on 2023/3/23.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet var starImageViews: [UIImageView]!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textTextView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
