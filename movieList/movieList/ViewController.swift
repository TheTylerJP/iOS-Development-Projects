//
//  ViewController.swift
//  movieList
//
//  Created by Tommy Bojanin on 2/19/18.
//  Copyright © 2018 Tommy Bojanin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var movieNames = ["Black Panther", "Logan", "The Shape of Water", "Dunkirk", "Star Wars: The Last Jedi", "Get Out", "Wonder Woman", "Blade Runner 2049", "Baby Driver", "The Post"]
    var movieImages = [#imageLiteral(resourceName: "blackPanther"), #imageLiteral(resourceName: "logan"), #imageLiteral(resourceName: "theShapeOfWater"), #imageLiteral(resourceName: "dunkirk"), #imageLiteral(resourceName: "starWars"),#imageLiteral(resourceName: "getOut"),#imageLiteral(resourceName: "wonderWoman"),#imageLiteral(resourceName: "bladeRunner"),#imageLiteral(resourceName: "babyDriver"),#imageLiteral(resourceName: "thePost")]
    let year = "2017"
    
    @IBOutlet weak var movieTable: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTable.delegate = self
        movieTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = movieTable.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell
        cell?.movieReleaseYear.text = "Release year: " + year
        cell?.movieTitle?.text = movieNames[indexPath.row].capitalized
        cell?.movieImageSmall.image = movieImages[indexPath.row]
        cell?.movieTitle.numberOfLines = 0
        
        cell?.movieReleaseYear.sizeToFit()
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMovieInformation" {
            let destination = segue.destination as? MovieInformationViewController
            
            destination?.index = (movieTable.indexPathForSelectedRow?.row)!
        }
    }
    

    

    


}

