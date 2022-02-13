//
//  LeetCode_0017.swift
//  LeetCode
//
//  Created by Du on 2022/2/13.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
import OpenGL
/**
 题目：
 17. 电话号码的字母组合
 给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。答案可以按 任意顺序 返回。
 给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。
 */


/********************解题********************/
class Solution_0017 {
    // 数字按键跟字母的映射
    private let letterMap = ["", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]
    
    // 存放符合条件结果的集合
    var result = [String]()
    var s = ""
    
    func backTracking(_ digits: String, _ index: Int) {
        // 终止条件
        if index == digits.count {
            result.append(s)
            return
        }
        
        let digitIndex = digits.index(digits.startIndex, offsetBy: index)
        let digit = digits[digitIndex]
        if let intValue = digit.wholeNumberValue {
            // 通过映射表，取出数字号码对应的字母
            let letters = letterMap[intValue]
            
            for letter in letters {
                s.append(letter)
                // index + 1是表示要处理下一个号码了
                backTracking(digits, index + 1)
                s.removeLast()
            }
        }
    }
    
    func letterCombinations(_ digits: String) -> [String] {
        if digits.count == 0 {
            return result
        }
        if digits.contains("*") || digits.contains("#") || digits.contains("0") || digits.contains("1") {
            return result
        }
        
        backTracking(digits, 0)
        return result
    }
    
    // 录友的解法，巧妙之处在于：按键字符串转按键数字数组，利用 Swif 的特性
    func letterCombinations2(_ digits: String) -> [String] {
        // 按键与字母串映射
        let letterMap = [
            "",
            "", "abc", "def",
            "ghi", "jkl", "mno",
            "pqrs", "tuv", "wxyz"
        ]
        // 把输入的按键字符串转成Int数组
        // 算出0的 ASCII 值
        let baseCode = ("0" as Character).asciiValue!
        let digits = digits.map {
            // 再算出 digits 元素对应的 ASCII 值
            guard let code = $0.asciiValue else { return -1 }
            // 用两个 ASCII 值相减，来表示输入的数字，因为*，#的 ASCII 值比0的 ASCII 值小，所以 code - baseCode 会崩溃
            return Int(code - baseCode)
        }.filter { $0 >= 0 && $0 <= 9 }
        
        guard !digits.isEmpty else { return [] }

        var result = [String]()
        var s = ""
        func backtracking(index: Int) {
            // 结束条件：收集结果
            if index == digits.count {
                result.append(s)
                return
            }

            // 遍历当前按键对应的字母串
            let letters = letterMap[digits[index]]
            for letter in letters {
                s.append(letter) // 处理
                backtracking(index: index + 1) // 递归，记得+1
                s.removeLast() // 回溯
            }
        }
        backtracking(index: 0)
        return result
    }
}

/********************测试代码********************/
extension Solution_0017 {
    func test() {
        print(letterCombinations2("23"))
    }
}
