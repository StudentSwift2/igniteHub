//
//  DailyViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/31/23.
//

import UIKit

class DailyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var DayLabel: UILabel!
    
    @IBOutlet weak var hourTableView: UITableView!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    
    var hours = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTime()
    }
    
    func initTime() {
        for hour in 0 ... 23
        {
            hours.append(hour)
        }
    }
    
    func detDayView() {
        DayLabel.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hourTableView.dequeueReusableCell(withIdentifier: "dayCell") as! DailyCell
        
        return cell
    }
    
    @IBAction func nextDayAction(_ sender: UIButton) {
    }
    
    @IBAction func previousDayAction(_ sender: UIButton) {
    }
    
}
