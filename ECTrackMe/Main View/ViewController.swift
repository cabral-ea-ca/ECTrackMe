//
//  ViewController.swift
//  ECTrackMe
//
//  Created by Ryerson Student on 2018-06-21.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit
import CoreMotion

var activityMotionMngr = CMMotionActivityManager()
var pedoMeter = CMPedometer()

class ViewController: UIViewController {
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var noOfStepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var floorAscLabel: UILabel!
    @IBOutlet weak var floorDescLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var avePaceLabel: UILabel!
    @IBOutlet weak var activityButton: UIButton!
/*
    var motionMngr:CMMotionManager = CMMotionManager()
    var acclelatorOperQueue = OperationQueue()
    var deviceMotionOperQueue = OperationQueue()
    var gyroOperQueue = OperationQueue()
*/
    var motionOperQueue = OperationQueue()
    
    var timer:Timer?
    var timeStarted:Date?
    var lastDistanceRec:Int = 0
    var lastElapsedTimeRec:Int = 0
    var activity:CMMotionActivity?
    var pedometer:CMPedometerData?
    
    internal var first:Bool = true
    
    @objc internal func timerHandler(timer: Timer){
        DispatchQueue.main.async(execute: updateTimeElapsed)
    }
    
    internal func startUpdating() {
        print( "startUpdating called" )
        timeStarted = Date()
        timer = Timer(fireAt: timeStarted!, interval: 1.0, target: self, selector: #selector(self.timerHandler), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
        DispatchQueue.main.async(execute: startServicesUpdates)
    }
    
    internal func stopUpdating() {
        //motionMngr.stopGyroUpdates()
        //motionMngr.startDeviceMotionUpdates()
        //motionMngr.stopAccelerometerUpdates()
        activityMotionMngr.stopActivityUpdates()
        pedoMeter.stopUpdates()
        timer?.invalidate()
        timer = nil
    }
    
    @IBAction func activityBtnTouchUpIn(_ sender: UIButton) {
        if sender.title(for: .normal) == "Start"{
            sender.setTitle("Stop", for: .normal)
            startUpdating()
        }
        else{
            sender.setTitle("Start", for: .normal)
            stopUpdating()
        }
    }
    
    @IBAction func logsButton(_ sender: UIBarButtonItem) {
        // activityButton.setTitle("Start", for: .normal)
        // stopUpdating()
        performSegue(withIdentifier: "LogsSeque", sender: self)
    }
    
    internal func checkMotionServ(){
        print ( "checkMotionServ called" )
        if #available(iOS 11.0, *){
            switch CMMotionActivityManager.authorizationStatus(){
            case.authorized:
                print( "authorized" )
                
            case .denied,
                 .notDetermined,
                 .restricted :
                if( self.navigationController?.visibleViewController == self && AppDelegate.displayAlert == nil ){
                    AppDelegate.displayAlert = DisplayAlert()
                    AppDelegate.displayAlert!.showAlertMotion(title: "Motion & Fitness Setting", message: "Kindly allow the app to use it.", viewController: self)
                }
                
            }
        }
    }
    
    @objc func applicationDidBecomeActive(_ notification: NSNotification) {
        print ( "ViewController: applicationDidBecomeActive called" )
        checkMotionServ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        elapsedTimeLabel.text = "--:--:--"
        activityLabel.text = "Not available"
        noOfStepsLabel.text = ""
        distanceLabel.text = ""
        floorAscLabel.text = ""
        floorDescLabel.text = ""
        paceLabel.text = ""
        avePaceLabel.text = ""
        activityButton.setTitle("Start", for: .normal)
        
        if #available(iOS 11.0, *){
            NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
        
        if #available(iOS 11.0, *){
        }
        else{
            if( first && AppDelegate.displayAlert == nil ){
                first = false
                AppDelegate.displayAlert = DisplayAlert()
                AppDelegate.displayAlert!.showAlertMotion(title: "Motion & Fitness Setting", message: "Kindly allow the app to use it.", viewController: self)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
