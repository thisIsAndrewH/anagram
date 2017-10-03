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
        
        //find anagram(s)
        let sortedInput = anagramSorter(userInputToSort: userInput!)
        
        //display anagram(s)
        anagramOutput.text = "OG: " + (userInput)! + "\nSorted: " + String(describing: sortedInput)

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
        
        return dictionary
    }
    

}

