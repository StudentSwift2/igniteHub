//
//  ResourcesViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 6/2/23.
//

import UIKit
import MessageUI

class ResourcesViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBAction func sendEmail(_ sender: Any) {
        let check = MFMailComposeViewController.canSendMail()
        
        if MFMailComposeViewController.canSendMail() {
               let mail = MFMailComposeViewController()
               mail.mailComposeDelegate = self
               mail.setToRecipients(["you@yoursite.com"])
               mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

               present(mail, animated: true)
           } else {
               // show failure alert
           }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        refresh()
        setNavTitle()
    }
    
    func setNavTitle() {
        let logo = UIImage(named: "Dark Logo")
        let imageView = UIImageView(image:logo)
        navTitle.titleView = imageView
    }
    
    @IBOutlet weak var blueView: UIView!
    
    let colors = Colors()

    func refresh() {
        blueView.backgroundColor = UIColor.clear
          let backgroundLayer = colors.gl
          backgroundLayer!.frame = blueView.frame
        blueView.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    @IBAction func toYoutube(_ sender: UIButton) {
        let webUrl = "https://www.youtube.com/channel/UC4HmlgF7F0qxN5bIqjKgCTQ"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func launchSeries(_ sender: Any) {
        let webUrl = "https://www.youtube.com/playlist?list=PLQSDG1T2oYYhIsbi4C2nQCqeNPqXT5u5S"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func launchFireSide(_ sender: Any) {
        let webUrl = "https://www.youtube.com/playlist?list=PLQSDG1T2oYYgXzrt5Z1kMTB0uvtDVRY26"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func launchHiring(_ sender: Any) {
        let webUrl = "https://ignitehubmc.com/wp-content/uploads/2023/05/MCC_Recruitment-Flyer_Summer-2023-b-scaled.jpg"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func launchCareer(_ sender: Any) {
        let webUrl = "https://ignitehubmc.com/wp-content/uploads/2023/01/NSA_ApplyOnline_QR-Code_CardDesign_508_Page_1.jpg"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func launchNaval(_ sender: Any) {
        let webUrl = "https://ignitehubmc.com/wp-content/uploads/2023/02/New-Hire-Naval.jpg"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    @IBOutlet weak var ResourcesTitle: UILabel!
    @IBOutlet weak var videoArchives: UILabel!
    @IBOutlet weak var JobLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var followLabel: UILabel!

    let strings = String.Localized.self
    
    func setLabels() {
        ResourcesTitle.text = strings.resources
        videoArchives.text = strings.videos
        JobLabel.text = strings.jobs
        hoursLabel.text = strings.hours
        daysLabel.text = strings.days
        followLabel.text = strings.follow
    }
}
