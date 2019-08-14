//
//  ToevoegenViewController.swift
//  Werkstuk1Augustus
//
//  Created by Fady Elabed on 13/08/2019.
//  Copyright © 2019 Fady Elabed. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ToevoegenViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate  {

    @IBOutlet weak var txtVoornaam: UITextField!
    @IBOutlet weak var txtAchternaam: UITextField!
    @IBOutlet weak var txtStraat: UITextField!
    @IBOutlet weak var txtHuisnummer: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    @IBOutlet weak var txtGemeente: UITextField!
    @IBOutlet weak var txtTelefoonnummer: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var geocoder = CLGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtVoornaam.delegate = self
        txtAchternaam.delegate = self
        txtStraat.delegate = self
        txtHuisnummer.delegate = self
        txtPostcode.delegate = self
        txtGemeente.delegate = self
        txtTelefoonnummer.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    @IBAction func onClick(_ sender: Any) {
        
        let address = txtStraat.text! + " " + txtHuisnummer.text! + ", " + txtPostcode.text! + " " + txtGemeente.text!
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in
            
            let placemark = placemarks?.first
            
            let lat = (placemark?.location?.coordinate.latitude)!
            let lon = (placemark?.location?.coordinate.longitude)!
            
            self.toevoegen(lat: lat, lon: lon)
            
        })
        
    }
    
    func toevoegen(lat: Double, lon: Double) -> Void {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newpersoon = NSEntityDescription.insertNewObject(forEntityName: "Persoon", into: managedContext) as! Persoon
        
        newpersoon.voornaam = txtVoornaam.text!
        newpersoon.naam = txtAchternaam.text!
        newpersoon.foto = "profiel"
        newpersoon.straat = txtStraat.text!
        newpersoon.huisnummer = txtHuisnummer.text!
        newpersoon.postcode = txtPostcode.text!
        newpersoon.gemeente = txtGemeente.text!
        newpersoon.telefoonnummer = txtTelefoonnummer.text!
        newpersoon.coordinaat1 =  lat
        newpersoon.coordinaat2 = lon
        
        
        func createAlert() {
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            
            alert.view.tintColor = UIColor.black
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline:.now() + 2.0, execute: {
                self.performSegue(withIdentifier:"naarTable",sender: self)
                self.dismiss(animated: false, completion: nil)
            })
        }
        
        
        do{
            try managedContext.save()
        } catch{
            fatalError("Failure tosave context: \(error)")
        }
        
        if(lat != 0 && lon != 0){
            createAlert()
        } else {
            let alert = UIAlertView()
            alert.title = "Verkeerd adres"
            alert.message = "Controleer het adres opnieuw"
            alert.addButton(withTitle: "Oké")
            alert.show()
        }
        
        

        
        
        
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
