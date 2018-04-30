import UIKit

class ViewController: UIViewController {
    let network = AppDelegate.shared().network
    override func viewDidLoad() {
        super.viewDidLoad()
        network.performRequest(method: HTTPMethod.get, endpoint: .categoryInfo) { (info: CategoryInfo?, error) in
            print(info)
            print(error)
        }
    }
}
