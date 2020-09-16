//
//  AppDelegate.swift
//  SSOSampleApp
//
//  Created by Gajendra Rawat on 09/09/20.
//  Copyright © 2020 Gajendra Rawat. All rights reserved.
//

//
//  AppDelegate.swift
//  DeeeplinkSample
//
//  Created by Gajendra Rawat on 06/08/20.
//  Copyright © 2020 Gajendra Rawat. All rights reserved.
//

import UIKit
import SSOLibClaysol

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // change com.ssoSampleApp to your Deeplink URL scheme.
        if let scheme = url.scheme,
            scheme.localizedCaseInsensitiveCompare("com.ssoSampleApp") == .orderedSame {
            var parameters = [String: String]()
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            //Replace below key which will be provided by Claysol Media Lab.
            let key128 = "MTIzRTREQzk4RjI1NTc1OEIxMDZGMkEyNTBBRDQ0QkI="
            do {
                let aes = try ClaysolSSO(keyString: key128)
                if let userInfo = parameters["data"] {
                    let decryptedData = try aes.decrypt(userInfo)
                    //Alert controller is used to show the encrypted data
                    let alertController = UIAlertController(title: nil, message: decryptedData, preferredStyle:UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                    { action -> Void in
                    })
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            } catch {
                print("Something went wrong: \(error)")
            }
        }
        return true
    }
}






