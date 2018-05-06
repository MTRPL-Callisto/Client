import Foundation
import Vision

class MLWrapper {
    class func process(image: CGImage, completion: @escaping (String, VNConfidence) -> Void) {
        guard let model = try? VNCoreMLModel(for: RecyclingModel().model) else { return }
        let request = VNCoreMLRequest(model: model) { data, _ in
            guard let results = data.results as? [VNClassificationObservation] else { return }
            guard let mainResult = results.first else { return }
            completion(mainResult.identifier, mainResult.confidence)
        }
        try? VNImageRequestHandler(cgImage: image, options: [:]).perform([request])
    }
}
