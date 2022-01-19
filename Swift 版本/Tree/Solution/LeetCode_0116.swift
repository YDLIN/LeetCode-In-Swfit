//
//  LeetCode_0116.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/1/31.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 116. 填充每个节点的下一个右侧节点指针
 给定一个 完美二叉树 ，其所有叶子节点都在同一层，每个父节点都有两个子节点。二叉树定义如下：
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

class Solution_0116 {
    // 递归 - 前序遍历
    func connect(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        
        connectNearNode(left: root.left, right: root.right)
        
        return root
    }
    
    func connectNearNode(left: TreeNode?, right: TreeNode?) {
        guard let node1 = left, let node2 = right  else {
            return
        }
        
        node1.next = node2
        connectNearNode(left: node1.left, right: node1.right)
        connectNearNode(left: node2.left, right: node2.right)
        connectNearNode(left: node1.right, right: node2.left)
    }
    
    
    // 迭代 - 层序遍历
    func levelOrderConnect(_ root: TreeNode?) -> TreeNode? {
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
extension Solution_0116 {
    func test() {
        if let connectRoot = levelOrderConnect(tree3Root) {
            print(connectRoot)
        } else {
            print("Empty connectRoot")
        }
    }
}
