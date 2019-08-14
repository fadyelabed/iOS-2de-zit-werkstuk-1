//
//  MapViewController.swift
//  Werkstuk1Augustus
//
//  Created by Fady Elabed on 14/08/2019.
//  Copyright © 2019 Fady Elabed. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var MapView: MKMapView!
    
    var personen = [Persoon]()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let p1 = Persoon(voornaam: "rob", naam: "verstegen", foto: "rob", straat: "Meirstraat 24", huisnummer:"12", postcode:"5000", gemeente:"Anderlecht", telefoonnummer: "0448.610.452", coordinaat1:50.853357, coordinaat2: 4.318507)
        personen.append(p1)
        
        let p2 = Persoon(voornaam: "link", naam: "legend", foto: "link", straat: "hyrule 84", huisnummer:"5", postcode:"1240", gemeente:"Koekelberg", telefoonnummer: "0421.870.312", coordinaat1:50.862838, coordinaat2:4.331124)
        personen.append(p2)
        
        writeAnnotation()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    func writeAnnotation(){
        for persoon in personen {
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: persoon.coordinaat1, longitude: persoon.coordinaat2)
            annotation.title = persoon.huisnummer.capitalized
            
            self.MapView.addAnnotation(annotation)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
