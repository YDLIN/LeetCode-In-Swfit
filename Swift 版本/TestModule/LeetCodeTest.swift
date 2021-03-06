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
        _0To300()
        _300To600()
        _600To900()
        _900To1200()
    }
    
    private func _0To300() {
//        solution_0017_test()
//        solution_0027_test()
//        solution_0028_test()
//        solution_0059_test()
//        solution_0077_test()
//        solution_0094_test()
//        solution_0100_test()
//        solution_0101_test()
//        solution_0102_test()
//        solution_0104_test()
//        solution_0105_test()
//        solution_0106_test()
//        solution_0107_test()
//        solution_0110_test()
//        solution_0111_test()
//        solution_0112_test()
//        solution_0113_test()
//        solution_0116_test()
//        solution_0117_test()
//        solution_0144_test()
//        solution_0145_test()
//        solution_0151_test()
//        solution_0199_test()
//        solution_0203_test()
        solution_0209_test()
//        solution_0216_test()
//        solution_0222_test()
//        solution_0226_test()
//        solution_0257_test()
    }
    
    private func _300To600() {
//        solution_0344_test()
//        solution_0404_test()
//        solution_0429_test()
//        solution_0513_test()
//        solution_0515_test()
        solution_0541_test()
//        solution_0559_test()
//        solution_0589_test()
//        solution_0590_test()
    }
    
    private func _600To900() {
//        solution_0637_test()
//        solution_0654_test()
    }
    
    private func _900To1200() {
//        solution_0958_test()
    }
}

extension LeetCodeTest {
    func solution_0017_test() {
        Solution_0017().test()
    }
    
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
    
    func solution_0059_test() {
        let matrix = Solution_0059().generateMatrix(4);
        print(matrix);
    }
    
    func solution_0077_test() {
        Solution_0077().test()
    }
    
    func solution_0094_test() {
        Solution_0094().test()
    }
    
    func solution_0100_test() {
        Solution_0100().test()
    }
    
    func solution_0101_test() {
        Solution_0101().test()
    }
    
    func solution_0102_test() {
        Solution_0102().test()
    }
    
    func solution_0104_test() {
        Solution_0104().test()
    }
    
    func solution_0105_test() {
        let _ = Solution_0105().test()
    }
    
    func solution_0106_test() {
//        let _ = Solution_0106().test()
        let _ = Solution_0106().test2()
    }
    
    func solution_0107_test() {
        Solution_0107().test()
    }
    
    func solution_0110_test() {
        Solution_0110().test()
    }
    
    func solution_0111_test() {
        Solution_0111().test()
    }
    
    func solution_0112_test() {
        Solution_0112().test()
    }
    
    func solution_0113_test() {
        Solution_0113().test()
    }
    
    func solution_0116_test() {
        Solution_0116().test()
    }
    
    func solution_0117_test() {
        Solution_0117().test()
    }
    
    func solution_0144_test() {
        Solution_0144().test()
    }
    
    func solution_0145_test() {
        Solution_0145().test()
    }
    
    func solution_0151_test() {
        Solution_0151().solution_0151_test(string_6)
    }
    
    func solution_0199_test() {
        Solution_0199().test()
    }
    
    func solution_0203_test() {
        let linkedList = removeElementsInLinkedList()
        Solution_0203().solution_0203_test(linkedList.head, 6)
    }
    
    func solution_0209_test() {
        Solution_0209().solution_0209_test(8, removeArray1);
    }
    
    func solution_0216_test() {
        Solution_0216().test()
    }
    
    func solution_0222_test() {
        Solution_0222().test()
    }
    
    func solution_0226_test() {
        Solution_0226().test()
    }
    
    func solution_0257_test() {
        Solution_0257().test()
    }
    
    func solution_0344_test() {
        var ch = Array(string_1)
        Solution_0344().solution_0344_test(&ch)
    }
    
    func solution_0404_test() {
        Solution_0404().test()
    }
    
    func solution_0429_test() {
        Solution_0429().test()
    }
    
    func solution_0513_test() {
        Solution_0513().test()
    }
    
    func solution_0515_test() {
        Solution_0515().test()
    }
    
    func solution_0541_test() {
        Solution_0541().solution_0541_test(string_1, 2)
//        Solution_0541().solution_0541_test(string_2, 4)
    }
    
    func solution_0559_test() {
        Solution_0559().test()
    }
    
    func solution_0589_test() {
        Solution_0589().test()
    }
    
    func solution_0590_test() {
        Solution_0590().test()
    }
    
    func solution_0637_test() {
        Solution_0637().test()
    }
    
    func solution_0654_test() {
        Solution_0654().test()
    }
    
    func leetCode_0707Test() {
        let linkList = Solution_0707()
        linkList.addAtTail(1)
        print(linkList.get(0))
    }
    
    func solution_0958_test() {
        Solution_0958().solution_0958_test(tree1Root)
        Solution_0958().solution_0958_test(tree3Root)
        Solution_0958().solution_0958_test(tree4Root)
        Solution_0958().solution_0958_test(tree5Root)
        Solution_0958().solution_0958_test(tree6Root)
    }
}
