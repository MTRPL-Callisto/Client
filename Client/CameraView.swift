import AVFoundation
import Foundation
import UIKit

final class CameraView: UIView {
    private let videoDataOutputQueue: DispatchQueue = DispatchQueue(label: "CallistoVideoOutputQueue")
    private let captureDevice: AVCaptureDevice? = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    var captureImageHandler: CaptureImageHandler?
    private var shouldCaptureImage: Bool = false
    typealias CaptureImageHandler = (UIImage) -> Void

    lazy var session: AVCaptureSession = {
        let s = AVCaptureSession()
        s.sessionPreset = .vga640x480
        return s
    }()

    private lazy var videoDataOutput: AVCaptureVideoDataOutput = {
        let v = AVCaptureVideoDataOutput()
        v.alwaysDiscardsLateVideoFrames = true
        v.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        v.connection(with: .video)?.isEnabled = true
        return v
    }()

    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let l = AVCaptureVideoPreviewLayer(session: session)
        l.videoGravity = .resizeAspectFill
        l.connection?.videoOrientation = .portrait
        return l
    }()

    private lazy var noCameraLabel: UILabel = {
        let l = UILabel()
        l.text = "Camera is not available"
        l.font = UIFont.systemFont(ofSize: 15)
        l.textColor = UIColor.main
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentMode = .scaleAspectFit
        addSubview(noCameraLabel)
        noCameraLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        noCameraLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        beginSession()
    }

    public func captureImage() {
        shouldCaptureImage = true
    }

    private func beginSession() {
        do {
            guard let captureDevice = captureDevice else {
                print("Camera doesn't work on the simulator! You have to test this on an actual device!")
                noCameraLabel.isHidden = false
                return
            }
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            if session.canAddInput(deviceInput) {
                session.addInput(deviceInput)
            }

            if session.canAddOutput(videoDataOutput) {
                session.addOutput(videoDataOutput)
            }
            layer.masksToBounds = true
            layer.addSublayer(previewLayer)
            previewLayer.frame = bounds
            noCameraLabel.isHidden = true
            session.startRunning()
        } catch let error {
            debugPrint("\(self.self): \(#function) line: \(#line).  \(error.localizedDescription)")
        }
    }
}

extension CameraView: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        connection.videoOrientation = .portrait
        if shouldCaptureImage {
            let buffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            let ciimage = CIImage(cvPixelBuffer: buffer!)
            let iamge = UIImage(ciImage: ciimage, scale: 1, orientation: .down) // I have no idea why it's rotated 90CW
            shouldCaptureImage = false
            DispatchQueue.main.async {
                self.captureImageHandler?(iamge)
            }
        }
    }
}
