////
////  Observer.swift
////  BucketListWithStructs
////
////  Created by VDAB Cursist on 1/03/17.
////  Copyright © 2017 knetter. All rights reserved.
////
//
//import Foundation
//
//class Observer: NSObject {
//    
//    func startObservingWishList(wishList: WishList) {
//        let options = NSKeyValueObservingOptions([.new, .old])
//        wishList.addObserver(self, forKeyPath: "wishList", options: options, context: nil)
//    }
//    
//    func stopObservingWishList(wishList: WishList) {
//        wishList.removeObserver(self, forKeyPath: "wishList", context: nil)
//    }
//
//    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutableRawPointer) {
//        
//        if keyPath == "wishList" {
//            let buttonList = [removeItemFromBucketListButton, moveItemToWeekListButton, moveItemToWeekListButton]
//            for button in buttonList {
//                trigger(button!, forList: bucketList)
//            }
//            update(bucketListTextView, with: bucketList)
//        }
//    }
//}
//
//
