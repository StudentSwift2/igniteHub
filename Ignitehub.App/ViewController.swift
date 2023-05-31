//
//  ViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/3/23.
//

import UIKit
import AVKit
import AVFoundation
import WebKit

class ViewController: UIViewController {
    
    @IBAction func playTourVideo(_ sender: UIButton) {
        let webUrl = "https://www.youtube.com/watch?v=FpxGGc3jKAM"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    
    @IBAction func fireSideDownload(_ sender: Any) {
        let webUrl = "https://ignitehubmc.com/wp-content/uploads/2023/02/ignITe-Hub-Fireside-Chat-Career-Series-Spring-2023-Events-Flyer-3.pdf"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func careerSiteDownload(_ sender: Any) {
        let webUrl = "https://ignitehubmc.com/wp-content/uploads/2023/02/ignITe-Hub-Future-of-Tech-Spring-2023-Flyer-4.pdf"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func toYoutube(_ sender: UIButton) {
        let webUrl = "https://www.youtube.com/channel/UC4HmlgF7F0qxN5bIqjKgCTQ"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    var playerViewController: AVPlayerViewController?
    
    @IBOutlet weak var carouselView: Carousel!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    let carouselImages : [UIImage] = [
        UIImage(named: "Carousel1")!,
        UIImage(named: "Carousel2")!,
        UIImage(named: "Carousel3")!,
        UIImage(named: "Carousel4")!,
        UIImage(named: "Carousel5")!,
        UIImage(named: "Carousel6")!,
    ]

    @IBOutlet weak var bluewView: UIView!
    @IBOutlet weak var empowerView: UIView!
    @IBOutlet weak var igniteLabel: UILabel!
    
    let colors = Colors()
    let colors2 = Colors()

    func refresh() {
          bluewView.backgroundColor = UIColor.clear
          let backgroundLayer = colors.gl
          backgroundLayer!.frame = bluewView.frame
          bluewView.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    lazy var carousel = Carousel(frame: .zero, carouselImages: carouselImages)
    
    let strings = String.Localized.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitle()
        getVideo()
        
        igniteLabel.layer.backgroundColor  = UIColor.white.cgColor
        igniteLabel.layer.cornerRadius = 10
        igniteLabel.layer.masksToBounds = true
    
        refresh()
        setUpHierarchy()
        setUpComponents()
        setUpConstraints()
    }
    
    func setNavTitle() {
        let logo = UIImage(named: "Dark Logo")
        let imageView = UIImageView(image:logo)
        navTitle.titleView = imageView
    }
    
    func getVideo() {
        let videoId = "esGnhEDICyo"
        let urlString = "https://www.youtube.com/embed/\(videoId)"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() {
                loadedImages[url] = UIImage(data: data)
                }
        }
    }
    
    func setUpHierarchy() {
        carouselView.addSubview(carousel)
    }
    
    func setUpComponents() {
        carousel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: carouselView.topAnchor),
            carousel.bottomAnchor.constraint(equalTo: carouselView.bottomAnchor),
            carousel.leadingAnchor.constraint(equalTo: carouselView.leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: carouselView.trailingAnchor)
        ])
    }


}

class Colors {
    var gl:CAGradientLayer!

    init() {
        let colorTop = UIColor(red: 12.0 / 255.0, green: 123.0 / 255.0, blue: 192.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 69.0 / 255.0, green: 160.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0).cgColor

        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
