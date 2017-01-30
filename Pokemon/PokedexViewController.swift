//
//  PokedexViewController.swift
//  Pokemon
//
//  Created by ziad adra on 1/30/17.
//  Copyright © 2017 ziad adra. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func mapTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   

}
