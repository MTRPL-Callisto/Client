import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var network = Network(server: Network.Server.localhost, mock: mockNetworkData)
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

extension AppDelegate {
    public static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
