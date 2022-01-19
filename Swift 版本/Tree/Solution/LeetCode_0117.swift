//
//  LeetCode_0117.swift
//  LeetCode
//
//  Created by Du on 2022/1/19.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 117. 填充每个节点的下一个右侧节点指针 II
 给定一个二叉树。二叉树定义如下：
 struct Node {
   int val;
   Node *left;
   Node *right;
   Node *next;
 }
 填充它的每个 next 指针，让这个指针指向其下一个右侧节点。如果找不到下一个右侧节点，则将 next 指针设置为 NULL。
 初始状态下，所有 next 指针都被设置为 NULL。
 */


/********************解题********************/
private extension TreeNode {
    private struct AssociatedKey {
        static var next: String = "TreeNode_Next"
    }
    
    var next: TreeNode? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.next) as? TreeNode
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.next, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

class Solution_0117 {
    // 迭代 - 层序遍历
    func connect(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        
        var queue = [root]
        
        while !queue.isEmpty {
            let size = queue.count
            
            for i in 0..<size {
                let firstNode = queue.removeFirst()
                
                // 1、在一层当中，最后的节点的next指针肯定是nil;
                // 2、因为上一步已经移除了数组最前面的元素，所以这个移出的元素的下一个元素，肯定是数组的第一个元素
                if i == (size - 1) {
                    firstNode.next = nil
                } else {
                    firstNode.next = queue.first
                }
                
                // 测试代码
                if let next = firstNode.next {
                    print("\(firstNode.val)->\(next.val)")
                } else {
                    print("\(firstNode.val)->nil")
                }
                
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
            }
        }
        
        return root
    }
}


/********************测试代码********************/
extension Solution_0117 {
    func test() {
        if let connectRoot = connect(tree5Root) {
            print(connectRoot)
        } else {
            print("Empty connectRoot")
        }
    }
}
