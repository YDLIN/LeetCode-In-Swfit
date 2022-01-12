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
let nodeArray3 = [28, 74, 42, 50, 75, 67, 95, 94, 40, 27, 8, 13, 97, 85, 49]
let nodeArray4 = [85, 19 ,69, 3, 7, 99, 95]
let avl = AVLTree()

for i in 0..<nodeArray4.count {
    avl.add(nodeArray4[i])
}

avl.remove(element: 99)
avl.remove(element: 85)
avl.remove(element: 95)
print(avl)




