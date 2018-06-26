//
//  ViewControllerDispatchFunc.swift
//  ECTrackMe
//
//  Created by Ryerson Student on 2018-06-21.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit
import CoreMotion

extension ViewController{
    internal func updateActivity(){
        if activity!.walking {
            activityLabel.text = "Walking"
        } else if activity!.stationary {
            activityLabel.text = "Stationary"
        } else if activity!.running {
            activityLabel.text = "Running"
        } else if activity!.automotive {
            activityLabel.text = "Automotive"
        }
    }
    
    internal func updatePedometerInfo(){
        noOfStepsLabel.text = String(format: "%d steps", pedometer!.numberOfSteps.intValue)
        distanceLabel.text = String(format: "%i meters",  (pedometer!.distance?.intValue)! )
        floorAscLabel.text = String(format: "%i", pedometer!.floorsAscended != nil ? (pedometer!.floorsAscended?.intValue)! : "0" )
        floorDescLabel.text = String(format: "%i", pedometer!.floorsDescended != nil ? (pedometer!.floorsDescended?.intValue)! : "0" )
        var lastDistanceDiffRec:Int = 0
        var lastElapsedTimeDiffRec:Int = 0
        let currTime = Int(timer!.fireDate.timeIntervalSince(timeStarted!))-1
        if( pedometer!.distance != nil ){
            lastDistanceDiffRec = (pedometer!.distance?.intValue)! - lastDistanceRec
            lastDistanceRec = (pedometer!.distance?.intValue)!
            lastElapsedTimeDiffRec = currTime - lastElapsedTimeRec
            lastElapsedTimeRec     = currTime
        }
        else{
            lastDistanceRec = 0
        }
        if( lastDistanceDiffRec != 0 ){
            paceLabel.text = String(format: "%0.2lf s/m", Double(lastElapsedTimeDiffRec)/Double(lastDistanceDiffRec))
        }
        else{
            paceLabel.text = "-- s/m"
        }
        if lastDistanceRec != 0 {
            avePaceLabel.text = String(format: "%0.2lf s/m", Double(lastElapsedTimeRec)/Double(lastDistanceRec))
        }
        else{
            avePaceLabel.text = "-- s/m"
        }
    }
    
    internal func updateTimeElapsed(){
        var timeElapsedSec:Int = Int(timer!.fireDate.timeIntervalSince(timeStarted!))-1
        let timeElapsedHr = timeElapsedSec / 3600
        let timeElapsedMin = (timeElapsedSec / 60) % 60
        timeElapsedSec %= 60
        elapsedTimeLabel.text = String(format:"%02i:%02i:%02i",timeElapsedHr,timeElapsedMin,timeElapsedSec)
    }
    
    internal func startServicesUpdates(){
        if CMMotionActivityManager.isActivityAvailable() {
            activityMotionMngr.startActivityUpdates(to: motionOperQueue, withHandler: motionActivityHandler)
        }
        
        if CMPedometer.isStepCountingAvailable() {
            pedoMeter.startUpdates(from: Date(), withHandler: pedoMeterHandler)
        }
/*
         if motionMngr.isAccelerometerAvailable {
         motionMngr.accelerometerUpdateInterval = 1
         motionMngr.startAccelerometerUpdates(to: acclelatorOperQueue, withHandler: accelatorHandler)
         }
         
         if motionMngr.isDeviceMotionActive {
         motionMngr.deviceMotionUpdateInterval  = 1
         motionMngr.startDeviceMotionUpdates(to: deviceMotionOperQueue, withHandler: deviceMotionHandler)
         }
         
         if motionMngr.isGyroAvailable {
         motionMngr.gyroUpdateInterval = 1
         motionMngr.startGyroUpdates(to: gyroOperQueue, withHandler: gyroHandler)
         }
*/
    }
}

