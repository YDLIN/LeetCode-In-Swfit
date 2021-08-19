//
//  TreeTestData.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/1/24.
//  Copyright © 2021 Du. All rights reserved.
//


import Foundation
/**
 此文件包含了二叉树、N叉树测试所需要的节点数据
 /********************二叉树测试用例********************/
 // 树-1
 [1,2,3,4,5,6,7,8,null,null,null,9,10,null,11,null,12]
 
                   (1)
                /      \
              (2)      (3)
             /   \    /   \
           (4)   (5) (6)  (7)
           /        /   \    \
        (8)       (9)  (10) (11)
          \
         (12)
 
 // 树-2
 [1,3,2,5,3,null,9]
 
                  (1)
                /     \
              (3)     (2)
             /   \       \
           (5)   (4)     (9)
 
 // 树-3（完美二叉树）
 [1,2,3,4,5,6,7]
 
                  (1)
                /     \
              (2)     (3)
             /   \   /   \
           (4)   (5)(6)  (7)
 
 
 
 /********************N叉树测试用例********************/
 // 树-1
 [1,null,2,3,4,5,null,null,6,7,null,8,null,9,10,null,null,11,null,12,null,13,null,null,14]
 
                  (1)
            /   |    |    \
          (2)  (3)  (4)   (5)
              /  \   |   /   \
            (6)  (7)(8) (9) (10)
                  |  |   |
                (11)(12)(13)
                  |
                (14)
 
 // 树-2
 [1,null,3,2,4,null,5,6]
 
                  (1)
                /  |  \
              (3) (2) (4)
             /   \
           (5)   (6)
 
 // 树-3
 [11,null,10,9,6,null,9,8,5,null,null,5,4,1,null,null,null,4,3,0,null,null,3,2,-1]
 
                  (11)
             /      |     \
           (10)    (9)    (6)
          / | \          / | \
        (9)(8)(5)      (5)(4)(1)
             / | \       / | \
           (4)(3)(0)   (3)(2)(-1)
 
 
 // 树-4
 [1,null,6,9,7,null,9,8,-3,null,null,5,1,null,null,null,4,0,null,null,3,2,-1]
 
                  (1)
             /     |     \
           (6)    (9)    (7)
          / | \         /   \
        (9)(8)(-3)    (5)   (1)
              /  \         / | \
            (4)  (0)     (3)(2)(-1)
 */

/// 节点（类实现）
let nodeK_class = BinaryTreeClass("K")
let nodeJ_class = BinaryTreeClass("J")
let nodeI_class = BinaryTreeClass("I")
let nodeH_class = BinaryTreeClass("H", nil, nodeK_class)
let nodeG_class = BinaryTreeClass("G", nil, nodeJ_class)
let nodeF_class = BinaryTreeClass("F", nodeI_class, nil)
let nodeE_class = BinaryTreeClass("E")
let nodeD_class = BinaryTreeClass("D", nodeH_class, nil)
let nodeC_class = BinaryTreeClass("C", nodeF_class, nodeG_class)
let nodeB_class = BinaryTreeClass("B", nodeD_class, nodeE_class)
let nodeA_class = BinaryTreeClass("A", nodeB_class, nodeC_class)

/// 节点（枚举实现）
let nodeK_enum = BinaryTreeEnum.node(.empty, "K", .empty)
let nodeH_enum = BinaryTreeEnum.node(.empty, "H", nodeK_enum)
let nodeI_enum = BinaryTreeEnum.node(.empty, "I", .empty)
let nodeJ_enum = BinaryTreeEnum.node(.empty, "J", .empty)
let nodeD_enum = BinaryTreeEnum.node(nodeH_enum, "D", .empty)
let nodeE_enum = BinaryTreeEnum.node(.empty, "E", .empty)
let nodeF_enum = BinaryTreeEnum.node(nodeI_enum, "F", .empty)
let nodeG_enum = BinaryTreeEnum.node(.empty, "G", nodeJ_enum)
let nodeB_enum = BinaryTreeEnum.node(nodeD_enum, "B", nodeE_enum)
let nodeC_enum = BinaryTreeEnum.node(nodeF_enum, "C", nodeG_enum)
let nodeA_enum = BinaryTreeEnum.node(nodeB_enum, "A", nodeC_enum)


/********************二叉树节点（应用在LeetCode题目上）********************/
// 二叉树：测试树-1
let tree1Node12 = TreeNode(12, nil, nil)
let tree1Node08 = TreeNode(8, nil, tree1Node12)
let tree1Node09 = TreeNode(9, nil, nil)
let tree1Node10 = TreeNode(10, nil, nil)
let tree1Node11 = TreeNode(11, nil, nil)
let tree1Node04 = TreeNode(4, tree1Node08, nil)
let tree1Node05 = TreeNode(5, nil, nil)
let tree1Node06 = TreeNode(6, tree1Node09, tree1Node10)
let tree1Node07 = TreeNode(7, nil, tree1Node11)
let tree1Node02 = TreeNode(2, tree1Node04, tree1Node05)
let tree1Node03 = TreeNode(3, tree1Node06, tree1Node07)
let tree1Node01 = TreeNode(1, tree1Node02, tree1Node03)

