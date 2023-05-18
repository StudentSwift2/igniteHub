//
//  CarouselViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/16/23.
//

import UIKit

class CarouselViewController: UIViewController {
    
    lazy var carousel = Carousel(frame: .zero, urls: carouselUrls)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpHierarchy()
        setUpComponents()
        setUpConstraints()
    }
    
    override func loadView() {
        let veiw = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
    
    func setUpHierarchy() {
        self.view.addSubview(carousel)
    }
    
    func setUpComponents() {
        carousel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            carousel.topAnchor.constraint(equalTo: view.topAnchor),
            carousel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}
