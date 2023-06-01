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
            let calendarDay = CalendarDay()
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
        
        let formatter = DateFormatter()
        let stringDate = "\(String(describing: calendarDay.day))/\(CalendarHelper().monthString(date: selectedDate))/\(CalendarHelper().yearString(date: selectedDate))"
        formatter.dateFormat = "dd/MM/yy"

        //        if(Event().eventsForDate(date: ).count > 0)
//        {
//            cell.backgroundColor = UIColor.systemCyan
//        }
//        else
//        {
//            cell.backgroundColor = UIColor.white
//        }
        
        if(calendarDay.month == CalendarDay.Month.current)
        {
            cell.dayOfMonth.textColor = UIColor.black
        } else {
            cell.dayOfMonth.textColor = UIColor.gray
        }
        
        return cell
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
    
}