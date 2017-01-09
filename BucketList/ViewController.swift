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
    @IBOutlet weak var addItemTextField: UITextField!
    @IBOutlet weak var bucketListTextView: UITextView!
    @IBOutlet weak var weekListTextView: UITextView!
    @IBOutlet weak var removeItemFromBucketListButton: UIButton!
    @IBOutlet weak var addButtonToBucketListButton: UIButton!
    @IBOutlet weak var moveItemToWeekListButton: UIButton!
    @IBOutlet weak var moveItemToBucketListButton: UIButton!
    @IBOutlet weak var completeItemButton: UIButton!
    @IBOutlet weak var disableUIButton: UIButton!

    
    // MARK: - Global Variables & Constants
    var bucketListArray = [String] ()
    var weekListArray = [String] ()
    
    
    // MARK: - Overridden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - IBActions
    @IBAction func addItemToBucketList(_ sender: UIButton) {
        if !addItemTextField.text!.isEmpty && addItemTextField != nil {
            bucketListArray.append(addItemTextField.text!)
            addItemTextField.text?.removeAll()
        } else {
            showAlert("Don't you got any wishes?", withTitle: "No wish!")
        }
        update(bucketListTextView, with: bucketListArray)
        updateButtons()
        addItemTextField.resignFirstResponder()
    }
    
    @IBAction func removeItemFromBucketList(_ sender: UIButton) {
        if !bucketListArray.isEmpty {
            bucketListArray.removeFirst()
            update(bucketListTextView, with: bucketListArray)
            updateButtons()
        }
    }
    
    @IBAction func moveItemToWeekList(_ sender: UIButton) {
        if !bucketListArray.isEmpty {
            let itemToBeMoved = bucketListArray.removeFirst()
            weekListArray.append(itemToBeMoved)
            update(bucketListTextView, with: bucketListArray)
            update(weekListTextView, with: weekListArray)
            updateButtons()
        }
    }

    @IBAction func moveItemToBucketList(_ sender: UIButton) {
        if !weekListArray.isEmpty {
            let itemToBeMoved = weekListArray.removeFirst()
            bucketListArray.insert(itemToBeMoved, at: 0)
            update(bucketListTextView, with: bucketListArray)
            update(weekListTextView, with: weekListArray)
            updateButtons()
        }
    }

    @IBAction func disableUserInterface(_ sender: UIButton) {
        showAlert("Insert coins...", withTitle: "Game over!")
        bucketListTextView.text.removeAll()
        weekListTextView.text.removeAll()
        addItemTextField.isEnabled = false
        removeItemFromBucketListButton.isEnabled = false
        addButtonToBucketListButton.isEnabled = false
        moveItemToWeekListButton.isEnabled = false
        moveItemToBucketListButton.isEnabled = false
        completeItemButton.isEnabled = false
        disableUIButton.isEnabled = false
    }
    
    @IBAction func completedItem(_ sender: UIButton) {
        if !weekListArray.isEmpty {
            weekListArray.removeFirst()
            update(weekListTextView, with: weekListArray)
            updateButtons()
        }
    }
    
    
    // MARK: - Homemade Functions
    func update(_ textView: UITextView, with listArray: [String]) {
        textView.text = ""
        for arrayItem in listArray {
            textView.text.append("\(arrayItem)\n")
        }
    }

    func updateButtons() {
        if bucketListArray.isEmpty {
            removeItemFromBucketListButton.isEnabled = false
            moveItemToWeekListButton.isEnabled = false
        } else {
            removeItemFromBucketListButton.isEnabled = true
            moveItemToWeekListButton.isEnabled = true
        }
        if weekListArray.isEmpty {
            completeItemButton.isEnabled = false
            moveItemToBucketListButton.isEnabled = false
        } else {
            completeItemButton.isEnabled = true
            moveItemToBucketListButton.isEnabled = true
            disableUIButton.isEnabled = true
        }
    }
    
    func showAlert(_ alert: String, withTitle title: String) {
        let alertController = UIAlertController(title: title, message:
            alert, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
