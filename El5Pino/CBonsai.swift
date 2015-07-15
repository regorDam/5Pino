//
//  CBonsai.swift
//  El5Pino
//
//  Created by Black Castle on 3/3/15.
//  Copyright (c) 2015 ___TAULE___. All rights reserved.
//

import Foundation
import UIKit

class CBonsai{
    
    var id: String!
    var name: String!
    var photo: UIImage?
    private var species:String!
    private var style:String?
    private var date:String?
    private var age:String?
    private var source:String?
    private var adquired:String?
    private var price:Double!
    private var pot:String!
    private var height = 0.0
    private var width = 0.0
    private var notes:String?
    
    init(id:String, name:String, species: String){
        self.id = id
        self.name = name
        self.species = species
        self.photo = UIImage(named: "bonsai.png")
    }
    
    init(name: String, species: String, price: Double, pot: String, height: Double, width: Double){
        self.name = name
        self.price = price
        self.pot = pot
        self.height = height
        self.width = width
    }
    
    init (name: String!, photo: UIImage?, species: String!, style: String?, date: String?, age: String?, source: String?, acquired: String?, price: Double!, pot: String!, height: Double!, width: Double!){
        
        self.name = name
        self.photo = photo
        self.species = species
        self.style = style
        self.date = date
        self.age = age
        self.source = source
        self.adquired = acquired
        self.price = price
        self.pot = pot
        self.height = height
        self.width = width
    }
    
    func getName()->String{
        return name
    }
    
    func getSpecie()->String{
        return species
    }
    
    func getPrice()->Double{
        return price
    }
    
    func getImage()->UIImage?{
        return photo
    }
    
    
}