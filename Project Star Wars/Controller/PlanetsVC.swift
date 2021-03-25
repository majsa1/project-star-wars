//
//  PlanetsVC.swift
//  Project Star Wars
//
//  Created by Marjo Salo on 19/11/2020.
//

import UIKit

class PlanetsVC: UITableViewController {

    @IBOutlet var planetsTable: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var rotationPeriodLbl: UILabel!
    @IBOutlet weak var orbitalPeriodLbl: UILabel!
    @IBOutlet weak var diameterLbl: UILabel!
    @IBOutlet weak var climateLbl: UILabel!
    @IBOutlet weak var gravityLbl: UILabel!
    @IBOutlet weak var terrainLbl: UILabel!
    @IBOutlet weak var surfaceWaterLbl: UILabel!
    @IBOutlet weak var populationLbl: UILabel!
    
    var planet: Planet!
    var url: String!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlanet()
    }
 
    func getPlanet() {

        NetworkService.shared.getPlanet(url: url) { planet in
            self.planet = planet
            self.nameLbl.text = self.planet.name
            self.rotationPeriodLbl.text = self.planet.rotation_period
            self.orbitalPeriodLbl.text = self.planet.orbital_period
            self.diameterLbl.text = self.planet.diameter
            self.climateLbl.text = self.planet.climate
            self.gravityLbl.text = self.planet.gravity
            self.terrainLbl.text = self.planet.terrain
            self.surfaceWaterLbl.text = self.planet.surface_water
            self.populationLbl.text = self.planet.population
            
        } onError: { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
        
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
