import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var network = Network(server: Network.Server.localhost, mock: mockNetworkData)
    var rootViewController: RootViewController?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        rootViewController = RootViewController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    public static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
