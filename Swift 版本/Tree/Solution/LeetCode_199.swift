//
//  LeetCode_199.swift
//  LeetCode
//
//  Created by Du on 2021/1/27.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 199. 二叉树的右视图
 给定一棵二叉树，想象自己站在它的右侧，按照从顶部到底部的顺序，返回从右侧所能看到的节点值。
 */


/********************解题********************/
class Solution_199 {
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let rootNode = root else {
            return []
        }
        
        var resultArray = [[Int]]()
        var queue: [TreeNode] = [rootNode]
        
        while !queue.isEmpty {
            var levelArray = [Int]()
            let size = queue.count
            for _ in 0..<size {
                
                let firstNode = queue.removeFirst()
                levelArray.append(firstNode.val)
                
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
            }
            resultArray.append(levelArray)
        }
        
        //取出每一层最后那个元素，就是每一层最右边的元素
        var rightSidlArray = [Int]()
        for item in resultArray {
            if let value = item.last {
                rightSidlArray.append(value)
            }
        }
        
        return rightSidlArray
    }
    
    // 方法2比方法1要好
    func rightSideView_2(_ root: TreeNode?) -> [Int] {
        guard let rootNode = root else {
            return []
        }
        
        var queue: [TreeNode] = [rootNode]
        var rightSidlArray = [Int]()
        
        while !queue.isEmpty {
            let size = queue.count
            for i in 0..<size {
                let firstNode = queue.removeFirst()
                
                if i == (size - 1) {//每一层最后的那个元素，就是最右侧的元素
                    rightSidlArray.append(firstNode.val)
                }
                
                if let leftNode = firstNode.left {
                    queue.append(leftNode)
                }
                
                if let rightNode = firstNode.right {
                    queue.append(rightNode)
                }
            }
        }
        
        return rightSidlArray
    }
}


/********************测试代码********************/
extension Solution_199 {
    func solution_199_test(_ node: TreeNode?) {
        let resultArray = self.rightSideView(node)
        print(resultArray)
    }
}
