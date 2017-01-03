//
//  ViewController.swift
//  BucketList
//
//  Created by Kenneth Debruyn on 3/01/17.
//  Copyright © 2017 kN3TT3R. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var addItemTF: UITextField!
    @IBOutlet weak var bucketListTV: UITextView!
    @IBOutlet weak var thisWeeksListTV: UITextView!
    @IBOutlet weak var removeItemB: UIButton!
    @IBOutlet weak var addItemToWeekB: UIButton!
    @IBOutlet weak var addItemToListB: UIButton!
    @IBOutlet weak var completeItemB: UIButton!
    @IBOutlet var completeUI: UIView!

    // MARK: - Global Variables & Constants
    var bucketListArray = [String] ()
    var thisWeeksListArray = [String] ()
    
    // MARK: - IBActions
    @IBAction func addItemB(_ sender: UIButton) {
        if !(addItemTF.text?.isEmpty)! {
            bucketListArray.append(addItemTF.text!)
            updateTextViews(array: bucketListArray, textView: bucketListTV)
            emptyAddBucketTF()
            updateButtons()
        }
    }
    
    @IBAction func removeItemB(_ sender: UIButton) {
        bucketListArray.removeFirst()
        updateTextViews(array: bucketListArray, textView: bucketListTV)
        updateButtons()
    }
    
    @IBAction func addToThisWeek(_ sender: UIButton) {
        thisWeeksListArray.append(bucketListArray[0])
        bucketListArray.removeFirst()
        moveItem()
    }
    
    @IBAction func removeFromThisWeek(_ sender: UIButton) {
        bucketListArray.insert(thisWeeksListArray[0], at: 0)
        thisWeeksListArray.removeFirst()
        moveItem()
    }

    @IBAction func disableUserInterface(_ sender: UIButton) {
        completeUI.isUserInteractionEnabled = false
    }
    
    @IBAction func completeOneBucket(_ sender: UIButton) {
        thisWeeksListArray.removeFirst()
        updateTextViews(array: thisWeeksListArray, textView: thisWeeksListTV)
        updateButtons()
    }
    
    // MARK: - Homemade Functions
    func updateTextViews(array: Array<String>, textView: UITextView) {
        textView.text = ""
        for arrayItem in array {
            textView.text.append(arrayItem)
            textView.text.append("\n")
        }
    }
    
    func moveItem() {
        updateTextViews(array: bucketListArray, textView: bucketListTV)
        updateTextViews(array: thisWeeksListArray, textView: thisWeeksListTV)
        updateButtons()
    }
    
    func updateButtons() {
        if bucketListArray.isEmpty {
            removeItemB.isEnabled = false
            addItemToWeekB.isEnabled = false
        } else {
            removeItemB.isEnabled = true
            addItemToWeekB.isEnabled = true
        }
        if thisWeeksListArray.isEmpty {
            completeItemB.isEnabled = false
            addItemToListB.isEnabled = false
        } else {
            completeItemB.isEnabled = true
            addItemToListB.isEnabled = true
        }
    }
    
    func emptyAddBucketTF() {
        addItemTF.text?.removeAll()
        addItemTF.resignFirstResponder()
    }
    
    func disableRemoveBucketItemB() {
        removeItemB.isEnabled = false
    }
    
    // MARK: - Overridden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

