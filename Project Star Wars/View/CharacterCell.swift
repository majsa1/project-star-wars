//
//  CharacterCell.swift
//  Project Star Wars
//
//  Created by Marjo Salo on 16/11/2020.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var characterLbl: UILabel!

    func updatePeople(person: Person) {
        characterLbl.text = person.name
    }
}
