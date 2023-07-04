//
//  ListTableViewController.swift
//  TIH API practice
//
//  Created by Ryan Lin
//

import UIKit
import Kingfisher

class ListTableViewController: UITableViewController {
    
    let APIValue = "2MV9KptglA9cGJA1wMqJXE2kJZOCEDeE"
    
    var hotels = [Hotel]()
    
    func fetchList() {
        let urlString = "https://api.stb.gov.sg/content/accommodation/v2/search?searchType=keyword&searchValues=city%20hall&sort=name&sortOrder=asc"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.setValue(APIValue, forHTTPHeaderField: "X-API-Key")
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data,
                   let response = response as? HTTPURLResponse {
                    //印出server狀態
                    print("statusCode",response.statusCode)
                    let decorder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                    decorder.dateDecodingStrategy = .formatted(dateFormatter)
                    do {
                        //從JSON物件轉換成我們指定型別的值
                        let result = try decorder.decode(Result.self, from: data)
                        //轉換好型別後，存入定義好相同型別的空 array
                        //重要：得一起寫在 URLSession.shared.dataTask (background thread)裡，不然會存到空的資料
                        self.hotels = result.data
                        //印出筆數
                        print(self.hotels.count)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList()
    }
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 1
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hotels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ListTableViewCell.self)", for: indexPath) as! ListTableViewCell
        
        let hotel = hotels[indexPath.row]
        //顯示飯店照片
        //防止cell重複利用顯示錯誤影像，方法一：先清空影像
        cell.photoImageView.image = nil
        cell.processIndicator.startAnimating()
        /*
         防止cell重複利用顯示錯誤影像，方法二：顯示預設照片
         cell.photoImageView.image = UIImage(systemName: "photo")
         cell.photoImageView.tintColor = .systemGray5
         cell.photoImageView.contentMode = .scaleAspectFit
         cell.photoImageView.layer.cornerRadius = 10
         */
        //當uuid是空字串，從url取得圖片
        if hotel.images.first?.uuid == "" {
            let urlString = hotel.images.first?.url
            let finalUrl = URL(string: urlString!)
            print("imageURL", urlString!)
            cell.photoImageView.kf.setImage(with: finalUrl)
            cell.photoImageView.contentMode = .scaleAspectFill
            cell.processIndicator.stopAnimating()
        }
        //當url是空字串，從uuid取得圖片
        else if hotel.images.first?.url == "" {
            
            let hotelUuid = hotel.images.first?.uuid
            if let url = URL(string: "https://tih-api.stb.gov.sg/media/v1/download/uuid/\(hotelUuid!)?apikey=\(APIValue)") {
                cell.photoImageView.kf.setImage(with: url)
                cell.photoImageView.contentMode = .scaleAspectFill
                cell.processIndicator.stopAnimating()
            }
        } else {
            //當uuid跟url都沒有時，顯示特定圖示
            cell.photoImageView.image = UIImage(systemName: "photo.on.rectangle.angled")
            cell.photoImageView.tintColor = .systemGray4
            cell.photoImageView.contentMode = .scaleAspectFit
            cell.processIndicator.stopAnimating()
        }
        
        cell.titleLabel.text = hotel.name
        
        cell.ratingLabel.text = hotel.rating.description
        //show the stars of rating
        //avoid showing wrong images on cell
        for star in cell.ratingImageViews {
            star.image = UIImage(systemName: "")
        }
        
        for star in cell.ratingImageViews {
            star.image = UIImage(systemName: "star")
            star.tintColor = .systemGray5
        }
        
        let rating = hotel.rating
        let starRagne = Int(rating)-1
        //print(indexPath.row, rating, starRagne)
        
        if rating != 0 {
            for star in 0...starRagne {
                
                cell.ratingImageViews[star].tintColor = .systemYellow
                cell.ratingImageViews[star].image = UIImage(systemName: "star.fill")
                
                if rating - Double(Int(rating)) > 0 {
                    cell.ratingImageViews[Int(rating)].tintColor = .systemYellow
                    cell.ratingImageViews[Int(rating)].image = UIImage(systemName: "star.leadinghalf.filled")
                }
            }
        }
        
        
        //顯示是否有官方衛生認證 SG Clean
        if hotel.group != "" {
            cell.groupLabel.text = "SG Clean"
            cell.groupLabel.backgroundColor = UIColor(red: 131/255, green: 181/255, blue: 87/255, alpha: 1)
        }
        
        cell.configuration()
        
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //用prepare傳遞資料
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? IntroViewController,
           let row = self.tableView.indexPathForSelectedRow?.row {
            let hotel = hotels[row]
            destination.hotel = hotel
            destination.APIValue = APIValue
        }
    }
}

