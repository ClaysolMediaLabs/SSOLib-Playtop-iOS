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

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data to encrypt
        let info = ["company_name": "Claysol",
                    "company_address": "Bangalore"]
        
        // Create Json using data
        guard let jsonStr = info.convertToJSONString else { return  }
        // Define key. key length should be 32
        let key128 = "12345678901234567890123456789012"
        do {
            // Initialize sso library
            let aes = try ClaysolSSO(keyString: key128)
            //encrypt data
            if  let encryptedData = try aes.encrypt(jsonStr) {
                //decrypt data
                let decryptedData = try aes.decrypt(encryptedData)
                print("decryptedData: \(decryptedData)")
            }
        } catch {
            //Handle errors
            print("Something went wrong: \(error)")
        }
    }
}
// MARK: - Json Helper
extension Encodable {
    var convertToJSONString: String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

```
