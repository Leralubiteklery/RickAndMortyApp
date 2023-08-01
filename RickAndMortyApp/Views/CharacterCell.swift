//
//  CharacterCellTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Lera Savchenko on 26.07.23.
//

import UIKit

class CharacterCell: UITableViewCell {
    
//    MARK: - IBOutlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterImage: UIImageView! {
        didSet {
            characterImage.contentMode = .scaleAspectFit
            characterImage.clipsToBounds = true
            characterImage.layer.cornerRadius = characterImage.frame.height / 2
            characterImage.backgroundColor = .white
        }
    }
    
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



