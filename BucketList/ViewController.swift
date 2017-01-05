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
    @IBAction func addItemToBucketListButton(_ sender: UIButton) {
        if !addItemTextField.text!.isEmpty {
            bucketListArray.append(addItemTextField.text!)
            updateTextViews(array: bucketListArray, textView: bucketListTextView)
            addItemTextField.text?.removeAll()
            addItemTextField.resignFirstResponder()
            updateButtons()
        } else {
            showAlert("Don't you got any wishes?", withTitle: "No wish!")
        }
    }
    
    @IBAction func removeItemFromBucketListButton(_ sender: UIButton) {
        bucketListArray.removeFirst()
        updateTextViews(array: bucketListArray, textView: bucketListTextView)
        updateButtons()
    }
    
    @IBAction func moveItemToWeekListButton(_ sender: UIButton) {
        if !bucketListArray.isEmpty {
            weekListArray.append(bucketListArray[0])
            bucketListArray.removeFirst()
            moveItem()
        }
    }

    @IBAction func moveItemToBucketListButton(_ sender: UIButton) {
        if !weekListArray.isEmpty {
            bucketListArray.insert(weekListArray[0], at: 0)
            weekListArray.removeFirst()
            moveItem()
        }
    }

    @IBAction func disableUserInterfaceButton(_ sender: UIButton) {
        bucketListTextView.text.removeAll()
        weekListTextView.text.removeAll()
        addItemTextField.isEnabled = false
        bucketListTextView.isSelectable = false
        weekListTextView.isSelectable = false
        removeItemFromBucketListButton.isEnabled = false
        addButtonToBucketListButton.isEnabled = false
        moveItemToWeekListButton.isEnabled = false
        moveItemToBucketListButton.isEnabled = false
        completeItemButton.isEnabled = false
        disableUIButton.isEnabled = false
    }
    
    @IBAction func completeItemButton(_ sender: UIButton) {
        weekListArray.removeFirst()
        updateTextViews(array: weekListArray, textView: weekListTextView)
        updateButtons()
    }
    
    // MARK: - Homemade Functions
    func updateTextViews(array: Array<String>, textView: UITextView) {
        textView.text = ""
        for arrayItem in array {
            textView.text.append("\(arrayItem)\n")
        }
    }
    
    func moveItem() {
        updateTextViews(array: bucketListArray, textView: bucketListTextView)
        updateTextViews(array: weekListArray, textView: weekListTextView)
        updateButtons()
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
        }
    }

    func disableRemoveBucketItemB() {
        removeItemFromBucketListButton.isEnabled = false
    }
    
    func showAlert(_ alert: String, withTitle
        title: String){
        let alertController = UIAlertController(title: title, message:
            alert, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default,
                                          handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
