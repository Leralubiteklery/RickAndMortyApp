//
//  EpisodesViewController.swift
//  RickAndMortyApp
//
//  Created by Lera Savchenko on 5.08.23.
//

import UIKit

class EpisodesViewController: UITableViewController {

    var character: Character!
    var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        tableView.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 1
        )

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 32/255,
            blue: 66/255,
            alpha: 1
            )
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.barTintColor = .white
    }
    
//    MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        character.episode.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episode", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let episodeURL = character.episode[indexPath.row]
        content.textProperties.color = .white
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 18)
        NetworkManager.shared.fetch(Episode.self, from: episodeURL) { [weak self] result in
            switch result {
            case .success(let episode):
                self?.episodes.append(episode)
                content.text = episode.name
                cell.contentConfiguration = content
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        performSegue(withIdentifier: "showEpisode", sender: episode)
    }
    
//    MARK: - Naviagtion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeDetailsVC = segue.destination as? EpisodeDetailsViewController else { return }
        episodeDetailsVC.episode = sender as? Episode
    }
}
