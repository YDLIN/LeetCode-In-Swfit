//
//  BST.swift
//  LeetCode
//
//  Created by Du on 2022/1/9.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
// 这个文件是二叉搜索树的定义
public class BST: BinaryTree {
    /// 使用迭代添加节点
    /// - Parameter value: 新节点的值
    public func add(_ value: Int) {
        // 1、如果根节点为空，则添加的元素就是根节点
        if root == nil {
            root = BinaryNode(value: value, parent: nil)
            nodeCount += 1
            return
        }
        
        // 2、如果根节点不为空
        var parent = root
        var node = root
        var cmp = 0
        // 比较
        while node != nil {
            // 在向左向右之前，先保存父节点
            parent = node
            
            if value > node!.value {
                cmp = 1
                node = node?.right
            } else if value < node!.value {
                cmp = -1
                node = node?.left
            } else {
                // 相等，需要覆盖旧值
                node?.value = value
                return
            }
        }
        
        // 3、找到父节点后，看看新的节点要插入到什么位置
        // 创建新的节点
        let newNode = BinaryNode(value: value, parent: parent)
        // 插入
        if cmp > 0 {
            parent?.right = newNode
        } else {
            parent?.left = newNode
        }
        
        // 4、节点数加一
        nodeCount += 1
    }
    
    /// 移除节点
    /// - Parameter element: 需要移除节点的值
    public func remove(element: Int) {
        remove(node: getNode(element: element))
    }
    
    /// 是否包含节点，，该函数时间复杂度是 O(logn)，推荐使用
    /// - Parameter element: 需要查找节点的值
    /// - Returns: true: 包含；false: 不包含
    public func contains(element: Int) -> Bool {
        return getNode(element: element) != nil
    }
    
    /// 是否包含节点，该函数时间复杂度是 O(n)，不推荐使用
    /// - Parameter value: 需要查找节点的值
    /// - Returns: true: 包含；false: 不包含
    public func contains(value: Int) -> Bool {
        guard root != nil else {
            return false
        }
        
        var found = false
        inorder {
            if $0 == value {
                found = true
            }
        }
        
        return found
    }
}

extension BST {
    /// 根据给定的值，来获取节点
    /// - Parameter element: 给定的值
    /// - Returns: 获取到的节点
    private func getNode(element: Int) -> BinaryNode? {
        var curNode = root
        while curNode != nil {
            if curNode!.value == element {
                return curNode
            } else if curNode!.value > element {// 要找的元素在左子树
                curNode = curNode?.left
            } else {// 要找的元素在右子树
                curNode = curNode?.right
            }
        }
        // 来到这里表示没找到，所以返回 nil
        return nil
    }
    
    /// 移除节点
    /// - Parameter node: 需要移除的节点
    private func remove(node: BinaryNode?) {
        if node == nil {
            return
        }
        
        var node = node
        
        // 节点数减1
        nodeCount -= 1
        
        // 度为2的节点需要特殊处理
        if node?.left != nil && node?.right != nil {
            // 找到度为2的节点的前驱节点（这里也可以用后驱节点）
            if let preNode = predecessor(node: node) {
                // 将前驱节点的值，覆盖度为2的节点的值
                node?.value = preNode.value
                /*
                 用 node 指向前驱节点，就是统一后面的删除操作。
                 因为传进来的参数 node，如果它不是度为2的节点，就不会进来这个 if 代码块
                 而是直接执行后面的删除操作
                 */
                node = preNode
            }
            
        }
        
        // 删除 node 节点（这里node的度，不是0，就是1）
        let replacementNode = node?.left != nil ? node?.left : node?.right
        
        /*
         一、度为1的节点,该节点所处的位置有一下三种情况：
            1、该节点是根节点
            2、该节点是左节点
            3、该节点是右节点
         二、replacementNode就是用来替换度为1的那个节点
         */
        if replacementNode != nil {
            // 替换节点的父节点
            replacementNode?.parent = node?.parent
            // 替换父节点的左节点或者右节点
            if node?.parent == nil {
                root = replacementNode
            } else if node == node?.parent?.left {// 如果删除的节点，是父节点的左节点，那替换节点应该也是父节点的左节点
                node?.parent?.left = replacementNode
            } else {// node == node.parent?.right
                node?.parent?.right = replacementNode
            }
        } else {//度为0的节点
            if node?.parent == nil {// node 是叶子节点，并且是根节点
                root = nil
            } else {// node 是叶子节点，但不是根节点
                if node == node?.parent?.left {// 如果要删除的叶子节点是处于左边
                    node?.parent?.left = nil
                } else {// 如果要删除的叶子节点是处于右边
                    node?.parent?.right = nil
                }
            }
        }
    }
}
