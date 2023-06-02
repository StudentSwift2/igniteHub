//
//  WeeklyViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/15/23.
//

import UIKit

var selectedDate = Date()

class WeeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var blueView: UIView!
    
    var totalSquares = [Date]()
    
    @IBSegueAction func showDetails(_ coder: NSCoder, sender: Any?) -> EventDetailsViewController? {
        if let cell = sender as? EventCell, let indexPath = tableView.indexPath(for: cell) {
            
            let event = Event().eventsForDate(date: selectedDate)[indexPath.row]
            return EventDetailsViewController(coder: coder, event: event)
        } else {
            return EventDetailsViewController(coder: coder, event: nil)
        }    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "Dark Logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        setLabels()
        refresh()
        setCellsView()
        setWeekView()
    }
    
    func refresh() {
        blueView.backgroundColor = UIColor.clear
        var colors = Colors()
        var backgroundLayer = colors.gl
        backgroundLayer!.frame = blueView.frame
        blueView.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func setCellsView ()
    {
        
        var width = (collectionView.frame.size.width - 2) / 8

        if(UIScreen.main.bounds.width > 390) {
            width = (collectionView.frame.size.width - 2) / 7
        }
        
        let height = (collectionView.frame.size.height - 2) 
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setWeekView()
    {
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while(current < nextSunday)
        {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let date = totalSquares[indexPath.item]
        cell.dayOfMonth.text = String(CalendarHelper().daysOfMonth(date: date))
        
        if(date == selectedDate)
        {
            cell.backgroundColor = UIColor.systemCyan
        }
        else
        {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    @IBAction func prevWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
    }
    
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Event().eventsForDate(date: selectedDate).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! EventCell
        let event = Event().eventsForDate(date: selectedDate)[indexPath.row]
        cell.eventLabel.text = event.name + " " + CalendarHelper().timeString(date: event.startDate)
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setWeekView()
    }
    
    @IBOutlet weak var sun: UILabel!
    @IBOutlet weak var mon: UILabel!
    @IBOutlet weak var tue: UILabel!
    @IBOutlet weak var wed: UILabel!
    @IBOutlet weak var thu: UILabel!
    @IBOutlet weak var fri: UILabel!
    @IBOutlet weak var sat: UILabel!
    @IBOutlet weak var dailyBtn: UIButton!
    
    let strings = String.Localized.self
    
    func setLabels() {
        sun.text = String(strings.sunday.prefix(3))
        mon.text = String(strings.monday.prefix(3))
        tue.text = String(strings.tuesday.prefix(3))
        wed.text = String(strings.wednesday.prefix(3))
        thu.text = String(strings.thursday.prefix(3))
        fri.text = String(strings.friday.prefix(3))
        sat.text = String(strings.saturday.prefix(3))
        dailyBtn.setTitle(strings.daily, for: .normal)

    }
}
