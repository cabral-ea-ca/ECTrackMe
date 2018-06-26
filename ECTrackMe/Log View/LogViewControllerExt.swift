//
//  LogViewControllerExt.swift
//  ECTrackMe
//
//  Created by Ryerson Student on 2018-06-25.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import Foundation

extension LogViewController {
    func populateTableViewData (){
        queryPedometerCnt = 0
        let SecInDay: TimeInterval = 86400.0 // 60 seconds * 60 minutes * 24 hours
        let SecIn3Hr: TimeInterval = 10800.0 // 60 seconds * 60 minutes * 3 hours
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.autoupdatingCurrent

        switch periodButton.periodState {
            case .kToday :
                print( "Today" )
                let currentDate  =  Date()
                var startDate    = currentDate
                var interval         = 0.0
                _ = calendar.dateInterval(of: .day, start: &startDate, interval: &interval, for: currentDate)
                let terminalDate = startDate.addingTimeInterval( SecInDay )
                print( "terminalDate ", terminalDate )
                var endDate      = startDate.addingTimeInterval( SecIn3Hr-1 )

                while( startDate < terminalDate ){
                    print( startDate, endDate )
                    logData.append(LogDataTuple(periodState: periodButton.periodState, startDate: startDate, endDate:endDate, pedometerData: nil))
                    startDate = startDate.addingTimeInterval( SecIn3Hr )
                    endDate   = endDate.addingTimeInterval( SecIn3Hr )
                }
                for log in logData {
                    pedoMeter.queryPedometerData(from: log.startDate, to: log.endDate, withHandler: queryPedometerHandler)
                }
            
            case .kLastTwoDays :
                print( "Last Two Days" )
                let currentDate  =  Date()
                var startDate    = currentDate
                var interval         = 0.0
                _ = calendar.dateInterval(of: .day, start: &startDate, interval: &interval, for: currentDate)
                let terminalDate = startDate.addingTimeInterval( SecInDay )
                print( "terminalDate ", terminalDate )
                startDate        = startDate.addingTimeInterval( -SecInDay )
                var endDate      = startDate.addingTimeInterval( SecIn3Hr-1 )

                while( startDate < terminalDate ){
                    print( startDate, endDate )
                    logData.append(LogDataTuple(periodState: periodButton.periodState, startDate: startDate, endDate:endDate, pedometerData: nil))
                    startDate = startDate.addingTimeInterval( SecIn3Hr )
                    endDate   = endDate.addingTimeInterval( SecIn3Hr )
                }
                for log in logData {
                    pedoMeter.queryPedometerData(from: log.startDate, to: log.endDate, withHandler: queryPedometerHandler)
                }

            case .kThisWeek :
                print( "This week" )
                let currentDate  =  Date()
                var terminalDate = currentDate
                var interval: TimeInterval = 0.0
                _ = calendar.dateInterval(of: .day, start: &terminalDate, interval: &interval, for: currentDate)
                print( "terminalDate ", terminalDate )
                
                var startDate    = currentDate
                interval         = 0.0
                _ = calendar.dateInterval(of: .weekOfYear, start: &startDate, interval: &interval, for: currentDate)
                var endDate      = startDate.addingTimeInterval( SecInDay-1 )
                
                while( startDate <= terminalDate ){
                    print( startDate, endDate )
                    logData.append(LogDataTuple(periodState: periodButton.periodState, startDate: startDate, endDate:endDate, pedometerData: nil))
                    startDate = startDate.addingTimeInterval( SecInDay )
                    endDate   = endDate.addingTimeInterval( SecInDay )
                }
                for log in logData {
                    pedoMeter.queryPedometerData(from: log.startDate, to: log.endDate, withHandler: queryPedometerHandler)
                }

            case .kOneWeek :
                print( "One week" )
                let currentDate  =  Date()
                var terminalDate = currentDate
                var interval: TimeInterval = 0.0
                _ = calendar.dateInterval(of: .day, start: &terminalDate, interval: &interval, for: currentDate)
                print( "terminalDate ", terminalDate )

                var startDate = terminalDate.addingTimeInterval( -SecInDay * 8 )
                var endDate   = startDate.addingTimeInterval( SecInDay-1 )
                
                while( startDate <= terminalDate ){
                    print( startDate, endDate )
                    logData.append(LogDataTuple(periodState: periodButton.periodState, startDate: startDate, endDate:endDate, pedometerData: nil))
                    startDate = startDate.addingTimeInterval( SecInDay )
                    endDate   = endDate.addingTimeInterval( SecInDay )
                }
                for log in logData {
                    pedoMeter.queryPedometerData(from: log.startDate, to: log.endDate, withHandler: queryPedometerHandler)
                }

            default:
                print ( "What happened" )
        }
    }
}
