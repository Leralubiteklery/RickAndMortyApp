//
//  CharacterCellTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Lera Savchenko on 26.07.23.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var characterImage: UIImageView!
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        status.text = character.status
//        fetchImage()
      
    }
}
