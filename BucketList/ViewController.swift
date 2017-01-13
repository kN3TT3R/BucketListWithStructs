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

    
    // MARK: - Global Variables, Constants & Structs
    var bucketListArray = [String] ()
    var weekListArray = [String] ()
    
    struct WishList {
        var wishList = [Wish] ()
        var wish = Wish(title: "")
        
        mutating func add(_ wish: Wish) {
            wishList.append(wish)
        }
        
        mutating func removeFirst() {
            wishList.removeFirst()
        }
        
        func isEmpty() -> Bool {
            return wishList.isEmpty
        }
        
        mutating func insert(wish: Wish) {
            wishList.insert(wish, at: 0)
        }
    }
    
    struct Wish {
        var title = ""
    }
    
    var bucketList = WishList()
    var weekList = WishList()
    var wish = Wish()
    
    
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
            wish.title = addItemTextField.text!
            bucketList.add(wish)
            addItemTextField.text?.removeAll()
        } else {
            showAlert("Don't you got any wishes?", withTitle: "No wish!")
        }
        update(bucketListTextView, with: bucketList)
        updateButtons()
        addItemTextField.resignFirstResponder()
    }
    
    @IBAction func removeItemFromBucketList(_ sender: UIButton) {
        if !bucketList.isEmpty() {
            bucketList.removeFirst()
            update(bucketListTextView, with: bucketList)
            updateButtons()
        }
    }
    
    @IBAction func moveItemToWeekList(_ sender: UIButton) {
        if !bucketList.isEmpty() {
            weekList.add(bucketList.wishList.removeFirst())
            update(bucketListTextView, with: bucketList)
            update(weekListTextView, with: weekList)
            updateButtons()
        }
    }

    @IBAction func moveItemToBucketList(_ sender: UIButton) {
        if !weekList.isEmpty() {
            bucketList.insert(wish: weekList.wishList.removeFirst())
            update(bucketListTextView, with: bucketList)
            update(weekListTextView, with: weekList)
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
        if !weekList.isEmpty() {
            weekList.removeFirst()
            update(weekListTextView, with: weekList)
            updateButtons()
        }
    }
    
    
    // MARK: - Homemade Functions
    func update(_ textView: UITextView, with wishList: WishList) {
        textView.text = ""
        for wish in wishList.wishList {
            textView.text.append("\(wish.title)\n")
        }
    }

    func updateButtons() {
        if bucketList.isEmpty() {
            removeItemFromBucketListButton.isEnabled = false
            moveItemToWeekListButton.isEnabled = false
        } else {
            removeItemFromBucketListButton.isEnabled = true
            moveItemToWeekListButton.isEnabled = true
        }
        if weekList.isEmpty() {
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
