//
//  Offer_58_II.swift
//  LeetCode
//
//  Created by Du on 2021/8/30.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 剑指 Offer 58 - II. 左旋转字符串
 字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。请定义一个函数实现字符串左旋转操作的功能。比如，输入字符串"abcdefg"和数字2，该函数将返回左旋转两位得到的结果"cdefgab"。
 
 示例1：
 输入: s = "abcdefg", k = 2
 输出: "cdefgab"
 
 示例 2：
 输入: s = "lrloseumgh", k = 6
 输出: "umghlrlose"
 */


/********************解题********************/
class Offer_58_II {
    func reverseLeftWords(_ s: String, _ n: Int) -> String {
        var ch = Array(s)
        let len = ch.count
        // 反转区间[0, n - 1]
        reverseString(&ch, startIndex: 0, endIndex: n - 1)
        // 反转区间[n, len - 1]
        reverseString(&ch, startIndex: n, endIndex: len - 1)
        // 反转区间[0, len - 1]，也就是整个字符串反转
        reverseString(&ch, startIndex: 0, endIndex: len - 1)
        return String(ch)
    }
    
    func reverseString(_ s: inout [Character], startIndex: Int, endIndex: Int)  {
        var start = startIndex
        var end = endIndex
        while start < end {
            (s[start], s[end]) = (s[end], s[start])
            start += 1
            end -= 1
        }
    }
}

/********************测试代码********************/
extension Offer_58_II {
    func offer_58_II_test(_ s: String, _ n: Int) {
        print(reverseLeftWords(s, n))
    }
}
