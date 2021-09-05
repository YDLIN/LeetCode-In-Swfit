//
//  LeetCode_0344.swift
//  LeetCode
//
//  Created by Du on 2021/8/23.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 344. 反转字符串
 编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 char[] 的形式给出。
 不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
 你可以假设数组中的所有字符都是 ASCII 码表中的可打印字符。
 */


/********************解题********************/
class Solution_0344 {
    func reverseString(_ s: inout [Character]) {
        var l = 0
        var r = s.count - 1
        while l < r {
//            let tmp = s[l]
//            s[l] = s[r]
//            s[r] = tmp
            // 使用元祖
            (s[l], s[r]) = (s[r], s[l])
            l += 1
            r -= 1
        }
        
        print(s)
    }
}

/********************测试代码********************/
extension Solution_0344 {
    func solution_0344_test(_ s: inout [Character]) {
        reverseString(&s)
    }
}
