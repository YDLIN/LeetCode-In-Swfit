//
//  LeetCode_0106.swift
//  LeetCode
//
//  Created by Du on 2022/1/7.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation

/**
 题目：
 106. 从中序与后序遍历序列构造二叉树
 根据一棵树的中序遍历与后序遍历构造二叉树。
 */


/********************解题********************/
class Solution_0106 {
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        if inorder.count == 0 || postorder.count == 0 {
            return nil
        }
        
        // 后序遍历数组的最后一个元素，就是当前的根节点，也是切割中序遍历数组的中间节点
        guard let rootValue = postorder.last else {
            return nil
        }
        let root = TreeNode(rootValue)
        
        // 递归终止条件：如果是叶子节点，就返回
        if postorder.count == 1 {
            return root
        }
        
        // 找到中序遍历的切割点
        var leftInorder = [Int]()
        var rightInorder = [Int]()
        if let index = inorder.firstIndex(of: rootValue) {
            // 截取中序遍历数组
            leftInorder = Array(inorder.prefix(index))
            rightInorder = Array(inorder.suffix(inorder.count - index - 1))
        }
        
        // 完成截取数组后，需要删除后序遍历数组的最后一个元素
        var newPostorder = postorder
        newPostorder.removeLast()
        
        // 截取后序遍历数组
        let leftPostorder = Array(newPostorder.prefix(leftInorder.count))
        let rightPostorder = Array(newPostorder.suffix(newPostorder.count - leftInorder.count))
        
