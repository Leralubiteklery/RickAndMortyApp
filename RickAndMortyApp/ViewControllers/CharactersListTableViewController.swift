//
//  CharactersListTableViewController.swift
//  RickAndMortyApp
//
//  Created by Lera Savchenko on 25.07.23.
//

import UIKit

class CharactersListTableViewController: UITableViewController {
    
    private var listOfCharacters: ListOfCharacters?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        tableView.backgroundColor = .black
        fetchData(from: Link.rickAndMortyAPI.rawValue)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfCharacters?.results.count ?? 0
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
        guard let character = listOfCharacters?.results[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: character)
        return cell
    }
    
//    MARK: - Private Methods
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetch(ListOfCharacters.self, from: url) { [weak self] result in
            switch result {
            case .success(let listOfCharacters):
                self?.listOfCharacters = listOfCharacters
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

