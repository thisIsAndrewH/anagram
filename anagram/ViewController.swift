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
         * grab input
         * store input
         * sort input for quicker comparison
         * take the input and search against dictionary
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
        
        //find anagram(s)
        let sortedInput = anagramSorter(userInputToSort: userInput!)
        loadDictionary()
        
        //display anagram(s)
        anagramOutput.text = findMatches(userInput: userInput!)

    }
    
    private func anagramSorter(userInputToSort: String) -> Array<Any> {
        //sorts the input alphabetically
        let characters = Array(userInputToSort.lowercased())
        print(characters.sorted())
        
        return characters.sorted()
    }
    
    func loadDictionary() -> Array<Any> {
        //load and parse the dictionary file
        let dictionary = ["word","definition"]
        
        var jsonData: Data?
        
        if let file = Bundle.main.path(forResource: "dictionary_small", ofType: "json") {
            jsonData = try? Data(contentsOf: URL(fileURLWithPath: file))
        } else {
            print("Fail")
        }
        
        //TODO: Figure out how to turn file into array
        let jsonDictionary = try? JSON(data: jsonData!)
        print(jsonDictionary)
        
        //Example Arrays from dictionary of words
        //TODO: Derive this from the actual dictionary file
        let dictionaryWordsArray = ["anarchic","anopheles","anti-federalist","aspirated","autocratship","abrogable","athanasy"]
        print(dictionaryWordsArray)
        
        /*
         * for each item in the dictionary, create a new array for each letter, sort it, then convert back to a string, and add to the "sorted" array
         
         Goal: keep the index the same!
         */
        
        var dictionaryWordsArraySorted: [String] = []
        for word in dictionaryWordsArray {
            let tempArray = Array(word.lowercased().sorted())
            
            let newWord = String(tempArray)
            dictionaryWordsArraySorted.append(newWord)
        }
        print(dictionaryWordsArraySorted)
        
        return dictionaryWordsArraySorted
    }
    
    func findMatches(userInput: String) -> String {
        //take the user input, load the dictionary already storted, and search
        let loadedDictionary = loadDictionary()
        let output = "OG: " + (userInput)
        
       // for word in loadDictionary {
            //does userInput = item?
            
        //}
        return output
    }
    
    
    

}

