//
//  IntroViewController+Extension.swift
//  TIH API via prepare
//
//  Created by Ryan Lin on 2023/3/25.
//

import Foundation
import UIKit

extension IntroViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //若image array是空的，至少產生一個cell，去顯示APP預設圖片
        if hotel!.images.isEmpty == true {
            return 1
        } else {
            return hotel!.images.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(OneCollectionViewCell.self)", for: indexPath) as? OneCollectionViewCell else {
            fatalError("dequeueReusableCell PhotoCollectionViewCell Failed")
        }
        
        if hotel?.images.isEmpty == true {
            cell.oneImageView.image = UIImage(systemName: "photo.on.rectangle.angled")
            cell.oneImageView.contentMode = .scaleAspectFit
            cell.oneImageView.tintColor = .systemGray4
            
        } else {
            onePhotoActivityIndicator.startAnimating()
            let newIndex = (indexPath.item + hotel!.images.count) % hotel!.images.count
            
            if hotel?.images[newIndex].uuid == "" {
                let urlString = hotel?.images[newIndex].url
                if let url = URL(string: urlString!) {
                    cell.oneImageView.kf.setImage(with: url)
                    cell.oneImageView.contentMode = .scaleAspectFill
                    onePhotoActivityIndicator.stopAnimating()
                }
                
            } else if hotel?.images[newIndex].url == "" {
                let imageUuid = hotel?.images[newIndex].uuid
                if let url = URL(string: "https://tih-api.stb.gov.sg/media/v1/download/uuid/\(imageUuid!)?apikey=\(APIValue)") {
                    cell.oneImageView.kf.setImage(with: url)
                    cell.oneImageView.contentMode = .scaleAspectFill
                    onePhotoActivityIndicator.stopAnimating()
                }
            }
        }
        photoCollectionView.isPagingEnabled = true
        photoCollectionView.showsHorizontalScrollIndicator = false
        return cell
    }
}

extension IntroViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x/scrollView.bounds.width
        pageIndicator.currentPage = Int(pageNumber)
        //print(scrollView.contentOffset.x)
        //print(scrollView.bounds.width)
    }
}
