//
//  ViewController.swift
//  anagram
//
//  Created by Andrew Harris on 10/2/17.
//  Copyright © 2017 Andrew Harris. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var anagramInput: UITextField!
    @IBOutlet weak var anagramOutput: UITextView!
    
    @IBAction func findAnagrams(_ sender: Any) {
        //grab the input
        let userInput = anagramInput.text
        
        //display anagram(s)
        anagramOutput.text = findMatches(userInput: userInput!)
    }
    
    //takes user input, sorts it alphabetically, returns a string for comparison
    private func anagramSorter(userInputToSort: String) -> String {
        var characters = Array(userInputToSort.lowercased())
        characters = characters.sorted()
        
        return String(characters)
    }
    
    //load and parse the dictionary file
    //The sorted bool will alphabatize each word for better/quick matching against the input word.
    private func loadDictionary(Sorted: Bool) -> Array<String> {
        let dictionaryWordsArray = fetchDictionary()
        if (Sorted == true){
            // For each item in the dictionary, create a new array for each letter, sort it, then convert back to a string, and add to the "sorted" array
            var dictionaryWordsArraySorted: [String] = []
            for word in dictionaryWordsArray {
                let tempArray = Array(word.lowercased().sorted()) //split of a single word, then sorted array
                let newWord = String(tempArray) //re aggraigned word
                dictionaryWordsArraySorted.append(newWord) //build out new array to use for matching
            }
            
            return dictionaryWordsArraySorted
        } else {
            return dictionaryWordsArray
        }
    }
    
    //loads webster dictionary from file
    private func fetchDictionary() -> Array<String> {
        var jsonData: Data?
        if let file = Bundle.main.path(forResource: "dictionary_alpha_arrays", ofType: "json") {
            jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
        } else {
            print("Fail")
        }
        
        //convert to JSONSwifty
        let jsonSwifty = JSON(jsonData!)
        
        let words:JSON = jsonSwifty[0]
        var dictionaryArray: [String] = []
        for word in words{
            dictionaryArray.append(String(describing: word.0))
        }
        
        return dictionaryArray
    }
    
    //take the user input, load the dictionary already storted, and search
    private func findMatches(userInput: String) -> String {
        //creates the array of dictionary items and prepares for matching
        let dictionaryWordsArraySorted = loadDictionary(Sorted: true)
        let dictionaryWordsArray = loadDictionary(Sorted: false)
        var output = "Input: " + (userInput) + "\n"//setup of the output field
        var wordMatches = [Int]()
        var count = 0
        
        //sort the input
        let sortedInput = anagramSorter(userInputToSort: userInput)
        
        for word in dictionaryWordsArraySorted {
            if(String(describing: word) == sortedInput){
                //build array of matches
                wordMatches.append(count)
            }
            count = count + 1
        }
        
        //reconcile matches to original dictionary and return output
        if (wordMatches.isEmpty == false) {
            for index in wordMatches {
                output += "\n" + dictionaryWordsArray[index]
            }
        } else {
            output += "\n\nThere are no anagarams for your input. Please try again."
        }
        
        return output
    }

}
