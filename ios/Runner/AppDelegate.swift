import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
      [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
	GMSServices.provideAPIKey("AIzaSyCw2qxTQ1fTGIgP3dUs4bm9SR5Y9S-2CUY")
    GeneratedPluginRegistrant.register(with: self)
    return true
  }
}