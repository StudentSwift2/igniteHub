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
    
    
    @IBOutlet weak var igniteDesc: UILabel!
    @IBOutlet weak var tourBtn: UIButton!
    @IBOutlet weak var speakerTitle: UILabel!
    @IBOutlet weak var firechatLabel: UILabel!
    @IBOutlet weak var download1Btn: UIButton!
    @IBOutlet weak var futureLabel: UILabel!
    @IBOutlet weak var download2Btn: UIButton!
    @IBOutlet weak var empowerLabel: UILabel!
    @IBOutlet weak var inputBtn: UIButton!
    @IBOutlet weak var partnerTitle: UILabel!
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!

    @IBOutlet weak var followLabel: UILabel!

    let strings = String.Localized.self
    
    func setLabels() {
        igniteDesc.text = strings.collaboration
        tourBtn.setTitle(strings.tour, for: .normal)
        speakerTitle.text = strings.speakers
        firechatLabel.text = strings.fireside
        download1Btn.setTitle(strings.download, for: .normal)
        download2Btn.setTitle(strings.download, for: .normal)
        empowerLabel.text = strings.empower
        inputBtn.setTitle(strings.input, for: .normal)
        partnerTitle.text = strings.partners
        hoursLabel.text = strings.hours
        daysLabel.text = strings.days
        followLabel.text = strings.follow
    }
    
    let colors = Colors()

    func refresh() {
          bluewView.backgroundColor = UIColor.clear
          let backgroundLayer = colors.gl
          backgroundLayer!.frame = bluewView.frame
          bluewView.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    lazy var carousel = Carousel(frame: .zero, carouselImages: carouselImages)
        
    @IBOutlet weak var igniteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setLabels()

        //let events = FileProccesser.getIgniteHubCalerderData();
       // if let events = events { eventsList = events }

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
