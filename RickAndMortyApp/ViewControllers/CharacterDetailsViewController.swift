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
    @IBOutlet weak var descriptionImage: UILabel!
    
//    MARK: - Public properties
    var charachter: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    
}
