//
//  main.swift
//  LeetCode
//
//  Created by 余杜林 on 2020/8/30.
//  Copyright © 2020 Du. All rights reserved.
//

import Foundation

// Swift 版本 - 剑指Offer的题目
let offer = OfferTest()
//offer.startTest()

// Swift 版本 - 正常的题目
let leetCode = LeetCodeTest()
//leetCode.startTest()

// C++版本 - 正常的题目
let cpp = CPPWrapper();
//cpp.startTest();


let nodeArray = [7, 4, 9, 2, 5, 8, 11, 1, 3, 10, 12]
let nodeArray2 = [8, 4, 13, 2, 6, 10, 1, 3, 5, 7, 9, 12, 11]
let nodeArray3 = [9, 11, 10, 12]
let bst = BST()

for i in 0..<nodeArray2.count {
    bst.add(nodeArray2[i])
}
print(bst)
print(bst.remove(element: 5))
print(bst.remove(element: 6))
print(bst.remove(element: 3))
print(bst.remove(element: 4))
print(bst)
print(bst.size)





