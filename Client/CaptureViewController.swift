import AVFoundation
import UIKit

class CaptureViewController: UIViewController {
    @IBOutlet private var livePreviewView: CameraView!
    @IBOutlet private var cameraShutterButton: UIButton!
    private let imageViewModel = ImageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = appName
        livePreviewView.captureImageHandler = { image in
            self.imageViewModel.capturedImage = image
            self.navigationController?.pushViewController(ResultViewController(viewModel: self.imageViewModel), animated: true)
        }
    }

    @IBAction func cameraShutterButtonPressed(_: UIButton) {
        livePreviewView.captureImage()
    }
}
