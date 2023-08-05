//
//  CharacterDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Lera Savchenko on 5.08.23.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

//    MARK: - IBOutlets
    @IBOutlet weak var characterImage: UIImageView!{
        didSet {
            characterImage.layer.cornerRadius = characterImage.frame.height / 2
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    
//    MARK: - Public properties
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        title = character.name
        descriptionLabel.text = character.description
        NetworkManager.shared.fetchImage(from: self.character.image) { result in
            switch result {
            case .success(let imageData):
                self.characterImage.image = UIImage(data: imageData)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    

    
}
