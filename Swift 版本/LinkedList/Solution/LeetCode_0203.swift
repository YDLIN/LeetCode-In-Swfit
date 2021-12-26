//
//  LeetCode_0203.swift
//  LeetCode
//
//  Created by Du on 2021/3/1.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 203. 移除链表元素
 给你一个链表的头节点 head 和一个整数 val ，请你删除链表中所有满足 Node.val == val 的节点，并返回 新的头节点 。

 示例:

 输入: 1->2->6->3->4->5->6, val = 6
 处理后的链表：1->2->3->4->5
 返回: 1
 */


/********************解题********************/
class Solution_0203 {
    /**
     * 添加虚节点方式
     */
    func removeElements(_ head: Node<Int>?, _ val: Int) -> Node<Int>? {
        // 新建一个虚拟头节点，它的 next 指向真实的头节点
        let dummyNode = Node(value: 0)
        dummyNode.next = head
        var currentNode = dummyNode
        
        while let curNext = currentNode.next {
            if curNext.value == val {
                currentNode.next = curNext.next
            } else {
                currentNode = curNext
            }
        }
        
        return dummyNode.next
    }
    
//    // 这个是返回新链表的头节点
//    func removeElements_2(_ head: Node<Int>?, _ val: Int) -> Node<Int>? {
//        // 新建一个虚拟头节点，它的 next 指向真实的头节点
//        let dummyNode = Node(value: 0)
//        dummyNode.next = head
//        var currentNode = dummyNode
//        // 新链表的头结点
//        var newHeadNode: Node<Int>? = nil
//
//        while let curNext = currentNode.next {
//            if curNext.value == val {
//                currentNode.next = curNext.next
//
//                if newHeadNode?.value == val {
//                    newHeadNode = nil
//                }
//
//                if newHeadNode == nil {
//                    newHeadNode = curNext.next
//                }
//            } else {
//                if newHeadNode == nil {
//                    newHeadNode = curNext
//                }
//                currentNode = curNext
//            }
//        }
//
//        return newHeadNode
//    }
}

/********************测试代码********************/
extension Solution_0203 {
    func solution_0203_test(_ head: Node<Int>?, _ val: Int) {
        print(removeElements(head, val)?.value as Any)
    }
}
