//
//  ViewController.swift
//  Pokemon
//
//  Created by ziad adra on 1/29/17.
//  Copyright © 2017 ziad adra. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var updateCount = 0
    var pokemons : [Pokemon] = []
    
    
    var manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemons = getAllpokemon()
       
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("Ready to go")
           
            setUp()
            
        } else {
            
            manager.requestWhenInUseAuthorization()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            setUp()
            
        }
    }
    
    func setUp() {
        mapView.delegate = self
        
        mapView.showsUserLocation = true
        manager.startUpdatingLocation()
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
            
            //spawn a pokemon
            if let coord = self.manager.location?.coordinate {
                //     let anno = MKPointAnnotation()
                let pokemon = self.pokemons[Int(arc4random_uniform(UInt32(self.pokemons.count)))]
                let anno = PokeAnnotation(coord: coord, pokemon: pokemon)
                //  anno.coordinate = coord
                let randoLat = (Double(arc4random_uniform(200))-100)/70000.0
                let randoLon = (Double(arc4random_uniform(200))-100)/70000.0
                
                anno.coordinate.latitude += randoLat
                anno.coordinate.longitude += randoLon
                
                
                self.mapView.addAnnotation(anno)
                
            }
        })
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annoView.image = UIImage(named: "iss1")
            var frame = annoView.frame
            
            frame.size.height=50
            frame.size.width=50
            annoView.frame = frame
            
            return annoView
        }
       //work here
        
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        let pokemon = (annotation as! PokeAnnotation).pokemon
       
        //annoView.image = UIImage(named: "messi")
        annoView.image = UIImage(named: pokemon.imageName!)
        
        var frame = annoView.frame
        
        frame.size.height=50
        frame.size.width=50
        annoView.frame = frame
        
        return annoView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if updateCount < 3 {
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 200, 200)
            mapView.setRegion(region, animated: false)
            updateCount += 1
            
            
            
        } else {
            manager.stopUpdatingLocation()
        }
        
        
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation!, animated: true)
        
         if view.annotation! is MKUserLocation {
            return
        }
       
        let region = MKCoordinateRegionMakeWithDistance((view.annotation?.coordinate)!, 200, 200)
        
        mapView.setRegion(region, animated: true)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            if let coord = self.manager.location?.coordinate {
                 let pokemon = (view.annotation as! PokeAnnotation).pokemon
                if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coord)) {
                    
                   
                    pokemon.caught = true
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    // remove annotation from the map view 
                    mapView.removeAnnotation(view.annotation!)
                    let alertVC = UIAlertController(title: "Congratulation", message: "You just caught \(pokemon.name!)", preferredStyle: .alert)
                    
                    let pokedexAction = UIAlertAction(title: "Players", style: .default, handler: {(action) in
                        self.performSegue(withIdentifier: "pedexSegue", sender: nil)
                    })
                    alertVC.addAction(pokedexAction)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertVC.addAction(okAction)
                    self.present(alertVC, animated: true, completion: nil)
                    print("can catch the player")
                    
                } else {
                    let alertVC = UIAlertController(title: "Oh No", message: "You are too far away to catch \(pokemon.name!) move closer to it", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertVC.addAction(okAction)
                    self.present(alertVC, animated: true, completion: nil)
                    print("player too far away")
                }
                
            }
        }
       
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        
        if let coord = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coord, 200, 200)
            mapView.setRegion(region, animated: true)
        }
    }
}

