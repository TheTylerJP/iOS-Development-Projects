//
//  individualPokemonViewController.swift
//  Pokemon List
//
//  Created by Tommy Bojanin on 2/19/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class individualPokemonViewController: UIViewController {
    
    var pokemonIndex = 0
    
    var pokemon = ["pikachu", "charmander", "squirtle", "ash","articuno"]
    var pokemonDetailsArray = ["The little yellow one.", "The fire one", "The cute turtle one", "The kid who captures pokemon and locks them inside cages.", "The one named after me."]

    @IBOutlet weak var pokemonName: UILabel!
    
    @IBOutlet weak var pokemonDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonName.text = pokemon[pokemonIndex]
        pokemonDetails.text = pokemonDetailsArray[pokemonIndex]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
