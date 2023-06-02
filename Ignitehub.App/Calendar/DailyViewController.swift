//
//  DailyViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/31/23.
//

import UIKit

class DailyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var DayLabel: UILabel!
    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var hourTableView: UITableView!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    
    var hours = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "Dark Logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        refresh()
        initTime()
    }
    
    func refresh() {
        blueView.backgroundColor = UIColor.clear
        var colors = Colors()
        var backgroundLayer = colors.gl
        backgroundLayer!.frame = blueView.frame
        blueView.layer.insertSublayer(backgroundLayer!, at: 0)
  }
    
    @IBSegueAction func showDetails(_ coder: NSCoder, sender: Any?) -> EventDetailsViewController? {
        if let cell = sender as? DailyCell, let indexPath = hourTableView.indexPath(for: cell){
            let hour = hours[indexPath.row]
            let event = Event().eventsForDateAndTime(date: selectedDate, hour: hour)[0]
            return EventDetailsViewController(coder: coder, event: event)
        } else {
            return EventDetailsViewController(coder: coder, event: nil)
        }
    }
    
    
    func initTime() {
        for hour in 9 ... 15
        {
            hours.append(hour)
        }
    }
    
    func setDayView() {
        DayLabel.text = CalendarHelper().monthDayString(date: selectedDate)
        dayOfWeekLabel.text = CalendarHelper().weekDayAsString(date: selectedDate)
        hourTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell") as! DailyCell
        
        let hour = hours[indexPath.row]
        cell.time.text = formatHour(hour: hour)
        
        let events = Event().eventsForDateAndTime(date: selectedDate, hour: hour)
        setEvents(cell, events)
        
        return cell
    }
    
    func setEvents(_ cell: DailyCell, _ events: [Event]) {
        hideAll(cell)
        switch events.count {
        case 1:
            setEvent1(cell, events[0])
        case 2:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
        case 3:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
            setEvent3(cell, events[2])
        case let count where count > 3:
            setEvent1(cell, events[0])
            setEvent1(cell, events[0])
            setMoreEvents(cell, count: events.count - 2)
        default: break
        }
    }
    
    func setMoreEvents(_ cell : DailyCell, count : Int) {
        cell.event3.isHidden = false
        cell.event3.text = String(count) + "More Events"
    }
    
    func setEvent1(_ cell : DailyCell, _ event: Event) {
        cell.event1.isHidden = false
        cell.event1.text = event.name
    }
    
    func setEvent2(_ cell : DailyCell, _ event: Event) {
        cell.event2.isHidden = false
        cell.event2.text = event.name
    }
    
    func setEvent3(_ cell : DailyCell, _ event: Event) {
        cell.event3.isHidden = false
        cell.event3.text = event.name
    }
    
    func hideAll(_ cell: DailyCell) {
        cell.event1.isHidden = true
        cell.event2.isHidden = true
        cell.event3.isHidden = true

    }
    
    func formatHour(hour: Int) -> String {
        return String(format: "%02d:%02d", hour, 0)
    }
    
    @IBAction func nextDayAction(_ sender: UIButton) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 1)
        setDayView()
    }
    
    @IBAction func previousDayAction(_ sender: UIButton) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -1)
        setDayView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDayView()
    }
    
}
