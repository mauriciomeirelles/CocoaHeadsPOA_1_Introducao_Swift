//
//  ViewController.swift
//  CocoaHeadsPOA
//
//  Created by Mauricio Meirelles on 10/16/14.
//  Copyright (c) 2014 Beelieve. All rights reserved.
//

import UIKit

//=============================================================================
//Extension de String para converter para Double pois não tem uma função nativa
//  toInt() existe, mas toDouble() não
//=============================================================================
extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)!.doubleValue
    }
}

//=======================================================================================
//Extension de Double para converter para String sem precisar fazer a formatação sempre
//=======================================================================================
extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //==================================================
    // Arrays Tipados, no ObjC todos Arrays eram de id
    //==================================================
    private var distances = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distances.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        
        cell.textLabel!.text = distances[indexPath.row].toString() + " m"

    
        return cell
        
        

        
    }
    

    
    @IBAction func addDistance(sender: AnyObject) {
        
        //==================================================
        // AlertController substitui AlertViewController
        ///  que está deprecated no iOS 8
        //==================================================
        let alertController = UIAlertController(title: "Add", message: "Type new distance in meters", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        

        let saveAction = UIAlertAction(title: "Save", style: .Default) { (_) in
            let numberTextfield = alertController.textFields![0] as UITextField

            if numberTextfield.text.utf16Count > 0
            {

                let doubleAux = numberTextfield.text.toDouble()

                //==================================================
                // Built-in Function do Swift, não tem mais funções
                ///  de classe no Array como tinhamos no ObjC
                //==================================================
                if contains(self.distances, doubleAux!)
                {
                    let alertControllerError = UIAlertController(title:"Error", message:"Already exists", preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertControllerError.addAction(defaultAction)
                    
                    self.presentViewController(alertControllerError, animated: true, completion: nil)
                }
                else
                {
                    self.distances.append(doubleAux!)
                    self.tableView.reloadData()
                }
            }
            else
            {
                let alertControllerError = UIAlertController(title:"Error", message:"Invalid number", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertControllerError.addAction(defaultAction)
                
                self.presentViewController(alertControllerError, animated: true, completion: nil)
            }
            
        }
        alertController.addAction(saveAction)
        
        alertController.addTextFieldWithConfigurationHandler(nil)

        presentViewController(alertController, animated: true, completion: nil)

        

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    
        //==================================================
        // SEMPRE que possível utiliar let pois é mais
        //    seguro e o compilador poderá otimizar o app
        //==================================================
        let cell = sender as UITableViewCell
        let idxPath = tableView.indexPathForCell(cell)
        
        let detailVC = segue.destinationViewController as DetailViewController
        detailVC.distanceSelected = distances[idxPath!.row]
    }


}

