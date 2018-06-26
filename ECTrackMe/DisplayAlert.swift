//
//  DisplayAlert.swift
//  ECTrackMe
//
//  Created by Ryerson Student on 2018-06-21.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit

class DisplayAlert {
    internal func openURL( urlStr: URL){
        if #available(iOS 10.0, *){
            DispatchQueue.main.async {
                UIApplication.shared.open(urlStr, options: [:], completionHandler: nil )
            }
        }
        else{
            DispatchQueue.main.async {
                UIApplication.shared.openURL(urlStr)
            }
        }
    }
    
    func settingMotionHandler(alert: UIAlertAction!) {
        print( "DisplayAlert: settingMotionHandler called" )
        let urlStr = URL( string: "App-Prefs:root=Privacy&path=MOTION" )
        openURL(urlStr: urlStr!)
        justClose(alert: alert)
    }
    
    func justClose(alert: UIAlertAction!){
        print( "DisplayAlert: justClose called" )
        AppDelegate.displayAlert = nil
    }
    
    public func showAlertMotion( title:String, message:String, viewController : UIViewController){
        print( "DisplayAlert: showAlertMotion called" )
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Setting action"), style: .cancel, handler: settingMotionHandler))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default"), style: .default, handler: justClose ))
        viewController.present(alertController, animated: true, completion: nil)
    }
}

