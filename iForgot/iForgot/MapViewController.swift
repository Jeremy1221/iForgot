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
    var annotation = MKPointAnnotation()
    
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
            annotation.coordinate = mapView.userLocation.coordinate
            mapView.addAnnotation(annotation)
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("select")
        mapView.selectedAnnotations = [annotation]
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        mapView.selectedAnnotations = [annotation]
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            self.annotation.title = annotation.title!
            self.annotation.subtitle = annotation.subtitle!
            return nil              //MKAnnotationView.init(annotation: annotation, reuseIdentifier: "userlocationview")
        } else {
            var annotationView = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "annotationView")
            annotationView.canShowCallout = true
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
                city = (placeMarks?.first?.name)!
                street = (placeMarks?.first?.subLocality)!
            }
        }
        
        return (city, street) as! (String, String)
        geocoder.geocodeAddressString("") { (placeMarks, error) in
            
        }
    }
    
    func handleTap(tap: UITapGestureRecognizer) {
        let point = tap.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        annotation.coordinate = coordinate
        
        let location =
        CLGeocoder().reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)) { (placeMarks, error) in
            if (error != nil) {
                print(error)
            } else {
//                print("\(placeMarks?.first?.country)---\(placeMarks?.first?.areasOfInterest)---\(placeMarks?.first?.name)")
//                print(placeMarks?.first?.subLocality)
//                print(placeMarks?.first?.name)
//                print(placeMarks?.first?.addressDictionary)
                self.annotation.title = placeMarks?.first?.name
                self.annotation.subtitle = placeMarks?.first?.subLocality
            }
        }
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
