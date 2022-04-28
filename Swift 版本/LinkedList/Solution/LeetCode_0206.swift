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
class Solution_0206 {
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
    /*
     几个关键思考点：
     1. 如果要反转，那就需要将 cur 的 next 反过来，指向 pre，但是这样做，在下次再做同样的动作时，cur 不知道指向哪里了，所以在让 cur.next 指向新的元素的时候，
     先用临时变量保存起来：
     tmp = cur?.next
     2. cur 指针需要不断的向前移动，所以这里就确定了循环的条件就是 cur 不为空
     */
    func reverseList(_ head: Node<Int>?) -> Node<Int>? {
        // 如果是空链表，或者只有一个元素的链表
        if head == nil || head?.next == nil {
            return head
        }
        var cur = head
        var tmp: Node<Int>?
        var pre: Node<Int>?
        
        while cur != nil {
            // 保存临时值之后，就可以翻转链表了
            tmp = cur?.next
            cur?.next = pre
            // 此时已经反转了，所以下一步就是要让两个指针向前移动，不断重复
            pre = cur
            cur = tmp
        }
        
        // 当 cur（快指针） 为空，那就表明已经反转完毕了，此时 pre （慢指针），比 cur 慢一步，所以它就是反转后的链表的头节点
        return pre
    }
    
    // 递归法
    func reverseList_2(_ head: Node<Int>?) -> Node<Int>? {
        // 和双指针法初始化一样
        // var cur = head
        // var pre: Node<Int>? = nil
        return reverse(nil, head)
    }
    
    func reverse(_ pre: Node<Int>?, _ cur: Node<Int>?) -> Node<Int>? {
        // 这表明是空链表，这里不需要像双指针那样继续判断 cur.next 是不是为nil
        // 因为即使当前的 cur.next 为空，那在下次递进的时候，传进来的 cur (也就是上次的 cur.next) 也为nil
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
}

/********************测试代码********************/
extension Solution_0206 {
    func solution_0206_test(_ head: Node<Int>?) {
        let newHead = reverseList_2(head)
        print(newHead?.value)
    }
}
