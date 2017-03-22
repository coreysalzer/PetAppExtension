//
//  Pet.swift
//  CoreySalzer-Lab2
//
//  Created by Corey Salzer on 2/6/17.
//  Copyright © 2017 Corey Salzer. All rights reserved.
//

import UIKit

class Pet {
    let animal:String
    var color:UIColor
    var happinessLevel:Int
    var foodLevel:Int
    var name:String
    var age:Double
    var lifeExpectancy:Double
    
    init(petColor: UIColor, petAnimal: String) {
        color = petColor
        animal = petAnimal
        happinessLevel = 0
        foodLevel = 0
        name = ""
        age = 0
        lifeExpectancy = 14
    }
    
    func getIdentifier() -> String{
        if name == "" {
            return animal
        }
        return name
    }
    
    func play() {
        if foodLevel > 0 {
            happinessLevel += 1
            foodLevel -= 1
        }
        getOlder()
    }
    
    func feed() {
        foodLevel += 1
        getOlder()
    }
    
    func getOlder() {
        age += 0.5
    }
    
    func isDead() -> Bool {
        return age > lifeExpectancy
    }
    
    func reincarnate() {
        happinessLevel = 0
        foodLevel = 0
        age = 0
        lifeExpectancy = 14
    }
    
    func resuscitate() -> Bool {
        let willLive:Bool = Int(arc4random_uniform(3)) == 0
        if willLive {
            lifeExpectancy += 2
        }
        return !isDead()
    }
}
