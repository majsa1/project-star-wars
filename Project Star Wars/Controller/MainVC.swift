//
//  MainVC.swift
//  Project Star Wars
//
//  Created by Marjo Salo on 16/11/2020.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var characterTable: UITableView!
    
    var person: Person!
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterTable.delegate = self
        characterTable.dataSource = self
        
        getPeople()
    }
    
    func getPeople() {
        NetworkService.shared.getPeople { person in
            self.person = person
            self.people.append(person)
            self.people.sort {
                $0.name < $1.name
            }
            self.characterTable.reloadData()
            
        } onError: { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as? CharacterCell {
            cell.updatePeople(person: people[indexPath.row])
            return cell
            
        }
        return UITableViewCell()
    }
        
    func tableView(_tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetailsVC", sender: people[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsVC {
            let barBtn = UIBarButtonItem()
            barBtn.title = ""
            navigationItem.backBarButtonItem = barBtn
            detailsVC.person = (sender as! Person)
         }
     }

}
