//
//  ListTableViewCell.swift
//  TIH API practice
//
//  Created by Ryan Lin
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var processIndicator: UIActivityIndicatorView!
    @IBOutlet var ratingImageViews: [UIImageView]!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configuration() {
        ratingLabel.font = .systemFont(ofSize: 10, weight: .light)
        
        processIndicator.hidesWhenStopped = true
        
        photoImageView.layer.cornerRadius = 10
        
        titleLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        
        groupLabel.clipsToBounds = true
        groupLabel.layer.cornerRadius = 10
        groupLabel.font = .systemFont(ofSize: 14, weight: .heavy)
        groupLabel.textColor = .white
    }
    
}

