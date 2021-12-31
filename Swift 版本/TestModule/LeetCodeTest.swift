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
    public func startTest() {
        leetCodeTest()
//        offerTest()
    }
    
    private func leetCodeTest() {
//        solution_0541_test()
//        solution_0344_test()
//        solution_0151_test()
//        solution_0027_test()
//        solution_0028_test()
//        solubtion_0059_test()
        leetCode_0203Test()
    }
    
    private func offerTest() {
        
    }
}

extension LeetCodeTest {
    func solution_0027_test() {
        Solution_0027().solution_0027_test(&removeArray3, 9)
    }
    
    func solution_0028_test() {
//        let index = Solution_0028().strStr(kmpString_s, kmpString_p)
//        let pos = Solution_0028().bruteForce(kmpString_s, kmpString_p)
//        print(pos)
        let next = Solution_0028().getNext(needle: Array("ababaab"))
        print(next)
    }
    
    func solubtion_0059_test() {
        let matrix = Solution_0059().generateMatrix(4);
        print(matrix);
    }
    
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
    
    func solution_0344_test() {
        var ch = Array(string_1)
        Solution_0344().solution_0344_test(&ch)
    }
}
