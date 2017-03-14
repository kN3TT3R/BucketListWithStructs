//
//  WishList.swift
//  BucketListWithObservers
//
//  Created by Kenneth Debruyn on 1/03/17.
//  Copyright © 2017 knetter. All rights reserved.
//

import Foundation

class WishList: NSObject {
    
    dynamic var wishList: [Wish] = []
    
    func add(_ wish: Wish) {
        wishList.append(wish)
    }
    
    func removeFirst() {
        wishList.removeFirst()
    }
    
    func isEmpty() -> Bool {
        return wishList.isEmpty
    }
    
    func insert(wish: Wish) {
        wishList.insert(wish, at: 0)
    }
}


