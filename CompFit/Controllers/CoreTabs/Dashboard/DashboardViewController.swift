//
//  DashboardViewController.swift
//  CompFit
//
//  Created by Gabriel Dalessandro on 2/9/21.
//

import UIKit
import HealthKit
import Charts


//This is the navigation pane at the bottom of the app screen
class DashboardViewController: UIViewController {
    
    var workouts: [HKWorkout]?
    var stepCountsForDays: HKStatisticsCollection?
    var stepCountDispatchGroup = DispatchGroup()
    var chartData = [BarChartDataEntry]()
    
    let barChartView: BarChartView = {
        let chartView = BarChartView()
        chartView.backgroundColor = .white
        chartView.rightAxis.enabled = false
    
        // Y Axis
        let yAxis = chartView.leftAxis
        yAxis.labelFont = UIFont.poppinsRegular(size: 17)!
        yAxis.setLabelCount(3, force: true)
        yAxis.labelPosition = .outsideChart
        yAxis.labelTextColor = Constants.Colors.brandPink
        yAxis.drawGridLinesEnabled = false
        yAxis.axisMinimum = 0

        
        // X Axis
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont.poppinsRegular(size: 17)!
        xAxis.labelTextColor = Constants.Colors.brandPink
        xAxis.drawGridLinesEnabled = false
        var weekdays: [String] = ["", "S", "M", "T", "W", "T", "F", "S"]
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: weekdays)
        
        // Animations
        chartView.animate(xAxisDuration: 1.0)
        
        // Interactions
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        
        
        return chartView
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        // Building a line chart
        barChartView.delegate = self
        view.addSubview(barChartView)
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        barChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45).isActive = true
        barChartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        barChartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        barChartView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        
        // Apple Health Kit
        // Step Count
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        healthStore?.requestAuthorization(toShare: [stepType], read: [stepType]) { (success, error) in
            if success {
                self.mostRecentStepCount()
            } else {
                print("shucks")
            }
        }
    }
    
    
    func settingLineData(query: HKStatisticsCollectionQuery, statisticsCollection: HKStatisticsCollection?, error: Error?) {
        
        if let results = statisticsCollection {
            stepCountsForDays = results
            let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
            let endDate = Date()
            var day = 1.0
            
            var max = 0
            self.stepCountsForDays?.enumerateStatistics(from: startDate, to: endDate) {
               (statistics, stop) in
               let steps = statistics.sumQuantity()!
               let newDataEntry = BarChartDataEntry(x: day, y: round(steps.doubleValue(for: .count())))
               self.chartData.append(newDataEntry)
                
                if max < Int(steps.doubleValue(for: .count())) {
                    max = Int(steps.doubleValue(for: .count()))
                }

               print("Day \(day): \(Int(steps.doubleValue(for: .count())))")
               day += 1
            }
            
            setBarData(maxValue: max)
        }
        else {
            print("no data returned for those dates")
        }
    }
    
    private func setBarData(maxValue: Int) {
        DispatchQueue.main.async {
            let set1 = BarChartDataSet(entries: self.chartData, label: "Step Count")
            
            set1.setColor(Constants.Colors.brandBlue)
            set1.valueFont = UIFont.poppinsBold(size: 12)!
            set1.valueColors = [.black]
            
            // Y Axis
            if Double(maxValue+2000) <= 10000 {
                self.barChartView.leftAxis.axisMaximum = 10000
            } else {
                self.barChartView.leftAxis.axisMaximum = Double(maxValue+2000)
            }
             

            
            let data = BarChartData(dataSet: set1)
            self.barChartView.data = data
        }
    }
    
    
    // Query the step counts for last 7 days
    private func mostRecentStepCount() {
        print("\n=== Getting Most Recent Step Counts ===")

        let stepType = HKSampleType.quantityType(forIdentifier: .stepCount)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss Z"
        let monday = dateFormatter.date(from: "03-03-2021 09:00:00 +0000")!

        // Construct the actual query
        let daily = DateComponents(day: 1)
        let query = HKStatisticsCollectionQuery(quantityType: stepType,
                                                quantitySamplePredicate: nil,
                                                options: .cumulativeSum,
                                                anchorDate: monday,
                                                intervalComponents: daily)

        // Function that runs once the query has finished executing
        query.initialResultsHandler = { query, statisticsCollection, error in
            self.settingLineData(query: query, statisticsCollection: statisticsCollection, error: error)
        }

        // Runs the actual query
        healthStore?.execute(query)
    }
    
    
    
    

    
    
    
    // Query the step counts for last 7 days
    private func stepCountForPastWeek() {
        print("\n=== Calculating Step Count ===")
        stepCountDispatchGroup.enter()
        
        let stepType = HKSampleType.quantityType(forIdentifier: .stepCount)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss Z"
        
        // Create the anchor: day we want the query to start at
        let monday = dateFormatter.date(from: "27-03-2021 09:00:00 +0000")!
        
        // Interval: breaks up the data into specified chunks (in this case by day)
        let daily = DateComponents(day: 1)
        
        // Construct Predicate
        // Only get step samples from last week
        let exactlySevenDaysAgo = Calendar.current.date(byAdding: DateComponents(day: -7), to: Date())!
        let oneWeekAgo = HKQuery.predicateForSamples(withStart: exactlySevenDaysAgo, end: nil, options: .strictStartDate)

        
        // Construct the actual query
        let query = HKStatisticsCollectionQuery(quantityType: stepType,
                                                quantitySamplePredicate: oneWeekAgo,
                                                options: .cumulativeSum,
                                                anchorDate: monday,
                                                intervalComponents: daily)
        
        // Function that runs once the query has finished executing
        query.initialResultsHandler = { query, statisticsCollection, error in
            if let results = statisticsCollection {
                self.stepCountsForDays = results
                self.stepCountDispatchGroup.leave()
            }
            else {
                print("no data returned for those dates")
            }
        }
        
        // Runs the actual query
        healthStore?.execute(query)
    }
    
    
    
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Dashboard"
        self.navigationItem.title = ""
        
        //Add Notification Button on right side
        let notificationButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .done, target: self, action: #selector(didTapNotificationButton))
        
        // Add upcoming class buttons on the right side
        let upcomingClassesButton = UIBarButtonItem(image: UIImage(systemName: "play.tv"), style: .done, target: self, action: #selector(didTapUpcomingClassesButton))
        
        // Add both buttons to the top right in the nav bar
        self.navigationItem.rightBarButtonItems = [upcomingClassesButton, notificationButton]
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func didTapNotificationButton(){
        let notificationVC = NotificationsViewController()
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    
    @objc private func didTapUpcomingClassesButton(){
        let notificationVC = NotificationsViewController()
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
}



extension DashboardViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
