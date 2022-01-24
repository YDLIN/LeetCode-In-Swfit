//
//  LeetCode_0654.swift
//  LeetCode
//
//  Created by Du on 2022/1/24.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
/**
 题目：
 654. 最大二叉树
 给定一个不含重复元素的整数数组 nums 。一个以此数组直接递归构建的 最大二叉树 定义如下：

 二叉树的根是数组 nums 中的最大元素。
 左子树是通过数组中 最大值左边部分 递归构造出的最大二叉树。
 右子树是通过数组中 最大值右边部分 递归构造出的最大二叉树。
 返回有给定数组 nums 构建的 最大二叉树 。
 */


/********************解题********************/
class Solution_0654 {
    func constructMaximumBinaryTree(_ nums: inout [Int]) -> TreeNode? {
        return traversal(&nums, 0, nums.count)
    }
    
    // 在左闭右开区间[left, right)，构造二叉树
    func traversal(_ nums: inout [Int], _ left: Int, _ right: Int) -> TreeNode? {
        if left >= right {
            return nil
        }
        
        // 确定分割点的下标（找出最大值的下标）
        var maxValueIndex = left
        for i in (left + 1)..<right {
            if nums[i] > nums[maxValueIndex] {
                maxValueIndex = i
            }
        }
        
        // 最大值就是根节点
        let root = TreeNode(nums[maxValueIndex])
        
        // 通过递归，找到左子树的最大值（找左子树的根节点）
        root.left = traversal(&nums, left, maxValueIndex)
        root.right = traversal(&nums, maxValueIndex + 1, right)
        return root
    }
}


/********************测试代码********************/
extension Solution_0654 {
    func test() {
        var preorder = [11, 10, 7]
        var inorder = [8, 9, 4, 2, 5, 1, 12, 6, 10, 3, 7, 11]
        if let tree = constructMaximumBinaryTree(&inorder) {
            print(tree)
        }
    }
}
