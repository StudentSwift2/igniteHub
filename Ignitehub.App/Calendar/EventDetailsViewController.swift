//
//  EventDetailsViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/31/23.
//

import UIKit

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var dateInfo: UILabel!
    @IBOutlet weak var hoursInfo: UILabel!
    @IBOutlet weak var urlInfo: UILabel!
    
    var urlLink : URL!
    
    @IBAction func openUrl(_ sender: Any) {
        if let url = urlLink {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    var event : Event
    
    init?(coder: NSCoder, event: Event?) {
        self.event = event!
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let strings = String.Localized.self

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
        setNavTitle()

        titleLabel.text = event.name
        dateLabel.text = strings.dateLabel
        dateInfo.text = CalendarHelper().monthDayString(date: event.startDate!)
        
        hoursLabel.text = strings.hoursLabel
        hoursInfo.text = "\(CalendarHelper().timeString(date: event.startDate!)) - \(CalendarHelper().timeString(date: event.endDate!))"
        
        urlLabel.text = "URL: "
        if let url = event.url {
            urlInfo.text = url.absoluteString
            urlLink = url
        }
        
        descriptionTitle.text = strings.descriptionLabel
        descriptionView.text = event.description!
    }
    
    func setNavTitle() {
        let logo = UIImage(named: "Dark Logo")
        let imageView = UIImageView(image:logo)
        navTitle.titleView = imageView
    }
    
    func refresh() {
        blueView.backgroundColor = UIColor.clear
        var colors = Colors()
        var backgroundLayer = colors.gl
        backgroundLayer!.frame = blueView.frame
        blueView.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    
}
