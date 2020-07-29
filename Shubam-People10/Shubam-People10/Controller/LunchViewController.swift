//
//  LunchViewController.swift
//  Shubam-People10
//
//  Created by Shubam Gupta on 28/07/20.
//  Copyright © 2020 Shubam. All rights reserved.
//

import UIKit

class LunchViewController: UIViewController {

    var listOfRestaurants: [Restaurant]? = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let imageCache = NSCache<NSString, UIImage>()
     
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "LunchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LunchCollectionViewCell")

        apiCallBack()
        
    }
    
    func apiCallBack() {
        Middleware.init { (status, data, message) in
            switch status {
            case .success:
                guard let info = data as? LunchDetails else {
                    return
                }
                print(info)
                self.listOfRestaurants = info.restaurants
            case .badRequest:
                break
            default:
                break
            }
        }.sampleAPI()
    }
}

extension LunchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfRestaurants?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LunchCollectionViewCell", for: indexPath) as? LunchCollectionViewCell {
            cell.lblRestaurantName.text = listOfRestaurants?[indexPath.row].name
            cell.lblCategoryType.text = listOfRestaurants?[indexPath.row].category
        
            let img = listOfRestaurants?[indexPath.row].backgroundImageURL
            if let strUrl = img?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                  let imgUrl = URL(string: strUrl) {
                cell.imageView.loadImageWithUrl(imgUrl) // call this line for getting image to yourImageView
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "LunchDetailsViewController") as! LunchDetailsViewController
        next.restaurantDetails = listOfRestaurants?[indexPath.row]
        navigationController?.pushViewController(next, animated: true)
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {

    var imageURL: URL?
    let activityIndicator = UIActivityIndicatorView()
    
    func loadImageWithUrl(_ url: URL) {

        // setup activityIndicator...
        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageURL = url

        image = nil
        activityIndicator.startAnimating()

        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {

            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }

        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }

            DispatchQueue.main.async(execute: {

                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {

                    if self.imageURL == url {
                        self.image = imageToCache
                    }

                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
    
}
