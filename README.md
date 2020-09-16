# SSOLibClaysol

## Installation

## CocoaPods

CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate SSOLibClaysol into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SSOLibClaysol'
end
```

## Usage
```swift
 import SSOLibClaysol
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let scheme = url.scheme,
            scheme.localizedCaseInsensitiveCompare("com.ssoSampleApp") == .orderedSame {
            var parameters = [String: String]()
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            //Key will be different for each cp.
            let key128 = "MTIzRTREQzk4RjI1NTc1OEIxMDZGMkEyNTBBRDQ0QkI="
            do {
                let aes = try ClaysolSSO(keyString: key128)
                if let userInfo = parameters["data"] {
                    let decryptedData = try aes.decrypt(userInfo)
                    // In case if decryptedData come nil please check private key provided by Claysol.
                    let alertController = UIAlertController(title: nil, message: decryptedData, preferredStyle:UIAlertController.Style.alert)

                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                     { action -> Void in
                       // Put your code here
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

```
