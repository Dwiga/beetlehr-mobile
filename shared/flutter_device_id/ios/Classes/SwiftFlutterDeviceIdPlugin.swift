import Flutter
import UIKit

public class SwiftFlutterDeviceIdPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "id.flutter/flutter_device_id", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterDeviceIdPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "getDeviceId"){
        result(UIDevice.current.identifierForVendor?.uuidString)
    }
  }
}
