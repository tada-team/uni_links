import Flutter
import UIKit

public class SwiftUniLinksPlugin: NSObject, FlutterPlugin {
  fileprivate var methodChannel: FlutterMethodChannel
  fileprivate var initialLink: String?
  fileprivate var latestLink: String?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(name: "uni_links/messages", binaryMessenger: registrar.messenger())

    let instance = SwiftUniLinksPlugin(methodChannel: methodChannel)

    registrar.addMethodCallDelegate(instance, channel: methodChannel)
    registrar.addApplicationDelegate(instance)
  }

  init(methodChannel: FlutterMethodChannel) {
    self.methodChannel = methodChannel
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "getInitialLink":
        result(initialLink)
        break
      case "getLatestAppLink":
        result(latestLink)
        break      
      default:
        result(FlutterMethodNotImplemented)
        break
    }
  }

  // Universal Links
  // public func application(
  //   _ application: UIApplication,
  //   continue userActivity: NSUserActivity,
  //   restorationHandler: @escaping ([Any]) -> Void) -> Bool {

  //   switch userActivity.activityType {
  //     case NSUserActivityTypeBrowsingWeb:
  //       guard let url = userActivity.webpageURL else {
  //         return false
  //       }
  //       handleLink(url: url)
  //       return true
  //     default: return false
  //   }
  // }

  // Custom URL schemes
  // public func application(
  //   _ application: UIApplication,
  //   open url: URL,
  //   options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    
  //   handleLink(url: url)
  //   return true
  // }

  fileprivate func handleLink(url: URL) -> Void {
    debugPrint("iOS handleLink: \(url.absoluteString)")

    if (initialLink == nil) {
      initialLink = url.absoluteString
    }

    latestLink = url.absoluteString

    methodChannel.invokeMethod("onAppLink", arguments: latestLink)
  }
}
