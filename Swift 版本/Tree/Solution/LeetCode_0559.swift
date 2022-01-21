//
//  LeetCode_0559.swift
//  LeetCode
//
//  Created by Du on 2022/1/20.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 559. N 叉树的最大深度
 给定一个 N 叉树，找到其最大深度。
 */


/********************解题********************/
class Solution_0559 {
    // 使用层序遍历
    func maxDepth(_ root: NTreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        var queue = [root]
        var depth = 0
        while !queue.isEmpty {
            let size = queue.count
            depth += 1
            for _ in 0..<size {
                let firstNode = queue.removeFirst()
                
                for subNode in firstNode.children {
                    queue.append(subNode)
                }
            }
        }
        return depth
    }
    
    // 使用递归
    func maxDepth_2(_ root: NTreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        var depth = 0
        for subNode in root.children {
            depth = max(maxDepth_2(subNode), depth)
        }
        return depth + 1
    }
}


/********************测试代码********************/
extension Solution_0559 {
    func test() {
        print(maxDepth(nTree2Root))
        print(maxDepth_2(nTree2Root))
    }
}
