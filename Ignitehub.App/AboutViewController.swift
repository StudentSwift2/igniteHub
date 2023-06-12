//
//  AboutViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/30/23.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
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
    
    @IBAction func toYoutube(_ sender: UIButton) {
        let webUrl = "https://www.youtube.com/channel/UC4HmlgF7F0qxN5bIqjKgCTQ"
        if let url = URL(string: webUrl) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    @IBOutlet weak var AboutTitle: UILabel!
    @IBOutlet weak var visionTitle: UILabel!
    @IBOutlet weak var visionDesc: UILabel!
    @IBOutlet weak var missionTitle: UILabel!
    @IBOutlet weak var missionDesc: UILabel!
    @IBOutlet weak var staffTitle: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var biographyTitle: UILabel!
    @IBOutlet weak var biographyDesc: UILabel!
    @IBOutlet weak var techTraining: UILabel!
    @IBOutlet weak var labCord: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var follow: UILabel!
    
    let strings = String.Localized.self
    
    func setLabels() {
        AboutTitle.text = strings.about
        visionTitle.text = strings.vision
        visionDesc.text = strings.visionDesc
        missionTitle.text = strings.mission
        missionDesc.text = strings.missionDesc
        staffTitle.text = strings.staff
        director.text = strings.director
        biographyTitle.text = strings.biography
        biographyDesc.text = strings.biographyDesc
        techTraining.text = strings.techTrain
        labCord.text = strings.labCord
        hours.text = strings.hours
        days.text = strings.days
        follow.text = strings.follow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabels()
        let logo = UIImage(named: "Dark Logo")
        let imageView = UIImageView(image:logo)
        navTitle.titleView = imageView
    }
    

}
