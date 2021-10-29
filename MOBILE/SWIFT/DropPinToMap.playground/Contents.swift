import UIKit
import MapKit

class TravelLocationMapVC: UIViewController, MKMapViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        mapView.isUserInteractionEnabled = true
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longTap(gesture: )))
        mapView.addGestureRecognizer(gestureRecognizer)
   
    }
    
    @objc func longTap(gesture: UILongPressGestureRecognizer ){
        //as soon as  long press is ended
        if gesture.state == .ended{
            //get coordinates and create the pin
            let location = gesture.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
        }
    }
    
}

