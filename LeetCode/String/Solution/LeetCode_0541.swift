//
//  LeetCode_0541.swift
//  LeetCode
//
//  Created by Du on 2021/8/26.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 344. 反转字符串
 给定一个字符串 s 和一个整数 k，从字符串开头算起，每 2k 个字符反转前 k 个字符。
 如果剩余字符少于 k 个，则将剩余字符全部反转。
 如果剩余字符小于 2k 但大于或等于 k 个，则反转前 k 个字符，其余字符保持原样。
 思路：
 其实这题的意思就是：每隔2k个元素，就反转前k个；尾数不够k个的时候，全部反转
 */


/********************解题********************/
class Solution_0541 {
    // 解法一
//    func reverseStr(_ s: String, _ k: Int) -> String {
//
//        return s
//    }
    
    // 解法二
    func reverseStr(_ s: String, _ k: Int) -> String {
        var ch = Array(s)
        
        for i in stride(from: 0, to: ch.count, by: 2 * k) {
            var left = i
            // 这里是判断尾数够不够k个来决定end指针的位置
            // 如果start + k - 1小于字符串长度，则表明是够k个，否则不够
            var right = min(s.count - 1, left + k - 1)
            
            // 反转字符串，跟344题类似
            while left < right {
                // 交换两个值
                (ch[left], ch[right]) = (ch[right], ch[left])
                // 左边指针往右走，缩小范围
                left += 1
                // 右边指针往左走，缩小范围
                right -= 1
            }
        }
        return String(ch)
    }
}

/********************测试代码********************/
extension Solution_0541 {
    func solution_0541_test(_ s: String, _ k: Int) {
        print(reverseStr(s, k))
    }
}
