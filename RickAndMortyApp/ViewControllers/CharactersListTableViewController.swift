//
//  CharactersListTableViewController.swift
//  RickAndMortyApp
//
//  Created by Lera Savchenko on 25.07.23.
//

import UIKit

class CharactersListTableViewController: UITableViewController {
    
    private var listOfCharacters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfCharacters.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "characterCell",
                for: indexPath
            ) as? CharacterCell
        else {
            return UITableViewCell()
        }
        let character = listOfCharacters[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
}

//    MARK: - Networking
extension CharactersListTableViewController {
    func fetchCaracters() {
        NetworkManager.shared.fetch([Character].self, from: "https://rickandmortyapi.com/api/character") { [weak self] result in
            switch result{
            case .success(let listOfCharacters):
                self?.listOfCharacters = listOfCharacters
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
