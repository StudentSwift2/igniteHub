//
//  ViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/3/23.
//

import UIKit
import AVKit
import AVFoundation
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var carouselView: Carousel!
    
    let carouselImages : [UIImage] = [
        UIImage(named: "Carousel1")!,
        UIImage(named: "Carousel2")!,
        UIImage(named: "Carousel3")!,
        UIImage(named: "Carousel4")!,
        UIImage(named: "Carousel5")!,
        UIImage(named: "Carousel6")!,
    ]

    @IBOutlet weak var bluewView: UIView!
    @IBOutlet weak var igniteLabel: UILabel!
    
    let colors = Colors()

      func refresh() {
          bluewView.backgroundColor = UIColor.clear
            var backgroundLayer = colors.gl
          backgroundLayer!.frame = bluewView.frame
          bluewView.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    @IBAction func virtualTour(_ sender: UIButton) {

    }
    
    lazy var carousel = Carousel(frame: .zero, carouselImages: carouselImages)
    
    let strings = String.Localized.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        igniteLabel.layer.backgroundColor  = UIColor.white.cgColor
        igniteLabel.layer.cornerRadius = 10
        igniteLabel.layer.masksToBounds = true
        
        refresh()
        setUpHierarchy()
        setUpComponents()
        setUpConstraints()
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
