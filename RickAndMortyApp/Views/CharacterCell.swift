//
//  CharacterCellTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Lera Savchenko on 26.07.23.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterImage: UIImageView!
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        
        NetworkManager.shared.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        }
    }



