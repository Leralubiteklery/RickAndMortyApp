//
//  CharactersListTableViewController.swift
//  RickAndMortyApp
//
//  Created by Lera Savchenko on 25.07.23.
//

import UIKit

class CharactersListTableViewController: UITableViewController {
    //    MARK: - Private Properties
    private var listOfCharacters: ListOfCharacters?
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCharacters: [Character] = []
    private var searchBarIsEmprty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmprty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        tableView.backgroundColor = .black
        fetchData(from: Link.rickAndMortyAPI.rawValue)
        
        setupSearchController()
        setupNavigationBar()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredCharacters.count : listOfCharacters?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "characterCell",
                for: indexPath
            ) as? CharacterCell else {
            return UITableViewCell()
        }
        let character = isFiltering
        ? filteredCharacters[indexPath.row]
        : listOfCharacters?.results[indexPath.row]
        cell.configure(with: character)
        return cell
    }
//    MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = isFiltering
        ? filteredCharacters[indexPath.row]
        : listOfCharacters?.results[indexPath.row]
        guard let detailVC = segue.destination as? CharacterDetailsViewController else { return }
        detailVC.character = character
    }
    
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        sender.tag == 1
        ? fetchData(from: listOfCharacters?.info.next)
        : fetchData(from: listOfCharacters?.info.prev)
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
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    private func setupNavigationBar() {
        title = "Rick & Morty"
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .black
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}

// MARK: - UISearchResultsUpdating
extension CharactersListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCharacters = listOfCharacters?.results.filter({ character in
            character.name.lowercased().contains(searchText.lowercased())
        }) ?? []
        
        tableView.reloadData()
    }
    
}

