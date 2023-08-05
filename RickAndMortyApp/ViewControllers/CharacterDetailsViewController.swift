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
    
    var character: Character!
    
    private var spinnerView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        showSpinner(in: view)
        title = character.name
        descriptionLabel.text = character.description
        NetworkManager.shared.fetchImage(from: self.character.image) { result in
            switch result {
            case .success(let imageData):
                self.characterImage.image = UIImage(data: imageData)
                self.spinnerView.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController else { return }
        guard let episodesVC = navigationController.topViewController as? EpisodesViewController else { return }
        episodesVC.character = character
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .white
        spinnerView.center = characterImage.center
        spinnerView.hidesWhenStopped = true
        
        view.addSubview(spinnerView)
    }

    
}
