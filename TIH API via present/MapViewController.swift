//
//  MapViewController.swift
//  TIH API via prepare
//
//  Created by Ryan Lin on 2023/3/26.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var hotelMapView: MKMapView!
    @IBOutlet weak var contactNoLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var colorImageView: UIImageView!
    
    var hotel: Hotel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updatedUI()
    }
    
    func updatedUI() {
        
        hotelMapView.frame = CGRect(x: 0, y: 0, width: 393, height: 700)
        
        if let latitude = hotel?.location.latitude,
           let longitude = hotel?.location.longitude {
            //用經緯度定義出座標位置
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            //設定地圖顯示中心點及範圍(公尺)
            let mapRegion = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters:520)
            //顯示地圖
            hotelMapView.setRegion(mapRegion, animated: true)
            let annotation = MKPointAnnotation()
            //設定註解的位置
            annotation.coordinate = location
            annotation.title = hotel?.name
            annotation.subtitle = "Hotel"
            //在地圖上顯示註解
            hotelMapView.addAnnotation(annotation)
        }
        
        if let contactNo = hotel?.contact.primaryContactNo,
           contactNo != ""{
            contactNoLabel.text = "Contact Number: \(contactNo)"
            contactNoLabel.frame = CGRect(x: 60, y: 765, width: 300, height: 30)
            contactNoLabel.font = .systemFont(ofSize: 16, weight: .medium)
            contactNoLabel.textColor = .white
        } else {
            contactNoLabel.isHidden = true
        }
        
        if let postalCode = hotel?.address.postalCode,
           postalCode != "" {
            postalCodeLabel.text = "Postal Code: \(postalCode)"
            postalCodeLabel.frame = CGRect(x: 60, y: 745, width: 300, height: 30)
            postalCodeLabel.font = .systemFont(ofSize: 16, weight: .medium)
            postalCodeLabel.textColor = .white
        } else {
            postalCodeLabel.isHidden = true
        }
        
        if let streetName = hotel?.address.streetName,
           streetName != "" {
            streetLabel.text = "Street Name: \(streetName)"
            streetLabel.frame = CGRect(x: 60, y: 725, width: 300, height: 30)
            streetLabel.font = .systemFont(ofSize: 16, weight: .medium)
            streetLabel.textColor = .white
        } else {
            streetLabel.isHidden = true
        }
        
        colorImageView.frame = CGRect(x: 0, y: 720, width: 393, height: 80)
        colorImageView.backgroundColor = .systemMint
        
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
