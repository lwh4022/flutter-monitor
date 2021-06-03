import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    
    let PLATFORM_CHANNEL = FlutterMethodChannel.init(name: "ift-engine-call", binaryMessenger: controller.binaryMessenger);
    
    PLATFORM_CHANNEL.setMethodCallHandler{
        [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        
        guard call.method == "startEngine" else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        var inJson = "";
        if call.arguments != nil {
            inJson = call.arguments as! String
        }
        
        let outJson = self?.startEngine(inJson: inJson)
        
        result(outJson)
        
        };
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
    private func startEngine(inJson :String) -> String {
        return inJson + "test" + "outJson이 출력됩니다"
    }
}

    
