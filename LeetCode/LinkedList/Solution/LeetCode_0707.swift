//
//  LeetCode_0707.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/8/15.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation

/********************解题********************/
class Solution_0707 {
    // 虚拟的头节点
    var dummyHead: ListNode<Int>?
    var size: Int
    
    init() {
        dummyHead = ListNode(0)
        size = 0
    }
    
    func get(_ index: Int) -> Int {
        if index >= size || index < 0 {
            return -1
        }
        
        var curNode = dummyHead?.next
        var curIndex = index
        
        while curIndex > 0 {
            curNode = curNode?.next
            curIndex -= 1
        }
        
        return curNode?.value ?? -1
    }
    
    func addAtHead(_ val: Int) {
        // 新的头节点
        let newHead = ListNode(val)
        // 新的头节点的next指向旧的头节点
        newHead.next = dummyHead?.next
        // 更新虚拟节点
        dummyHead?.next = newHead
        size += 1
    }
    
    func addAtTail(_ val: Int) {
        // 新的节点
        let newNode = ListNode(val)
        
        var curNode = dummyHead
        
        while curNode?.next != nil {
            curNode = curNode?.next
        }
        
        curNode?.next = newNode
        size += 1
    }
    
    func addAtIndex(_ index: Int, _ val: Int) {
        if index > size {
            return
        }
        
        // 新的节点
        let newNode = ListNode(val)
        
        var curNode = dummyHead
        var curIndex = index
        
        // curNode是(index - 1)
        while curIndex > 0 {
            curNode = curNode?.next
            curIndex -= 1
        }
        
        // 插入新的节点
        // 插入后：curNode --------- newNode ------- curNode.next
        newNode.next = curNode?.next
        curNode?.next = newNode
        
        size += 1
    }
    
    func deleteAtIndex(_ index: Int) {
        if index >= size || index < 0 {
            return
        }
        
        var curNode = dummyHead
        for _ in 0..<index {
            curNode = curNode?.next
        }
        
        curNode?.next = curNode?.next?.next
        
        size -= 1
    }
}

/**
 * Your MyLinkedList object will be instantiated and called as such:
 * let obj = MyLinkedList()
 * let ret_1: Int = obj.get(index)
 * obj.addAtHead(val)
 * obj.addAtTail(val)
 * obj.addAtIndex(index, val)
 * obj.deleteAtIndex(index)
 */
