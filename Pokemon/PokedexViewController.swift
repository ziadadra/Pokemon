//
//  PokedexViewController.swift
//  Pokemon
//
//  Created by ziad adra on 1/30/17.
//  Copyright © 2017 ziad adra. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
     var caughtPokemons : [Pokemon] = []
     var uncaughtPokemons : [Pokemon] = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
         caughtPokemons = getAllcaughtPokemons()
        uncaughtPokemons = getalluncaughtPokemons()
        

        // Do any additional setup after loading the view.
       tableView.dataSource = self
        tableView.delegate = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
    }
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "CAUGHT"
            
        } else {
            return "UNCAUGHT"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return caughtPokemons.count
            
        } else {
            return uncaughtPokemons.count
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let pokemon : Pokemon
        if indexPath.section == 0 {
            
           
              pokemon = caughtPokemons[indexPath.row]
        } else {
                pokemon = uncaughtPokemons[indexPath.row]
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = pokemon.name
        cell.imageView?.image = UIImage(named: pokemon.imageName!)
        
        return cell
        
    }
    @IBAction func mapTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   

}
