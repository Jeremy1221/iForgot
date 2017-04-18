//
//  MapViewController.swift
//  iForgot
//
//  Created by Jeremy on 4/17/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var isFirst = true
//    var annotation = MKPointAnnotation()
//    var annotationView = MKPinAnnotationView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false        
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mapView.visibleMapRect
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.mapView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if isFirst {
            mapView.setCenter(mapView.userLocation.coordinate, animated: true)
            mapView.region = MKCoordinateRegion.init(center: mapView.userLocation.coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.001))
        }
        isFirst = false
        
//        mapView.showsUserLocation = false
//        let annomaiton = MKPointAnnotation.init()
//        annomaiton.coordinate = mapView.userLocation.coordinate
//        annomaiton.title = "title"
//        annomaiton.subtitle = "subtitle"
//        mapView.addAnnotation(annomaiton)
//        
//        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
//        mapView.region = MKCoordinateRegion.init(center: mapView.userLocation.coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.001))
    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        print("select")
//    }
//    
//    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//        print("deselect")
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        return MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "userlocationview")
        if annotation.isKind(of: MKUserLocation.self) {
            return nil//MKAnnotationView.init(annotation: annotation, reuseIdentifier: "userlocationview")
        } else {
//            annotationView.annotation = annotation
            var annotationView = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "annotationView")
            annotationView.canShowCallout = true
//            print(annotation.title)
//            print(annotation.subtitle)
//            print(annotation.coordinate)
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("calloutAccessoryControlTapped")
    }
    
    func geocodeLocation(location: CLLocation, for annotation: MKAnnotation?) -> (String, String)? {
        var geocoder = CLGeocoder()
        var city = ""
        var street = ""
        geocoder.reverseGeocodeLocation(location) { (placeMarks, error) in
            if (error != nil) {
                print(error)
            } else {
//                print("\(placeMarks?.first?.country)---\(placeMarks?.first?.areasOfInterest)---\(placeMarks?.first?.name)")
//                print(placeMarks?.first?.subLocality)
//                print(placeMarks?.first?.name)
//                print(placeMarks?.first?.addressDictionary)
                city = (placeMarks?.first?.name)!
                street = (placeMarks?.first?.subLocality)!
            }
        }
        
        return (city, street) as! (String, String)
        geocoder.geocodeAddressString("") { (placeMarks, error) in
//            CLPlacemark
        }
    }
    
    func handleTap(tap: UITapGestureRecognizer) {
        let point = tap.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        mapView.removeAnnotations(mapView.annotations)
        var annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
//        let tuples = geocodeLocation(location: CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude), for: nil)
        let location =
        CLGeocoder().reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)) { (placeMarks, error) in
            if (error != nil) {
                print(error)
            } else {
                //                print("\(placeMarks?.first?.country)---\(placeMarks?.first?.areasOfInterest)---\(placeMarks?.first?.name)")
                //                print(placeMarks?.first?.subLocality)
                //                print(placeMarks?.first?.name)
                //                print(placeMarks?.first?.addressDictionary)
                annotation.title = placeMarks?.first?.name
                annotation.subtitle = placeMarks?.first?.subLocality
//                print(annotation.title)
//                print(annotation.subtitle)
            }
        }
//        annotation.title = tuples?.0
//        annotation.subtitle = tuples?.1
//        print(tuples)
        mapView.addAnnotation(annotation)
//        self.mapView.selectAnnotation(annotation, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
