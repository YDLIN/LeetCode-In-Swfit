//
//  LeetCodeTest.swift
//  LeetCode
//
//  Created by Du on 2021/8/13.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/********************LeetCode的测试写在这里********************/
class LeetCodeTest {
    func startTest() {
//        leetCode_0203Test()
//        leetCode_0707Test()
//        solution_0541_test()
        solution_0151_test()
    }
}

extension LeetCodeTest {
    func leetCode_0203Test() {
        let linkedList = removeElementsInLinkedList()
        Solution_0203().solution_0203_test(linkedList.head, 6)
    }
    
    func leetCode_0707Test() {
        let linkList = Solution_0707()
        linkList.addAtTail(1)
        print(linkList.get(0))
    }
    
    func solution_0541_test() {
        Solution_0541().solution_0541_test(string_1, 2)
//        Solution_0541().solution_0541_test(string_2, 4)
    }
    
    func solution_0151_test() {
        Solution_0151().solution_0151_test(string_6)
    }
}
