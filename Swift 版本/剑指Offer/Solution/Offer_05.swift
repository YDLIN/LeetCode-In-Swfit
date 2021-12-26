//
//  Offer_05.swift
//  LeetCode
//
//  Created by Du on 2021/8/27.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 剑指 Offer 05. 替换空格
 请实现一个函数，把字符串 s 中的每个空格替换成"%20"。
 示例1：
 输入：s = "We are happy."
 输出："We%20are%20happy."
 */


/********************解题********************/
class Offer_05 {
    func replaceSpace(_ s: String) -> String {
        // 字符串转数组
        var strArr = Array(s)
        var count = 0
        
        // 统计空格的个数
        for i in strArr {
            if i == " " {
                count += 1
            }
        }
        // left 指向旧数组的最后一个元素
        var left = strArr.count - 1
        // right 指向扩容后数组的最后一个元素（这里还没对数组进行实际上的扩容）
        //（这里其实相当于对原来的数组进行了扩容，每个空格变成%20，那就相当于每遇到一空格，数组就需要扩容2个长度）
        var right = strArr.count + count * 2 - 1
        
        // 实际对数组扩容
        for _ in 0..<(count * 2) {
            strArr.append(" ")
        }
        
        while left < right {
            // 左指针开始往左边走（也就是从后往前遍历数组，从后往前，可以防止每个元素都移动，减少时间复杂度）
            // 如果遇到空格，则从后往前依次替换成0，2，%，
            if strArr[left] == " " {
                strArr[right] = "0"
                strArr[right - 1] = "2"
                strArr[right - 2] = "%"
                left -= 1
                right -= 3
            } else {// 如果不是空格，则用左指针的值填充右指针的位置，
                strArr[right] = strArr[left]
                // 左右指针同时往左移动1，逐渐缩小范围
                left -= 1
                right -= 1
            }
        }
        
        return String(strArr)
    }
}

/********************测试代码********************/
extension Offer_05 {
    func offer_05_test(_ s: String) {
        print(replaceSpace(s))
    }
}
