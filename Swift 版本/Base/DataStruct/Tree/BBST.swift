//
//  BBST.swift
//  LeetCode
//
//  Created by Du on 2022/1/16.
//  Copyright © 2022 Du. All rights reserved.
//

import Cocoa

/// 该类是平衡二叉搜索树，在二叉搜索树的基础上，增加了旋转的功能，然后 AVLTree 跟 RBTree 都继承该类
public class BBST: BST {
    /// 左旋转
    /// - Parameter grandNode: 需要旋转的节点
    func leftRotate(node grandNode: BinaryNode?) {
        guard let grandNode = grandNode else {
            return
        }
        /*
         1、进行旋转，能进行左旋，那就表明 parentNode 是 grandNode 的右子树。
         进行旋转的意思，其实就是修改 grandNode, parentNode, childNode 这三个节点的左右指向
         */
        let parentNode = grandNode.right
        let childNode = parentNode?.left
        grandNode.right = childNode
        parentNode?.left = grandNode
        
        // 更新父节点、高度
        afterRotate(grandNode: grandNode, parentNode: parentNode, childNode: childNode)
    }
    
    /// 右旋转
    /// - Parameter grandNode: 需要旋转的节点
    func rightRotate(node grandNode: BinaryNode?) {
        guard let grandNode = grandNode else {
            return
        }
        /*
         1、进行旋转，能进行右旋，那就表明 parentNode 是 grandNode 的左子树。
         进行旋转的意思，其实就是修改 grandNode, parentNode, childNode 这三个节点的左右指向
         */
        let parentNode = grandNode.left
        let childNode = parentNode?.right
        grandNode.left = childNode
        parentNode?.right = grandNode
        
        // 更新父节点、高度
        afterRotate(grandNode: grandNode, parentNode: parentNode, childNode: childNode)
    }
    
    func afterRotate(grandNode: BinaryNode, parentNode: BinaryNode?, childNode:BinaryNode?) {
        /*
         1、更新 parentNode 的根节点
            1.1、grandNode 以前是 grandNode.parent 的左节点，那现在 parentNode 也是 grandNode.parent 的左节点；反之也是
         */
        parentNode?.parent = grandNode.parent
        if grandNode.isLeftChild() {
            grandNode.parent?.left = parentNode
        } else if grandNode.isRightChild() {
            grandNode.parent?.right = parentNode
        } else {// 来到这里，就表明 grandNode 是根节点
            root = parentNode
        }
        
        /*
         2、更新 childNode 的根节点
         */
        childNode?.parent = grandNode
        
        /*
         3、更新 grandNode 的根节点
         */
        grandNode.parent = parentNode
        
        /*
         4、需要更新高度
         这里没有修改 childNode 的任何子节点，所以不用更新它的高度
         先更新 grand
         这两句代码交给子类 AVLTree 去完成，因为只有 AVLTree 才有高度
         */
//        grandNode.updateHeight()
//        parentNode?.updateHeight()
    }
    
    /// 统一处理旋转逻辑
    /// - Parameters:
    ///   - nodeR: 旋转前的根节点（不能为空）
    ///   - nodeA: nodeB 的左节点
    ///   - nodeB: 左子树的根节点（不能为空）
    ///   - nodeC: nodeB 的右节点
    ///   - nodeD: 旋转后最终成为根节点的那个节点（不能为空）
    ///   - nodeE: nodeF 的左节点
    ///   - nodeF: 右子树的根节点（不能为空）
    ///   - nodeG: nodeF 的右节点
    func rotate(nodeR: BinaryNode,
                        nodeA: BinaryNode?, nodeB: BinaryNode, nodeC: BinaryNode?,
                        nodeD: BinaryNode,
                        nodeE: BinaryNode?, nodeF: BinaryNode, nodeG: BinaryNode?) {
        // 让 d 成为根节点
        nodeD.parent = nodeR.parent
        if nodeR.isLeftChild() {
            nodeR.parent?.left = nodeD
        } else if nodeR.isRightChild() {
            nodeR.parent?.right = nodeD
        } else {
            root = nodeD
        }
        
        // 处理 a, b, c 节点
        nodeB.left = nodeA
        nodeA?.parent = nodeB
        nodeB.right = nodeC
        nodeC?.parent = nodeB
        // 更新高度代码交给子类 AVLTree 去实现
//        nodeB.updateHeight()
        
        // 处理 e, f, g 节点
        nodeF.left = nodeE
        nodeE?.parent = nodeF
        nodeF.right = nodeG
        nodeG?.parent = nodeF
        // 更新高度代码交给子类 AVLTree 去实现
//        nodeF.updateHeight()
        
        // 处理 b, d, f 的关系
        nodeD.left = nodeB
        nodeD.right = nodeF
        nodeB.parent = nodeD
        nodeF.parent = nodeD
        // 更新高度代码交给子类 AVLTree 去实现
//        nodeD.updateHeight()
    }
    
    /*
     LL - 右旋图例：     LL - 右旋实际例子：
             ┌─X─┐             ┌─8─┐
             │   │             │   │
           ┌─g─┐ Y           ┌─6─┐ 9
           │   │             │   │
         ┌─p─┐ T3           ┌─4─┐ 7
         │   │              │   │
        ┌─n─┐T2           ┌─2─┐ 5
        │   │             │   │
        T0  T1            1   3
     
     RR - 左旋图例：     LL - 左旋实际例子：
         ┌─Y─┐              ┌─2─┐
         │   │              │   │
         X ┌─g─┐            1 ┌─4─┐
           │   │              │   │
           T0 ┌─p─┐           3 ┌─6─┐
              │   │             │   │
             T1 ┌─n─┐           5 ┌─8─┐
                │   │             │   │
               T2   T3            7   9
  
     LR - RR左旋,LL右旋图例：     LR - RR左旋,LL右旋实际例子：
                     ┌─X─┐                   ┌─8─┐
                     │   │                   │   │
                   ┌─g─┐ Y                 ┌─6─┐ 9
                   │   │                   │   │
                 ┌─p─┐ T3                ┌─2─┐ 7
                 │   │                   │   │
                 T0┌─n─┐                 1 ┌─4─┐
                   │   │                   │   │
                   T1  T2                  3   5
  
     RL - LL右旋,RR左旋图例：     RL - LL右旋,RR左旋实际例子：
                 ┌──g─┐                 ┌──2─┐
                 │    │                 │    │
                 T0┌──p──┐              1 ┌──6──┐
                   │     │                │     │
                 ┌─n─┐ ┌─T3─┐           ┌─4─┐ ┌─8─┐
                 │   │ │    │           │   │ │   │
                 T1 T2 X    Y           3   5 7   9
     
     */
}
