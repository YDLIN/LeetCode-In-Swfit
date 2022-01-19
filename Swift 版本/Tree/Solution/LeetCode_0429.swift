//
//  LeetCode_0429.swift
//  LeetCode
//
//  Created by Du on 2021/1/27.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 429. N 叉树的层序遍历
 给定一个 N 叉树，返回其节点值的层序遍历。（即从左到右，逐层遍历）。
 树的序列化输入是用层序遍历，每组子节点都由 null 值分隔（参见示例）。
 */


/********************解题********************/
class Solution_0429 {
    func levelOrder(_ root: NTreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        
        var resultArray = [[Int]]()
        var queue = [root]
        
        while !queue.isEmpty {
            var levelArray = [Int]()
            
            for _ in 0..<queue.count {
                let firstNode = queue.removeFirst()
                levelArray.append(firstNode.val)
                
                // n叉树因为不确定有多少个子节点，所以不是获取它的左右子节点，而是遍历它的所有子节点
//                _ = firstNode.children.map {
//                    queue.append($0)
//                }
                for subNode in firstNode.children {
                    queue.append(subNode)
                }
            }
            resultArray.append(levelArray)
        }
        return resultArray
    }
}


/********************测试代码********************/
extension Solution_0429 {
    func test() {
        print(levelOrder(nTree2Root))
    }
}
