//
//  AVLTree.swift
//  LeetCode
//
//  Created by Du on 2022/1/11.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation

private extension BinaryNode {
    private struct AssociatedKey {
        static var height: String = "BinaryNode_Height"
    }
    
    var height: Int {
        get {
            if let h = objc_getAssociatedObject(self, &AssociatedKey.height) {
                return h as! Int
            } else {
                // 每个节点创建出来的高度都是1
                return 1
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.height, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    var balanceFactor: Int {
        let leftHeight = (self.left == nil) ? 0 : self.left!.height
        let rightHeight = (self.right == nil) ? 0 : self.right!.height
        
        return leftHeight - rightHeight
    }
    
    /// 更新节点自己的高度
    func updateHeight() {
        let leftHeight = (self.left == nil) ? 0 : self.left!.height
        let rightHeight = (self.right == nil) ? 0 : self.right!.height
        height = 1 + max(leftHeight, rightHeight)
    }
    
    /// 返回左右子树中，高度最高的节点
    /// - Returns: 高度最高的节点
    func tallerChild() -> BinaryNode? {
        let leftHeight = (self.left == nil) ? 0 : self.left!.height
        let rightHeight = (self.right == nil) ? 0 : self.right!.height
        if leftHeight > rightHeight {
            return self.left
        } else if leftHeight < rightHeight {
            return self.right
        } else {
            /*
             规则是：如果我自己是父节点的左节点，那就返回我的左节点；否则返回右节点
             */
            return isLeftChild() ? self.left : self.right
        }
    }
}


public class AVLTree: BST {
    override func afterAdd(node: BinaryNode?) {
        // 循环找到新添加节点的祖父节点（因为父节点是一定不会失衡的）
        // 找到最靠底的那个祖父节点，然后判断它是否失衡，如果失衡，则修复它
        var curNode = node?.parent
        while curNode != nil {
            if isBalance(node: curNode!) {// 如果节点平衡，更新高度
                curNode!.updateHeight()
            } else {// 如果不平衡，则需要恢复平衡
                recoverBalance(node: curNode!)
                recoverBalance2(node: curNode!)
                /*
                 因为 curNode 是第一个不平衡的节点（最靠底的那个祖父节点）
                 只要恢复这个节点的平衡，整棵树都会恢复平衡了，所以直接 break 就行
                 */
                break
            }
            
            // 更新下一次需要找的祖父节点
            curNode = curNode!.parent
        }
    }
    
    override func afterRemove(node: BinaryNode?) {
        var curNode = node?.parent
        while curNode != nil {
            if isBalance(node: curNode!) {// 如果节点平衡，更新高度
                curNode!.updateHeight()
            } else {// 如果不平衡，则需要恢复平衡
                recoverBalance2(node: curNode!)
                /*
                 删除对比添加操作，这里不需要用 break, 因为删除可能会导致父节点及以上的全部父节点都失衡，所以要一直遍历下去
                 */
            }
            
            // 更新下一次需要找的祖父节点
            curNode = curNode!.parent
        }
    }
}

extension AVLTree {
    /// 判断节点是否平衡
    /// - Parameter node: 需要判断的节点
    /// - Returns: true：节点平衡；false：节点不平衡
    private func isBalance(node: BinaryNode) -> Bool {
        return abs(node.balanceFactor) <= 1
    }
    
    /// 恢复平衡
    /// - Parameter node: 需要恢复平衡的节点（最靠底的那个祖父节点）
    private func recoverBalance(node grandNode: BinaryNode) {
        /*
         三个变量的意思：
         node：祖父节点
         parentNode：父节点
         curNode： 当前节点
         */
        guard let parentNode = grandNode.tallerChild() else {
            return
        }
        guard let childNode = parentNode.tallerChild() else {
            return
        }
        
        // 判断是用什么方式进行旋转
        if parentNode.isLeftChild() {// L
            if childNode.isLeftChild() {//LL
                rightRotate(node: grandNode)
            } else {//LR
                // 先对 parentNode 进行左旋转
                leftRotate(node: parentNode)
                // 再对 childNode 进行右旋转
                rightRotate(node: grandNode)
            }
        } else {//R
            if childNode.isLeftChild() {//RL
                // 先对 parentNode 进行右转
                rightRotate(node: parentNode)
                // 再对 childNode 进行右旋转
                leftRotate(node: grandNode)
            } else {//RR
                leftRotate(node: grandNode)
            }
        }
    }
    
    /// 恢复平衡-2
    /// - Parameter node: 需要恢复平衡的节点（最靠底的那个祖父节点）
    private func recoverBalance2(node grandNode: BinaryNode) {
        /*
         三个变量的意思：
         node：祖父节点
         parentNode：父节点
         curNode： 当前节点
         */
        guard let parentNode = grandNode.tallerChild() else {
            return
        }
        guard let childNode = parentNode.tallerChild() else {
            return
        }
        
        // 判断是用什么方式进行旋转
        if parentNode.isLeftChild() {// L
            if childNode.isLeftChild() {//LL
                rotate(nodeR: grandNode,
                       nodeA: childNode.left, nodeB: childNode, nodeC: childNode.right,
                       nodeD: parentNode,
                       nodeE: parentNode.right, nodeF: grandNode, nodeG: grandNode.right)
            } else {//LR
                rotate(nodeR: grandNode,
                       nodeA: parentNode.left, nodeB: parentNode, nodeC: childNode.left,
                       nodeD: childNode,
                       nodeE: childNode.right, nodeF: grandNode, nodeG: grandNode.right)
            }
        } else {//R
            if childNode.isLeftChild() {//RL
                rotate(nodeR: grandNode,
                       nodeA: grandNode.left, nodeB: grandNode, nodeC: childNode.left,
                       nodeD: childNode,
                       nodeE: childNode.right, nodeF: parentNode, nodeG: parentNode.right)
            } else {//RR
                rotate(nodeR: grandNode,
                       nodeA: grandNode.left, nodeB: grandNode, nodeC: parentNode.left,
                       nodeD: parentNode,
                       nodeE: childNode.left, nodeF: childNode, nodeG: childNode.right)
            }
        }
    }
    
    /// 左旋转
    /// - Parameter grandNode: 需要旋转的节点
    private func leftRotate(node grandNode: BinaryNode) {
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
    private func rightRotate(node grandNode: BinaryNode) {
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
    
    private func afterRotate(grandNode: BinaryNode, parentNode: BinaryNode?, childNode:BinaryNode?) {
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
         */
        grandNode.updateHeight()
        parentNode?.updateHeight()
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
    private func rotate(nodeR: BinaryNode,
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
        nodeB.updateHeight()
        
        // 处理 e, f, g 节点
        nodeF.left = nodeE
        nodeE?.parent = nodeF
        nodeF.right = nodeG
        nodeG?.parent = nodeF
        nodeF.updateHeight()
        
        // 处理 b, d, f 的关系
        nodeD.left = nodeB
        nodeD.right = nodeF
        nodeB.parent = nodeD
        nodeF.parent = nodeD
        nodeD.updateHeight()
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
