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
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        let character = listOfCharacters[indexPath.row]
        return cell
    }


    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
