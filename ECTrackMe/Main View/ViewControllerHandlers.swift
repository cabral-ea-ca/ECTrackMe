//
//  ViewControllerHandlers.swift
//  ECTrackMe
//
//  Created by Ryerson Student on 2018-06-21.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit
import CoreMotion

extension ViewController{
    internal func accelatorHandler(accelerometerData: CMAccelerometerData?, error:Error?){
        print( "accelatorHandler called", accelerometerData ?? "No Data" )
    }
    
    internal func deviceMotionHandler(deviceMotion: CMDeviceMotion?, error:Error?){
        print( "cmADeviceMotion called", deviceMotion ?? "No Data" )
    }
    
    internal func gyroHandler(gyroData: CMGyroData?, error:Error?){
        print( "gyroHandler called", gyroData ?? "No Data" )
    }
    
    internal func motionActivityHandler(motionActivity: CMMotionActivity?){
        print( "motionActivityHandler called", motionActivity ?? "No Data" )
        activity = motionActivity
        if( activity != nil ){
            DispatchQueue.main.async(execute: updateActivity)
        }
    }
    
    internal func pedoMeterHandler(pedometerData: CMPedometerData?, error: Error?){
        print( "pedoMeterHandler called", pedometerData ?? "No Data" )
        pedometer = pedometerData
        if pedometer != nil {
            DispatchQueue.main.async(execute: updatePedometerInfo)
        }
    }
}

