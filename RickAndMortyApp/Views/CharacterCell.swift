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
        
        NetworkManager.shared.fetch(Character.self, from: "https://rickandmortyapi.com/api/character") { [weak self]  result in
            switch result {
            case .success(let character):
                self?.nameLabel.text = character.name
                self?.speciesLabel.text = character.species
                self?.status.text = character.status
            case .failure(let error):
                print(error)
            }
        }
    }
}


