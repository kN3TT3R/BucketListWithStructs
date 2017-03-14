//
//  ViewController.swift
//  BucketListWithObservers
//
//  Created by Kenneth Debruyn on 29/01/17.
//  Copyright © 2017 kN3TT3R. All rights reserved.
//

import UIKit
import WebKit

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

    private var myContext = 0
    
    
    // MARK: - Global Variables, Constants & Structures
    var bucketList = WishList()
    var weekList = WishList()
    //var wish = Wish()
    
    
    // MARK: - Overridden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bucketList.addObserver(self, forKeyPath: "wishList", options: .new, context: &myContext)
        weekList.addObserver(self, forKeyPath: "wishList", options: .new, context: &myContext)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func observeValue(forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?)
    {
        if context == &myContext {
            let bucketButtonList = [removeItemFromBucketListButton, moveItemToWeekListButton, moveItemToWeekListButton]
            let weekButtonList = [completeItemButton, moveItemToBucketListButton]
        
            trigger(bucketButtonList as! [UIButton], forList: bucketList)
            trigger(weekButtonList as! [UIButton], forList: weekList)
            
            update(bucketListTextView, with: bucketList)
            update(weekListTextView, with: weekList)
        }
    }


    // MARK: - IBActions
    @IBAction func addItemToBucketList(_ sender: UIButton) {
        let wish = Wish()
        if !addItemTextField.text!.isEmpty && addItemTextField != nil {
            wish.title = addItemTextField.text!
            bucketList.add(wish)
            addItemTextField.text?.removeAll()
        } else {
            showAlert("Don't you got any wishes?", withTitle: "No wish!")
        }
        addItemTextField.resignFirstResponder()
    }
    
    @IBAction func removeItemFromBucketList(_ sender: UIButton) {
        if !bucketList.isEmpty() {
            bucketList.removeFirst()
        }
    }
    
    @IBAction func moveItemToWeekList(_ sender: UIButton) {
        if !bucketList.isEmpty() {
            weekList.add(bucketList.wishList.removeFirst())
        }
    }

    @IBAction func moveItemToBucketList(_ sender: UIButton) {
        if !weekList.isEmpty() {
            bucketList.insert(wish: weekList.wishList.removeFirst())
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
        }
    }
    
    
    // MARK: - Homemade Functions
    func update(_ textView: UITextView, with wishList: WishList) {
        textView.text = ""
        for wish in wishList.wishList {
            print(wish.title)
            textView.text.append("\(wish.title!)\n")
        }
    }
    
    func trigger(_ buttons: [UIButton], forList wishList: WishList) {
        for button in buttons {
            if wishList.isEmpty() {
                button.isEnabled = false
            } else {
                button.isEnabled = true
            }
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
