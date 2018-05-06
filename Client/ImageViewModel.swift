import CoreLocation
import MapKit
import UIKit

class ImageViewModel {
    var capturedImage: UIImage? {
        didSet {
            guard let image = capturedImage else { return }
            MLWrapper.process(image: image.cgImage!) { (category, confidence) in
                debugPrint("Category: \(category), confidence: (confidence)")
            }
        }
    }
    var categoryName: String = "Plastic resin codes"
    var categoryDescription: String = "This identifies the type of plastic resin used to make the item by providing a 'Resin Identification Code'. It is represented with a 'chasing arrows' symbol surrounding a a number between 1 and 7 that defines the resin used."
    var recylingCenterName: String = "Helsinki Metropolitan Area Reuse Centre"

    func openMapAction() {
        let latitude: CLLocationDegrees = 60.2198613
        let longitude: CLLocationDegrees = 24.664098100000047

        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = recylingCenterName
        mapItem.openInMaps(launchOptions: options)
    }
}
