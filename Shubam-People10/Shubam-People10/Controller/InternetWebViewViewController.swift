//
//  InternetWebViewViewController.swift
//  Shubam-People10
//
//  Created by Shubam Gupta on 28/07/20.
//  Copyright © 2020 Shubam. All rights reserved.
//

import UIKit
import WebKit

class InternetWebViewViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnRefresh: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIButton!
    private let webView = WKWebView(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
         webView.translatesAutoresizingMaskIntoConstraints = false
              self.view.addSubview(self.webView)
           // You can set constant space for Left, Right, Top and Bottom Anchors
               NSLayoutConstraint.activate([
                   self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                   self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                   self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                   self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
                   ])
               // For constant height use the below constraint and set your height constant and remove either top or bottom constraint
               //self.webView.heightAnchor.constraint(equalToConstant: 200.0),

               self.view.setNeedsLayout()
               let request = URLRequest(url: URL(string: "https://www.bottlerocketstudios.com")!)
               self.webView.load(request)
    }
    
    @IBAction func btnActionBack(_ sender: Any) {
    }
    @IBAction func btnActionRefresh(_ sender: Any) {
    }
    @IBAction func btnActionNext(_ sender: Any) {
    }
    
   
}
