//
//  ViewController.swift
//  Pokemon List
//
//  Created by Tommy Bojanin on 2/19/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var pokemon = ["pikachu", "charmander", "squirtle", "ash","articuno"]

    @IBOutlet weak var pokemonTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pokemonTable.delegate = self
        pokemonTable.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonTable.dequeueReusableCell(withIdentifier: "pokemonCell") as? pokemonTableViewCell

        
        cell?.pokemonName?.text = pokemon[indexPath.row].capitalized
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotoIndividualPokemon" {
            let destination = segue.destination as? individualPokemonViewController
            
            destination?.pokemonIndex = (pokemonTable.indexPathForSelectedRow?.row)!
        }
    }

}

