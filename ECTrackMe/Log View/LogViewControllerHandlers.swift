//
//  LogViewControllerHandlers.swift
//  ECTrackMe
//
//  Created by Ryerson Student on 2018-06-23.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import CoreMotion

extension LogViewController {
    func queryPedometerHandler (pedometerData: CMPedometerData?, error: Error?){
        print( "queryPedometerHandler called", queryPedometerCnt+1, logData.count )

        if( queryPedometerCnt < logData.count ){
            logData[queryPedometerCnt].pedometerData = error == nil ? pedometerData : nil
        }
        queryPedometerCnt += 1
        
        if( queryPedometerCnt == logData.count ){
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
}
