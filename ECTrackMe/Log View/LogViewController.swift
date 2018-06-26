//
//  LogViewController.swift
//  ECTrackMe
//
//  Created by Ryerson Student on 2018-06-21.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit
import CoreMotion

class LogViewCell : UITableViewCell {
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
}

typealias LogDataTuple = ( periodState: PeriodButton.ePeriodState, startDate: Date, endDate:Date, pedometerData: CMPedometerData? )

class LogViewController: UITableViewController {
    @IBOutlet weak var periodButton: PeriodButton!
    
    var logData: [LogDataTuple] = []
    var queryPedometerCnt:Int = 0
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let logViewCell = tableView.dequeueReusableCell(withIdentifier: "LogViewCell", for: indexPath) as! LogViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        if( logData[indexPath.item].periodState == .kToday || logData[indexPath.item].periodState == .kLastTwoDays ){
            dateFormatter.dateFormat = "yyyy-MM-dd h:mm a zzz"
            logViewCell.timeStampLabel.text = dateFormatter.string(from: logData[indexPath.item].startDate)
        }
        else{
            dateFormatter.dateFormat = "yyyy-MM-dd zzz"
            logViewCell.timeStampLabel.text = dateFormatter.string(from: logData[indexPath.item].startDate)
        }

        dateFormatter.dateFormat = "EEEE"
        logViewCell.dayLabel.text = dateFormatter.string(from: logData[indexPath.item].startDate)
        let pedoMeter = logData[indexPath.item].pedometerData
        if( pedoMeter != nil ){
            logViewCell.stepLabel.text = String( format: "%i steps", pedoMeter!.numberOfSteps)
            if( pedoMeter!.distance!.intValue < 1000 ){
                logViewCell.distanceLabel.text = String( format: "%i m", pedoMeter!.distance?.intValue ?? 0 )
            }
            else{
                logViewCell.distanceLabel.text = String( format: "%0.03lf km", pedoMeter!.distance!.doubleValue/1000.0 ?? 0 )
            }
        }
        else{
            logViewCell.stepLabel.text = "---"
            logViewCell.distanceLabel.text = "---"
        }
        
        return logViewCell
    }
    
    internal func populateData(){
        logData.removeAll()
        populateTableViewData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80.0
        populateData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func periodBtnPressed(_ sender: PeriodButton) {
        sender.switchState()
        populateData()
    }
}
