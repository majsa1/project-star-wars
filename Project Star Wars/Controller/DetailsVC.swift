//
//  DetailsVC.swift
//  Project Star Wars
//
//  Created by Marjo Salo on 17/11/2020.
//

import UIKit

class DetailsVC: UITableViewController {
    
    @IBOutlet var detailsTable: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var massLbl: UILabel!
    @IBOutlet weak var hairColorLbl: UILabel!
    @IBOutlet weak var skinColorLbl: UILabel!
    @IBOutlet weak var eyeColorLbl: UILabel!
    @IBOutlet weak var yearOfBirthLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var homeworldLbl: UILabel!
    
    var person: Person!
    var planet: Planet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = person.name
        heightLbl.text = "\(person.height) cm"
        massLbl.text = "\(person.mass) kg"
        hairColorLbl.text = person.hair_color
        skinColorLbl.text = person.skin_color
        eyeColorLbl.text = person.eye_color
        yearOfBirthLbl.text = person.birth_year
        genderLbl.text = person.gender
        getPlanetName()
    }
    
    func getPlanetName() {
        let url = "\(person.homeworld)"
        
        NetworkService.shared.getPlanet(url: url) { planet in
            self.planet = planet
            self.homeworldLbl.text = planet.name

        } onError: { errorMessage in
            debugPrint(errorMessage)
        }
    }
    
    func tableView(_tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPlanetsVC", sender: planet)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let planetsVC = segue.destination as? PlanetsVC {
            planetsVC.url = person.homeworld
        }
    }
}
    
    


    
