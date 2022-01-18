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
let nodeArray4 = [76, 12, 29, 8, 73, 49, 1, 57, 68]
let rb = RBTree()

for i in 0..<nodeArray4.count {
    rb.add(nodeArray4[i])
}

print(rb)
print("-------------")
for i in 0..<nodeArray4.count {
    rb.remove(element: nodeArray4[i])
    print(rb)
    print("-------------")
}





