//
//  LeetCode_0151.swift
//  LeetCode
//
//  Created by Du on 2021/8/28.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 151. 翻转字符串里的单词
 给你一个字符串 s ，逐个翻转字符串中的所有 单词 。

 单词 是由非空格字符组成的字符串。s 中使用至少一个空格将字符串中的 单词 分隔开。

 请你返回一个翻转 s 中单词顺序并用单个空格相连的字符串。

 说明：
 输入字符串 s 可以在前面、后面或者单词间包含多余的空格。
 翻转后单词间应当仅用一个空格分隔。
 翻转后的字符串中不应包含额外的空格。
 
 示例 1：
 输入：s = "the sky is blue"
 输出："blue is sky the"
 
 示例 2：
 输入：s = "  hello world  "
 输出："world hello"
 解释：输入字符串可以在前面或者后面包含多余的空格，但是翻转后的字符不能包括。
 
 示例 3：
 输入：s = "a good   example"
 输出："example good a"
 解释：如果两个单词间有多余的空格，将翻转后单词间的空格减少到只含一个。
 
 示例 4：
 输入：s = "  Bob    Loves  Alice   "
 输出："Alice Loves Bob"
 
 示例 5：
 输入：s = "Alice does not even like bob"
 输出："bob like even not does Alice"
 */


/********************解题********************/
class Solution_0151 {
    func reverseWords(_ s: String) -> String {
        // 1
        var stringArr = removeSpace(s)
        // 2
        reverseString(&stringArr, startIndex: 0, endIndex: stringArr.count - 1)
        // 3
        reverseWord(&stringArr)
        
        return String(stringArr)
    }
    
    /// 移除多余的空格（前后所有的空格，中间只留一个空格）
    /// 使用双指针方法
    func removeSpace(_ s: String) -> [Character] {
        let ch = Array(s)
        var left = 0
        var right = ch.count - 1
        // 忽略字符串前面的所有空格
        // 前面是空格的话，就向右边移动指针，忽略当前空格
        while ch[left] == " " {
            left += 1
        }
        // 忽略字符串后面的所有空格
        // 后面是空格的话，就向左边移动指针，忽略当前空格
        while ch[right] == " " {
            right -= 1
        }

        // 经过上面的操作后，左指针指向字符串第一个非空格的字符，右指针指向最后一非空格的字符
        // 这样就删除了前后的所有空格了，接下来就是要处理中间的多余空格
        // 思路就是，新的字符串的最后一个字符，或者原字符串中，准备加到新字符串的那个字符，这两个字符当中，只要有一个不是空格，就可以加到新的字符串当中
        var lastArr = Array<Character>()
        while left <= right {
            // 准备加到新字符串当中的字符
            let char = ch[left]
            if char != " " || lastArr[lastArr.count - 1] != " "  {
                lastArr.append(char)
            }
            // 继续往右边遍历
            left += 1
        }
        
        return lastArr
    }
    
    /// 反正整个字符串
    func reverseString(_ s: inout [Character], startIndex: Int, endIndex: Int)  {
        var start = startIndex
        var end = endIndex
        while start < end {
            (s[start], s[end]) = (s[end], s[start])
            start += 1
            end -= 1
        }
    }
    
    /// 再次将字符串里面的单词反转
    func reverseWord(_ s: inout [Character]) {
        var start = 0
        var end = 0
        var entry = false
        
        for i in 0..<s.count {
            // 找到单词的起始位置
            if !entry {
                start = i
                entry = true
            }
            
            
            // 如果单词后面有空格，那这个空格就是分词符，遇到空格，就需要把 entry 设置成 false，因为此时已经出了单词区间了
            if entry && s[i] == " " && s[i - 1] != " " {
                // 确定单词终止的位置
                end = i - 1
                entry = false
                // 反转该单词
                reverseString(&s, startIndex: start, endIndex: end)
            }
            
            // 最后一个单词的末尾是没有空格的，到了最后一个字符，也需要把 entry 设置为 false，因为也出了单词区间了
            if entry && (i == s.count - 1) && s[i] != " " {
                end = i
                entry = false
                reverseString(&s, startIndex: start, endIndex: end)
            }
        }
    }
}

/********************测试代码********************/
extension Solution_0151 {
    func solution_0151_test(_ s: String) {
        print(reverseWords(s))
    }
}
