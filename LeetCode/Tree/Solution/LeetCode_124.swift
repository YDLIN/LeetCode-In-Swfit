//
//  LeetCode_124.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/1/24.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 124. 二叉树中的最大路径和
 路径:被定义为一条从树中任意节点出发，沿父节点-子节点连接，达到任意节点的序列。该路径至少包含一个节点，且不一定经过根节点。

 路径和:是路径中各节点值的总和。

 给你一个二叉树的根节点root，返回其最大路径和。
 */


/********************解题********************/
class Solution_124 {
    /**
     maxSum的作用就是，保存当前节点的最大路径和
     1、按道理，一棵树的最大路径和是：该节点的左子树的和 + 右子树的和 + 该节点的值；但是这种前提是三个数都为正的情况下成立
     2、所以假设所有节点的数值都是正数，叶节点的最大路径，就是他自己的值（因为他的左右子树都为0）
     3、但是我们没办法保证全部节点都是正数，有可能根节点是大于0，但是左右子树的值是小于0，那如果左右根三个加起来的数值比单单一个根节点还要小
     4、所以这里的maxSum的初始化是取Int类型的最小值，这样就比较符合；然后第一次每次递归一个节点，maxSum都保存该节点的最大路径和，并和上次的不包含本次递归节点的最大路径比较，最后取最大值
     */
    var maxSum = Int.min
    func maxPathSum(_ root: TreeNode?) -> Int {
        guard let rootNode = root else {
            return 0
        }
        
        //这里为什么要跟0做对比，以为你如果一个节点的左（右）子树的值小于0，那加上这个小于0的数字，比当前值还要小，那就没必要了，所以取0是最合适了
        let left = max(0, maxPathSum(rootNode.left))
        let right = max(0, maxPathSum(rootNode.right))
        
        print("left = \(left)")
        print("right = \(right)")
        print("root = \(rootNode.val)")
        print("before: maxSum = \(maxSum)")
        maxSum = max(maxSum, left + right + rootNode.val)
        print("current sum = \(left + right + rootNode.val)")
        print("after: maxSum = \(maxSum)")
        print("return value = \(max(left, right) + rootNode.val)")
        print("-----------------")
        /*
         每次返回当前节点左右子树两者的最大值 + 当前节点的值，这样就能返回较大的那条路径了
         所以：
         当前节点是8的话，就是得出最大值是12 + 8这条路径，放弃了0 + 8这条路径了；
         当前节点是4的话，就是得出最大值是12 + 8 + 4这条路径，放弃了0 + 4这条路径了；
         当前节点是5的话，就是得出最大值是他自己；
         当前节点是2的话，就是得出最大值是12 + 8 + 4 + 2这条路径，放弃了5 + 2这条路径了；
         ...
         当前节点是1的话，就是得出最大值是12 + 8 + 4 + 2 + 1这条路径，放弃了11 + 7 + 3 + 1这条路径了；
         */
        return max(left, right) + rootNode.val
    }
    
    /**
     总结：
     本题的要点是，maxSum用来保存保存当前节点的最大路径和；函数体的返回值是返回左右子树中的最大值+自己；所以maxSum是用left + right + value来确定的，而返回值是取left、right中的最大值 + 自己
     */
}

extension Solution_124 {
    func solution_124_test(_ node: TreeNode) {
        let _ = self.maxPathSum(node)
        
        print("\(type(of: self)): maxPathSum: \(self.maxSum)")
    }
}


