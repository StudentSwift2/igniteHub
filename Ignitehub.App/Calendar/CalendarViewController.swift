//
//  CalendarViewController.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/18/23.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var blueView: UIView!
    
    var selectedDate = Date()
    var totalSquares = [CalendarDay]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "Dark Logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        refresh()
        setLabels()
        setCellsView()
        setMonthView()
    }
    
    func refresh() {
        blueView.backgroundColor = UIColor.clear
        let colors = Colors()
        let backgroundLayer = colors.gl
        backgroundLayer!.frame = blueView.frame
        blueView.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func setCellsView ()
    {
        var width = (collectionView.frame.size.width - 2) / 8

        if(UIScreen.main.bounds.width > 390) {
            width = (collectionView.frame.size.width - 2) / 7
        }
        
        let height = (collectionView.frame.size.height - 2) / 6
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView()
    {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count : Int = 1
        
        let prevMonth = CalendarHelper().minusMonth(date: selectedDate)
        let daysInPrevMonth = CalendarHelper().daysInMonth(date: prevMonth)
        
        while(count <= 42) {
            var calendarDay = CalendarDay()
            if(count <= startingSpaces) {
                let prevMonthDay = daysInPrevMonth - startingSpaces + count
                calendarDay.day = String(prevMonthDay)
                calendarDay.month = CalendarDay.Month.previous
            } else if count - startingSpaces > daysInMonth {
                calendarDay.day = String(count - daysInMonth - startingSpaces)
                calendarDay.month = CalendarDay.Month.next
            } else {
                calendarDay.day = String(count - startingSpaces)
                calendarDay.month = CalendarDay.Month.current
            }
            totalSquares.append(calendarDay)
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let calendarDay = totalSquares[indexPath.item]
        cell.dayOfMonth.text = calendarDay.day
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        let day = Int(calendarDay.day)!
        let date = CalendarHelper().addDays(date: CalendarHelper().firstOfMonth(date: selectedDate), days: day-1)
        if(Event().eventsForDate(date: date).count > 0 && calendarDay.month == CalendarDay.Month.current)
        {
            cell.backgroundColor = UIColor.systemCyan
        }
        else
        {
            cell.backgroundColor = UIColor.white
        }
        
        if(calendarDay.month == CalendarDay.Month.current)
        {
            cell.dayOfMonth.textColor = UIColor.black
        } else {
            cell.dayOfMonth.textColor = UIColor.gray
        }
        
        return cell
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toWeek", sender: nil)
    }
    
    @IBAction func prevMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setMonthView()
    }
    
    @IBOutlet weak var sun: UILabel!
    @IBOutlet weak var mon: UILabel!
    @IBOutlet weak var tue: UILabel!
    @IBOutlet weak var wed: UILabel!
    @IBOutlet weak var thu: UILabel!
    @IBOutlet weak var fri: UILabel!
    @IBOutlet weak var sat: UILabel!
    @IBOutlet weak var weeklyBtn: UIButton!
    
    let strings = String.Localized.self

    func setLabels() {
        sun.text = String(strings.sunday.prefix(3))
        mon.text = String(strings.monday.prefix(3))
        tue.text = String(strings.tuesday.prefix(3))
        wed.text = String(strings.wednesday.prefix(3))
        thu.text = String(strings.thursday.prefix(3))
        fri.text = String(strings.friday.prefix(3))
        sat.text = String(strings.saturday.prefix(3))
        weeklyBtn.setTitle(strings.weekly , for: .normal)
    }
    
}

