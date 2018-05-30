//
//  ViewController.swift
//  Pokemon List
//
//  Created by Tommy Bojanin on 2/13/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var pokemonTable: UITableView!
    let pokemon = ["Pikachu", "Charmander", "squirtle", "ash"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTable.dequeueReusableCell(withIdentifier: "pokemonCell")
        cell?.pokemonCell?.text = pokemon[indexPath.row] as? PokemonTableViewCell
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "individualPokemon" {
            let destination = segue.destination as? IndividualPokemonViewController
            destination?.pokemonName = (pokemonTable.indexPathsForSelectedRow?.row)!
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pokemonTable.delegate = self
        pokemonTable.dataSource = self
        
        print(pokemon[1])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

