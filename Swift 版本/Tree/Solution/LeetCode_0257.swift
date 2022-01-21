//
//  LeetCode_0257.swift
//  LeetCode
//
//  Created by Du on 2022/1/20.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 257. 二叉树的所有路径
 给你一个二叉树的根节点 root ，按 任意顺序 ，返回所有从根节点到叶子节点的路径。
 */


/********************解题********************/
class Solution_0257 {
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var result = Array<String>()
        var path = Array<Int>()
        guard let root = root else {
            return result
        }
        traversal(root, &path, &result)
        return result
    }
    
    func traversal(_ cur: TreeNode, _ path: inout Array<Int>, _ result: inout Array<String>) {
        // 每访问一个节点，都要放到 path 中
        path.append(cur.val)
        // 递归终止条件：到达叶子节点
        if cur.left == nil && cur.right == nil {
            var pathString = ""
            // 处理 path 前面的元素
            for i in 0..<path.count - 1 {
                let value = path[i]
                pathString += String(value)
                pathString += "->"
            }
            // 处理 path 最后一个元素
            if let lastValue = path.last {
                pathString += String(lastValue)
            }
            // 将路径存到数组中
            result.append(pathString)
            return
        }
        
        // 空节点不进入递归循环
        if let leftNode = cur.left {
            traversal(leftNode, &path, &result)
            /*
             找到一条路径后，就需要回溯了。
             删除路径最后一个节点（也就是叶子节点），会回到它的根节点，这样才能进行下一步，去查找该根节点的右子树的路径
             */
            path.removeLast()
        }
        
        if let rightNode = cur.right {
            traversal(rightNode, &path, &result)
            path.removeLast()
        }
    }
    
    func binaryTreePaths_2(_ root: TreeNode?) -> [String] {
        // 保存树的遍历节点
        var treeStack = [TreeNode]()
        // 保存遍历路径的节点
        var pathStack = [String]()
        // 保存最终路径集合
        var result = [String]()
        guard let root = root else {
            return result
        }
        treeStack.append(root)
        pathStack.append(String(root.val))
        while !treeStack.isEmpty {
            let node = treeStack.removeLast()
            let path = pathStack.removeLast()
            
            // 遇到叶子节点
            if node.left == nil && node.right == nil {
                result.append(path)
            }
            
            if let rightNode = node.right {
                treeStack.append(rightNode)
                let tmp = path + "->" + String(rightNode.val)
                pathStack.append(tmp)
            }
            
            if let leftNode = node.left {
                treeStack.append(leftNode)
                let tmp = path + "->" + String(leftNode.val)
                pathStack.append(tmp)
            }
        }
        
        return result
    }
}


/********************测试代码********************/
extension Solution_0257 {
    func test() {
        print(binaryTreePaths_2(tree10Root))
    }
}
