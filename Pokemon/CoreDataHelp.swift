//
//  CoreDataHelp.swift
//  Pokemon
//
//  Created by ziad adra on 1/29/17.
//  Copyright © 2017 ziad adra. All rights reserved.
//

import UIKit
import CoreData


func addAllPokemon() {
    //get the context
    //    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //    let pokemon = Pokemon(context: context)
    //    pokemon.name = "Mew"
    //    pokemon.imageName = "mew"
    createPokemon(name: "Mew", imageName: "mew")
    createPokemon(name: "Meowth", imageName: "meowth")
    createPokemon(name: "Zubat", imageName: "zubat")
    createPokemon(name: "Abra", imageName: "abra")
    createPokemon(name: "Pikachu", imageName: "pikachu")
    createPokemon(name: "Rattata", imageName: "rattata")
    createPokemon(name: "Squirtle", imageName: "squirtle")
    createPokemon(name: "Snorlax", imageName: "snorlax")
    createPokemon(name: "Smartphone", imageName: "smartphone")
    createPokemon(name: "Eevee", imageName: "eevee")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    
}

func createPokemon(name :String, imageName :String) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let pokemon = Pokemon(context: context)
    pokemon.name = name
    pokemon.imageName = imageName
    
    
}
func getAllpokemon() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
    let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
    
        if pokemons.count == 0 {
            addAllPokemon()
            return getAllpokemon()
        }
        return pokemons
    } catch {
        
    }
    
    return []
    
}
func getAllcaughtPokemons() -> [Pokemon] {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "caught == %=", true as CVarArg)
    do {
     let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        
        return pokemons
        
        
    } catch {}
    return []
    
    
}
func getalluncaughtPokemons() -> [Pokemon]{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    fetchRequest.predicate = NSPredicate(format: "caught == %=", false as CVarArg)
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        
        return pokemons
        
        
    } catch {}
    return []
    
}