// 二叉树：测试树-2
let tree2Node05 = TreeNode(5, nil, nil)
let tree2Node04 = TreeNode(4, nil, nil)
let tree2Node09 = TreeNode(9, nil, nil)
let tree2Node03 = TreeNode(3, tree2Node05, tree2Node04)
let tree2Node02 = TreeNode(2, nil, tree2Node09)
let tree2Node01 = TreeNode(1, tree2Node03, tree2Node02)

// 二叉树：测试树-3（完美二叉树）
let tree3Node04 = TreeNode(4, nil, nil)
let tree3Node05 = TreeNode(5, nil, nil)
let tree3Node06 = TreeNode(6, nil, nil)
let tree3Node07 = TreeNode(7, nil, nil)
let tree3Node02 = TreeNode(2, tree3Node04, tree3Node05)
let tree3Node03 = TreeNode(3, tree3Node06, tree3Node07)
let tree3Node01 = TreeNode(1, tree3Node02, tree3Node03)


/********************N叉树节点（应用在LeetCode题目上））********************/
// N叉树：测试树-1
let nTree1Node14 = NTreeNode(14)
let nTree1Node11 = NTreeNode(11, [nTree1Node14])
let nTree1Node12 = NTreeNode(12)
let nTree1Node13 = NTreeNode(13)
let nTree1Node06 = NTreeNode(6)
let nTree1Node07 = NTreeNode(7, [nTree1Node11])
let nTree1Node08 = NTreeNode(8, [nTree1Node12])
let nTree1Node09 = NTreeNode(9, [nTree1Node13])
let nTree1Node10 = NTreeNode(10)
let nTree1Node02 = NTreeNode(2)
let nTree1Node03 = NTreeNode(3, [nTree1Node06, nTree1Node07])
let nTree1Node04 = NTreeNode(4, [nTree1Node08])
let nTree1Node05 = NTreeNode(5, [nTree1Node09, nTree1Node10])
let nTree1Node01 = NTreeNode(1, [nTree1Node02, nTree1Node03, nTree1Node04, nTree1Node05])

// N叉树：测试树-2
let nTree2Node05 = NTreeNode(5)
let nTree2Node06 = NTreeNode(6)
let nTree2Node03 = NTreeNode(3, [nTree2Node05, nTree2Node06])
let nTree2Node02 = NTreeNode(2)
let nTree2Node04 = NTreeNode(4)
let nTree2Node01 = NTreeNode(1, [nTree2Node03, nTree2Node02, nTree2Node04])

// N叉树：测试树-3
let nTree3Node16 = NTreeNode(4)
let nTree3Node15 = NTreeNode(3)
let nTree3Node14 = NTreeNode(0)
let nTree3Node13 = NTreeNode(3)
let nTree3Node12 = NTreeNode(2)
let nTree3Node11 = NTreeNode(-1)
let nTree3Node10 = NTreeNode(9)
let nTree3Node09 = NTreeNode(8)
let nTree3Node08 = NTreeNode(5, [nTree3Node16, nTree3Node15, nTree3Node14])
let nTree3Node07 = NTreeNode(5)
let nTree3Node06 = NTreeNode(4, [nTree3Node13, nTree3Node12, nTree3Node11])
let nTree3Node05 = NTreeNode(1)
let nTree3Node04 = NTreeNode(10, [nTree3Node10, nTree3Node09, nTree3Node08])
let nTree3Node03 = NTreeNode(9)
let nTree3Node02 = NTreeNode(6, [nTree3Node07, nTree3Node06, nTree3Node05])
let nTree3Node01 = NTreeNode(11, [nTree3Node04, nTree3Node03, nTree3Node02])

// N叉树：测试树-4
let nTree4Node14 = NTreeNode(4)
let nTree4Node13 = NTreeNode(0)
let nTree4Node12 = NTreeNode(3)
let nTree4Node11 = NTreeNode(2)
let nTree4Node10 = NTreeNode(-1)
let nTree4Node09 = NTreeNode(9)
let nTree4Node08 = NTreeNode(8)
let nTree4Node07 = NTreeNode(-3, [nTree4Node14, nTree4Node13])
let nTree4Node06 = NTreeNode(5)
let nTree4Node05 = NTreeNode(1, [nTree4Node12, nTree4Node11, nTree4Node10])
let nTree4Node04 = NTreeNode(6, [nTree4Node09, nTree4Node08, nTree4Node07])
let nTree4Node03 = NTreeNode(9)
let nTree4Node02 = NTreeNode(7, [nTree4Node06, nTree4Node05])
let nTree4Node01 = NTreeNode(1, [nTree4Node04, nTree4Node03, nTree4Node02])
