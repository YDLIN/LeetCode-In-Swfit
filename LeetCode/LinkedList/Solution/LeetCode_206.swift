//
//  LeetCode_206.swift
//  LeetCode
//
//  Created by Du on 2021/4/8.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 206. 反转链表
 反转一个单链表。

 示例:
 输入: 1->2->3->4->5->NULL
 输出: 5->4->3->2->1->NULL
 返回：返回反转后的头结点
 */


/********************解题********************/
class Solution_206 {
    /*
     反转前：
     head
      ↓
     1 → 2 → 3 → 4 → 5 → nil
     
     反转后：
                          head
                           ↓
     nil ← 5 ← 4 ← 3 ← 2 ← 1
     
     反转过程：
     pre  cur
      ↓    ↓
     nil   1 → 2 → 3 → 4 → 5 → nil
     */
    
    // 双指针法
    func reverseList(_ head: Node<Int>?) -> Node<Int>? {
        var temp: Node<Int>? = nil
        var cur = head
        var pre: Node<Int>? = nil
        
        while (cur != nil) {
            // 保存cur的下一个节点
            temp = cur?.next
            // 开始反转
            cur?.next = pre
            
            // 更新pre指针 和 cur指针
            pre = cur
            cur = temp
        }
        
        return pre
    }
    
    // 递归法
    func reverse(_ pre: Node<Int>?, _ cur: Node<Int>?) -> Node<Int>? {
        if cur == nil {
            return pre
        }
        let temp = cur?.next
        cur?.next = pre
        // 这里的递归其实相当于双指针法的这两个步骤
        // pre = cur
        // cur = temp
        return reverse(cur, temp)
    }
    
    func reverseList_2(_ head: Node<Int>?) -> Node<Int>? {
        // 和双指针法初始化一样
        // var cur = head
        // var pre: Node<Int>? = nil
        return reverse(nil, head)
    }
}

/********************测试代码********************/
extension Solution_206 {
    func solution_206_test(_ head: Node<Int>?) {
        let newHead = reverseList_2(head)
        print(newHead?.value)
    }
}
