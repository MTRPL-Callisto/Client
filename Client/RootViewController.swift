import UIKit

class RootViewController: UINavigationController {
    let captureViewController = CaptureViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        pushViewController(captureViewController, animated: false)
    }
}
