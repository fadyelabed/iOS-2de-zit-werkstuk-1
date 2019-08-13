//
//  TableViewController.swift
//  Werkstuk1Augustus
//
//  Created by Fady Elabed on 09/08/2019.
//  Copyright © 2019 Fady Elabed. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var personen = [Persoon]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let p1 = Persoon(voornaam: "rob", naam: "verstegen", foto: "rob", straat: "Meirstraat 24", huisnummer:"12", postcode:"5000", gemeente:"Anderlecht", telefoonnummer: "0488.870.452", coordinaat1:51.219448, coordinaat2:4.402464)
        personen.append(p1)
        
        let p2 = Persoon(voornaam: "link", naam: "verstegen", foto: "link", straat: "Meirstraat 24", huisnummer:"12", postcode:"5000", gemeente:"Anderlecht", telefoonnummer: "0488.870.452", coordinaat1:51.219448, coordinaat2:4.402464)
        personen.append(p2)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personen.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = personen[indexPath.row].voornaam.capitalized
        cell.detailTextLabel?.text = personen[indexPath.row].naam.capitalized
        cell.imageView?.image = UIImage(named: personen[indexPath.row].foto)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let vc = segue.destination as! DetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            vc.persoon = personen[(indexPath?.row)!]
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   


}
