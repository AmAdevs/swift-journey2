//
//  AnimalTableViewController.swift
//  IndexedTableDemo
//
//  Created by Ananchai Mankhong on 28/7/2562 BE.
//  Copyright © 2562 Ananchai Mankhong. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {

    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    var animalDict = [String: [String]]()
    var animalSectionTitles = [String]()
    
    let animalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate the animal dictionary
        createAnimalDict()

    }
    
    func createAnimalDict() {
        for animal in animals {
            // Get the first letter of the animal name and build the dictionary
            let firstLetterIndex = animal.index(animal.startIndex, offsetBy: 1)
            let animalKey = String(animal[..<firstLetterIndex])
            
            if var animalValues = animalDict[animalKey] {
                animalValues.append(animal)
                animalDict[animalKey] = animalValues
            } else {
                animalDict[animalKey] = [animal]
            }
        }
        
        // Get the section titles from the dictionary's keys and sort them in ascending order
        animalSectionTitles = [String](animalDict.keys)
        animalSectionTitles = animalSectionTitles.sorted(by: { $0 < $1 })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return animalSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalSectionTitles[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        let animalKey = animalSectionTitles[section]
        guard let animalValues = animalDict[animalKey] else {
            return 0
        }
        
        return animalValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell
        let animalKey = animalSectionTitles[indexPath.section]
        if let animalValues = animalDict[animalKey] {
            cell.textLabel?.text = animalValues[indexPath.row]
            
            // Convert the animal to lower case and
            // then replace all occurrence of a space with an underscore
            let imageFilename = animalValues[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "_")
            cell.imageView?.image = UIImage(named: imageFilename)
            
        }
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return animalIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
       
        guard let index = animalSectionTitles.firstIndex(of: title) else {
            return -1
        }
     
        return index
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        headerView.textLabel?.textColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    }

}
