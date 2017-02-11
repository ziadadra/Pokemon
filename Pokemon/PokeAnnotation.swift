//
//  PokeAnnotation.swift
//  Pokemon
//
//  Created by ziad adra on 2/11/17.
//  Copyright © 2017 ziad adra. All rights reserved.
//

import UIKit
import MapKit

class PokeAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coord: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coord
        self.pokemon = pokemon
        
    }
    
}
