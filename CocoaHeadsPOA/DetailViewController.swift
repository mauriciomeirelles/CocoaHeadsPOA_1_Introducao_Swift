//
//  DetailViewController.swift
//  CocoaHeadsPOA
//
//  Created by Mauricio Meirelles on 10/16/14.
//  Copyright (c) 2014 Beelieve. All rights reserved.
//

import UIKit

//=============================================================================
//Extension de Double com propriedades para cálculo das distâncias 
//   e função toStringDetail para formatar a String
//=============================================================================
extension Double {
    var km: Double { return self / 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self * 100.0 }
    var mm: Double { return self * 1_000.0 }
    var ft: Double { return self * 3.28084 }
    
    func toStringDetail() -> String {
        return String(format: "%.3f",self)
    }
}

class DetailViewController: UIViewController {

    var distanceSelected = 0.00
    
    @IBOutlet weak var fldMeter: UILabel!
    @IBOutlet weak var fldKilometer: UILabel!
    @IBOutlet weak var fldCentimeter: UILabel!
    @IBOutlet weak var fldMilimeter: UILabel!
    @IBOutlet weak var fldFeet: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        fldMeter.text = distanceSelected.m.toStringDetail()
        fldKilometer.text = distanceSelected.km.toStringDetail()
        fldCentimeter.text = distanceSelected.cm.toStringDetail()
        fldMilimeter.text = distanceSelected.mm.toStringDetail()
        fldFeet.text = distanceSelected.ft.toStringDetail()
        
        
        //=============================================================================
        //Mostrar que podemos utilizar a extension com o número e String direto
        //=============================================================================
//        fldMeter.text = 50.0.km.toStringDetail()
        
        //=============================================================================
        //Mostrar que podemos utilizar a extension da classe anterior
        //  ou seja, extension funciona em todo o namespace
        //=============================================================================
//        fldKilometer.text = 100.0.km.toString()

    
    }

}