        // 确定左右节点
        root.left = buildTree(leftInorder, leftPostorder)
        root.right = buildTree(rightInorder, rightPostorder)
        return root
    }
    
    // 优化版本
    func buildTreeOptimize(inorder: [Int], inorderBegin: Int, inorderEnd: Int, postorder: [Int], postorderBegin: Int, postorderEnd: Int) -> TreeNode? {
        if postorderBegin == postorderEnd {
            return nil
        }
        
        /*
         后序遍历数组的最后一个元素，就是当前的根节点，也是切割中序遍历数组的中间节点
         这里的 postorder 是不会变的，所以我们通过 postorderEnd 的变化来获取后续遍历数组的最后一个元素
         */
        let rootValue = postorder[postorderEnd - 1]
        let root = TreeNode(rootValue)
        
        // 递归终止条件：如果是叶子节点，就返回
        if postorderEnd - postorderBegin == 1 {
            print("return: ")
            print(root.val)
            return root
        }
        
        // 分割中序遍历的数组，这里没有实际对数组进行截取操作
        // 但是我们可以用几个下标去模拟这个过程
        var delimiterIndex = 0 // 根节点的下标
        if let index = inorder.firstIndex(of: rootValue) {
            delimiterIndex = index
        }
        // 左中序区间，左闭右开[leftInorderBegin, leftInorderEnd)
        let leftInorderBegin = inorderBegin
        let leftInorderEnd = delimiterIndex
        // 右中序区间，左闭右开[rightInorderBeign, rightInorderEnd)
        // 这里加 1 是表示跳过根节点
        let rightInorderBeign = delimiterIndex + 1
        let rightInorderEnd = inorderEnd
        
        // 分割后序遍历的数组
        // 左后序区间，左闭右开[leftPostorderBegin, leftPostorderEnd)
        let leftPostorderBegin = postorderBegin
        /*
         postorderBegin: 表示后序遍历数组的开始
         leftInorderEnd - leftInorderBegin: 表示中序遍历数组的长度
         
         又因为后序数组的大小，一定是跟中序数组的大小一样，所以上述两项相加，就是后序数组的长度
        */
        let leftPostorderEnd = postorderBegin + leftInorderEnd - leftInorderBegin
        // 右后序区间，左闭右开[rightPostorderBeign, rightPostorderEnd)
        let rightPostorderBeign = leftPostorderEnd
        // 这里减 1 是表示跳过根节点（也就是后序遍历数组要删除最后一个元素）
        let rightPostorderEnd = postorderEnd - 1
        
        /***************调试代码*****************/
        print("----------")
        var leftInorderArr = [Int]()
        for i in leftInorderBegin..<leftInorderEnd {
            leftInorderArr.append(inorder[i])
        }
        print("leftInorder: ")
        print(leftInorderArr)
        
        print("root: \(rootValue)")
        
        var rightInorderArr = [Int]()
        for i in rightInorderBeign..<rightInorderEnd {
            rightInorderArr.append(inorder[i])
        }
        print("rightInorder: ")
        print(rightInorderArr)
        
        var leftPostorderArr = [Int]()
        for i in leftPostorderBegin..<leftPostorderEnd {
            leftPostorderArr.append(postorder[i])
        }
        print("leftPostorder: ")
        print(leftPostorderArr)
        
        var rightPostorderArr = [Int]()
        for i in rightPostorderBeign..<rightPostorderEnd {
            rightPostorderArr.append(postorder[i])
        }
        print("rightPostorder: ")
        print(rightPostorderArr)
        
        // 确定左右节点
        root.left = buildTreeOptimize(inorder: inorder,
                                      inorderBegin: leftInorderBegin,
                                      inorderEnd: leftInorderEnd,
                                      postorder: postorder,
                                      postorderBegin: leftPostorderBegin,
                                      postorderEnd: leftPostorderEnd)
        root.right = buildTreeOptimize(inorder: inorder,
                                       inorderBegin: rightInorderBeign,
                                       inorderEnd: rightInorderEnd,
                                       postorder: postorder,
                                       postorderBegin: rightPostorderBeign,
                                       postorderEnd: rightPostorderEnd)
        return root
    }
    
    // buildTreeOptimize的简洁版，没有性能上的提升，只是做了代码的删减而已
    func buildTreeOptimize2(inorder: [Int], inorderBegin: Int, inorderEnd: Int, postorder: [Int], postorderBegin: Int, postorderEnd: Int) -> TreeNode? {
        if postorderEnd - postorderBegin < 1 {
            return nil
        }
        
        let rootValue = postorder[postorderEnd - 1]
        let root = TreeNode(rootValue)
        
        if postorderEnd - postorderBegin == 1 {
            return root
        }
        
        // 从中序遍历数组中找到根节点的下标
        var delimiterIndex = 0
        if let index = inorder.firstIndex(of: rootValue) {
            delimiterIndex = index
        }
        
        root.left = buildTreeOptimize2(inorder: inorder,
                                      inorderBegin: inorderBegin,
                                      inorderEnd: delimiterIndex,
                                      postorder: postorder,
                                      postorderBegin: postorderBegin,
                                      postorderEnd: postorderBegin + (delimiterIndex - inorderBegin))
        
        root.right = buildTreeOptimize2(inorder: inorder,
                                       inorderBegin: delimiterIndex + 1,
                                       inorderEnd: inorderEnd,
                                       postorder: postorder,
                                       postorderBegin: postorderBegin + (delimiterIndex - inorderBegin),
                                       postorderEnd: postorderEnd - 1)
        return root
    }
}


/********************测试代码********************/
extension Solution_0106 {
    func test() -> TreeNode? {
        let inorder = [8, 12, 4, 2, 5, 1, 9, 6, 10, 3, 7, 11]
        let postorder = [12, 8, 4, 5, 2, 9, 10, 6, 11, 7, 3, 1]
        if let node = buildTree(inorder, postorder) {
            print(node)
            return node
        }
        return nil
    }
    
    func test2() -> TreeNode? {
        var inorder = [Int]()
        var postorder = [Int]()
        let condition = 0
        if condition > 0 {
            inorder = [8, 12, 4, 2, 5, 1, 9, 6, 10, 3, 7, 11]
            postorder = [12, 8, 4, 5, 2, 9, 10, 6, 11, 7, 3, 1]
        } else {
            inorder = [4, 2, 5, 1, 6, 3]
            postorder = [4, 5, 2, 6, 3, 1]
        }
        if let node = buildTreeOptimize(inorder: inorder,
                                        inorderBegin: 0,
                                        inorderEnd: inorder.count,
                                        postorder: postorder,
                                        postorderBegin: 0,
                                        postorderEnd: postorder.count) {
            print(node)
            return node
        }
        return nil
    }
}
