//
//  ViewController.swift
//  CoreySalzer-Lab2
//
//  Created by Corey Salzer on 2/6/17.
//  Copyright © 2017 Corey Salzer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let petsByName:[String: Pet] = [
        "Dog": Pet(petColor: UIColor(red: 240/255.0, green: 255/255.0, blue: 56/255.0, alpha: 1), petAnimal: "Dog"),
        "Cat": Pet(petColor: UIColor(red: 151/255.0, green: 192/255.0, blue: 255/255.0, alpha: 1), petAnimal: "Cat"),
        "Bird": Pet(petColor: UIColor(red: 255/255.0, green: 172/255.0, blue: 97/255.0, alpha: 1), petAnimal: "Bird"),
        "Bunny": Pet(petColor: UIColor(red: 255/255.0, green: 166/255.0, blue: 252/255.0, alpha: 1), petAnimal: "Bunny"),
        "Fish": Pet(petColor: UIColor(red: 131/255.0, green: 255/255.0, blue: 150/255.0, alpha: 1), petAnimal: "Fish")
    ]
    var currentPet:Pet!

    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petViewController: UIView!

    @IBOutlet weak var happinessLevel: UILabel!
    @IBOutlet weak var foodLevel: UILabel!
    @IBOutlet weak var happinessLevelDisplayView: DisplayView!
    @IBOutlet weak var foodLevelDisplayView: DisplayView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var dogUIButton: UIButton!
    @IBOutlet weak var catUIButton: UIButton!
    @IBOutlet weak var birdUIButton: UIButton!
    @IBOutlet weak var bunnyUIButton: UIButton!
    @IBOutlet weak var fishUIButton: UIButton!
    
    var buttonsByName:[String: UIButton]!
    var animalsAlive:[String]!
    
    @IBOutlet weak var statusUpdate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttonsByName = ["Dog": dogUIButton, "Cat": catUIButton, "Bird": birdUIButton, "Bunny": bunnyUIButton, "Fish": fishUIButton]
        animalsAlive = ["Dog", "Cat", "Bird", "Bunny", "Fish"]
        currentPet = petsByName["Bird"]!
        updateColor(color: currentPet.color)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(_ sender: UIButton) {
        currentPet.play()
        checkPet()
        updateLevelValues(pet: currentPet)

    }

    @IBAction func feed(_ sender: UIButton) {
        currentPet.feed()
        checkPet()
        updateLevelValues(pet: currentPet)
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
        currentPet.name = sender.text!
        updateName(name: currentPet.name)
    }
    
    @IBAction func petSwitched(_ sender: UIButton) {
        let newPetName = sender.titleLabel!.text!
        currentPet = petsByName[newPetName]!
        
        petImageView.image = UIImage(named: newPetName.lowercased())
        updateName(name: currentPet.name)
        updateColor(color: currentPet.color)
        updateLevelValues(pet: currentPet)
    }
    
    func checkPet() {
        if currentPet.isDead() {
            let wasResuscitated = currentPet.resuscitate()
            if !wasResuscitated {
                buttonsByName[currentPet.animal]!.isHidden = true
                if animalsAlive.index(of: currentPet.animal) != nil {
                    animalsAlive.remove(at: animalsAlive.index(of: currentPet.animal)!)
                }
                
                statusUpdate.text = currentPet.getIdentifier() + " died at age " + String(currentPet.age)
                
                if animalsAlive.count == 0 {
                    for (name, button) in buttonsByName {
                        button.isHidden = false
                        animalsAlive.append(name)
                        petsByName[name]!.reincarnate()
                    }
                    shuffleNamesAndColors()
                    statusUpdate.text = "Your animals have been reincarnated in different bodies!"
                }
                petSwitched(buttonsByName[animalsAlive.first!]!)
            }
            else {
                statusUpdate.text = currentPet.getIdentifier() + " almost died and was resuscitated!"
            }
        }
    }
    
    func updateName(name: String) {
        nameTextField.text = currentPet.name
    }
    
    func updateColor(color: UIColor) {
        petViewController.backgroundColor = color
        happinessLevelDisplayView.color = color
        foodLevelDisplayView.color = color
    }
    
    func updateLevelValues(pet: Pet) {
        happinessLevel.text = String(pet.happinessLevel)
        foodLevel.text = String(pet.foodLevel)
        happinessLevelDisplayView.animateValue(to: CGFloat(pet.happinessLevel) / 10)
        foodLevelDisplayView.animateValue(to: CGFloat(pet.foodLevel) / 10)
    }
    
    func shuffleNamesAndColors() {
        let dogName = petsByName["Dog"]?.name
        let dogColor = petsByName["Dog"]?.color
        petsByName["Dog"]?.name = petsByName["Cat"]!.name
        petsByName["Dog"]?.color = petsByName["Cat"]!.color
        petsByName["Cat"]?.name = petsByName["Bird"]!.name
        petsByName["Cat"]?.color = petsByName["Bird"]!.color
        petsByName["Bird"]?.name = petsByName["Bunny"]!.name
        petsByName["Bird"]?.color = petsByName["Bunny"]!.color
        petsByName["Bunny"]?.name = petsByName["Fish"]!.name
        petsByName["Bunny"]?.color = petsByName["Fish"]!.color
        petsByName["Fish"]?.name = dogName!
        petsByName["Fish"]?.color = dogColor!
    }
}

