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
        /*
         * grab input: DONE
         * store input: DONE
         * sort input for quicker comparison: Done
         * take the input and search against dictionary: Done
         * load dictionary
         * sort characters for each word: DONE
         * compare input to dictionary until 0 or more results are found
             * 0 = bummer
             * >0 = list options
         * display message
         *
         * assuming each word in dictionary is sorted, maintain the original index and keep trakc of those. use those indexes to find the original version of the words in the dictionary
         * sort input a-z
         * sort dictionary words a-z while maintaining existing indexing
         */
        
        
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
        /*
        //TODO: Figure out how to turn file into array
       
        var jsonData: Data?
        
        if let file = Bundle.main.path(forResource: "dictionary_small", ofType: "json") {
            jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
        } else {
            print("Fail")
        }
        */
        
        //Example Arrays from dictionary of words
        //TODO: Derive this from the actual dictionary file
        let dictionaryWordsArray = ["anarchic","anopheles","anti-federalist","aspirated","autocratship","abrogable","athanasy","athansay","athaansy"]
        print(dictionaryWordsArray)
         if (Sorted == true){
            // For each item in the dictionary, create a new array for each letter, sort it, then convert back to a string, and add to the "sorted" array
            var dictionaryWordsArraySorted: [String] = []
            for word in dictionaryWordsArray {
                let tempArray = Array(word.lowercased().sorted()) //split of a single word, then sorted array
                let newWord = String(tempArray) //re aggraigned word
                dictionaryWordsArraySorted.append(newWord) //build out new array to use for matching
            }
            print(dictionaryWordsArraySorted)
            
            return dictionaryWordsArraySorted
        } else {
            return dictionaryWordsArray
        }
    }
    
    //take the user input, load the dictionary already storted, and search
    private func findMatches(userInput: String) -> String {
        let dictionaryWordsArraySorted = loadDictionary(Sorted: true) //creates the array of dictionary items and prepares for matching
        let dictionaryWordsArray = loadDictionary(Sorted: false)
        var output = "OG: " + (userInput) //setup of the output field
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
        print(wordMatches)
        
        //reconcile matches to original dictionary and return output
        if (wordMatches.isEmpty == false) {
            for index in wordMatches {
                output += "\n" + dictionaryWordsArray[index]
            }
        } else {
            output += "\n\nThere are no anagarams for your input. Please try again."
        }
        
        print(output)
        
        return output
    }
    
    
    

}

