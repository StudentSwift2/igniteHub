//
//  AboutViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/30/23.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBAction func toYoutube(_ sender: UIButton) {
        let webUrl = "https://www.youtube.com/channel/UC4HmlgF7F0qxN5bIqjKgCTQ"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let logo = UIImage(named: "Dark Logo")
        let imageView = UIImageView(image:logo)
        navTitle.titleView = imageView
    }
    

}
