//
//  LunchDetailsViewController.swift
//  Shubam-People10
//
//  Created by Shubam Gupta on 28/07/20.
//  Copyright © 2020 Shubam. All rights reserved.
//

import UIKit
import MapKit

class LunchDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var restaurantDetails: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MapViewTableViewCell", bundle: nil), forCellReuseIdentifier: "MapViewTableViewCell")
        tableView.register(UINib(nibName: "LunchDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "LunchDetailsTableViewCell")
        
    }
}

extension LunchDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MapViewTableViewCell", for: indexPath) as? MapViewTableViewCell {
                guard let lat = restaurantDetails?.location.lat else { return UITableViewCell() }
                guard let lng = restaurantDetails?.location.lng else { return UITableViewCell() }
                let location = CLLocation(latitude: lat, longitude: lng)
                let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 250.0, longitudinalMeters: 250.0)
                cell.mapView.setRegion(coordinateRegion, animated: false)
                
                let pin = MKPointAnnotation()
                pin.coordinate = location.coordinate
                cell.mapView.addAnnotation(pin)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LunchDetailsTableViewCell", for: indexPath) as? LunchDetailsTableViewCell {
                cell.lblRestaurant.text = restaurantDetails?.name
                cell.lblCategory.text = restaurantDetails?.category
                cell.lblAddress.text = restaurantDetails?.location.formattedAddress[0]
                cell.lblPhoneNumber.text = restaurantDetails?.contact?.formattedPhone
                cell.lblTwitterHandle.text = restaurantDetails?.contact?.twitter
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
