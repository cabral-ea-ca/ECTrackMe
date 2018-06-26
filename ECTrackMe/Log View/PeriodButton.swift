//
//  PeriodButton.swift
//  ECTrackMe
//
//  Created by Ryerson Student on 2018-06-23.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit

class PeriodButton: UIBarButtonItem {
    enum  ePeriodState : Int {
        case kUnknown = -1
        case kToday  = 0
        case kLastTwoDays = 1
        case kThisWeek  = 2
        case kOneWeek = 3
    }
    var periodState:ePeriodState = .kUnknown ;
    internal var periodStringTable = [
        "Today" ,
        "Last 2 Days" ,
        "This Week" ,
        "One Week" ,
        ]
    
    override func awakeFromNib(){
        super.awakeFromNib()
        periodState = .kToday
        self.title = periodStringTable[periodState.rawValue]
    }
    
    func switchState(){
        let OldValue = periodState
        switch periodState {
        case .kUnknown:
            print( "What happened???" )
    
        case .kToday:
            periodState = .kLastTwoDays
            
        case .kLastTwoDays:
            periodState = .kThisWeek
            
        case .kThisWeek:
            periodState = .kOneWeek
            
        case .kOneWeek:
            periodState = .kToday
        }

        print( "PeriodButton: switchState called \(OldValue) -> \(periodState)" )
        self.title = periodStringTable[periodState.rawValue]
    }
}
