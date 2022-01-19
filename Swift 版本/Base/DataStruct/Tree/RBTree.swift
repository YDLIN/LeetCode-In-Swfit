//
//  RBTree.swift
//  LeetCode
//
//  Created by Du on 2022/1/16.
//  Copyright © 2022 Du. All rights reserved.
//

import Cocoa

private extension BinaryNode {
    private struct AssociatedKey {
        static var color: String = "BinaryNode_Color"
    }
    
    var color: Bool {
        get {
            if let c = objc_getAssociatedObject(self, &AssociatedKey.color) {
                return c as! Bool
            } else {
                return Constants.red
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.color, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

/// 红黑树
class RBTree: BBST {
    override func afterAdd(node: BinaryNode?) {
        guard let node = node else {
            return
        }
        /**********************分类-1********************/
        // 取出父节点
        let p = node.parent
        // 特殊处理：如果添加的是根节点（或者上溢到达了根节点），将根节点染黑，然后返回
        guard let parent = p else {
            black(node: node)
            return
        }
        
        // 情况一：如果父节点是黑色的（添加后不用做额外的处理）
        if isBlack(node: parent) {
            return
        }
        
        /*******************分类-2***********************/
        // 取出叔父节点
        let uncle = parent.sibling()
        // 取出祖父节点
        let grand = parent.parent
        // 情况二：叔父节点是红色（只需对节点进行染色即可）
        if isRed(node: uncle) {
            // 父节点染成黑色
            black(node: parent)
            // 叔父节点染成黑色
            black(node: uncle)
            // 1、祖父节点当成一个新的节点（因为新节点默认是红色，所以这里需要染红），
            // 2、然后向上合并（递归调用）
            afterAdd(node: red(node: grand))
            return
        }
        
        // 情况三：叔父节点不是红色（需要对节点进行旋转）
        if parent.isLeftChild() {//L
            if node.isLeftChild() {//LL
                // 1.父节点染成黑色
                black(node: parent)
                // 2.祖父节点染成红色
                red(node: grand)
                // 3.祖父节进行右旋
                rightRotate(node: grand)
            } else {//LR
                // 1.自己染成黑色
                black(node: node)
                // 2.祖父节点染成红色
                red(node: grand)
                // 3.父节点进行左旋，祖父节进行右旋
                leftRotate(node: parent)
                rightRotate(node: grand)
            }
        } else {//R
            if node.isLeftChild() {//RL
                // 1.自己染成黑色
                black(node: node)
                // 2.祖父节点染成红色
                red(node: grand)
                // 3.父节点进行右旋，祖父节进行左旋
                rightRotate(node: parent)
                leftRotate(node: grand)
            } else {//RR
                // 1.父节点染成黑色
                black(node: parent)
                // 2.祖父节点染成红色
                red(node: grand)
                // 3.祖父节进行右旋
                leftRotate(node: grand)
            }
        }
        
    }
    
    override func afterRemove(node: BinaryNode?, replaceNode: BinaryNode?) {
        guard let node = node else {
            return
        }
        
        // 情况一：如果删除的是红色节点，直接删除即可，不用额外的处理
        if isRed(node: node) {
            return
        }
        
        // 情况二：如果删除的是黑色节点，则又分三种情况
        /*
         1、删除拥有两个红色子节点的黑色节点
         ┌──Black(25)──┐                        Black(17)──┐
         │             │       delete---->                 │
        Red(17)      Red(33)                             Red(33)
         这种情况下，黑色节点不会被直接删除（不会从内存中移除），真正删除的是它的前驱或者后继节点
         因为最后是删除红色节点，删除后，没有违背红黑树的性质，所以这种情况就不用处理
         */
        
        /*
         2、删除拥有一个红色子节点的黑色节点
         ┌──Black     or:    Black──┐
         │                          │
        Red                        Red
         用红色子节点替代黑色节点，然后染黑
         */
        if isRed(node: replaceNode) {
            black(node: replaceNode)
            return
        }
        /***********************接下来，情况会比较复杂，也分了若干种情况**************************/
        /*
         3、删除黑色叶子节点
         3.1、删除的是黑色叶子节点，并且是根节点
         ┌──Black──┐
         │         │
        nil       nil
         3.2、删除的是黑色叶子节点，不是根节点
              │
         ┌──Black──┐
         │         │
        nil       nil
         */
        /// 3.1、删除的是叶子节点，也是根节点
        let parent = node.parent
        if parent == nil {
            return
        }
        
        /// 3.2、删除的是黑色叶子节点，不是根节点
        /*
         判断被删除的节点是左节点还是右节点
         1、根据上一步的删除操作可知，如果父节点的左节点是空，那证明被删除的节点就是父节点的左节点
         2、根据后面的递归情况可知，如果父节点的左节点不为空，那就是父节点下溢的情况，还需要判断被删除的节点是不是父节点的左节点
         */
        let isLeft = (parent?.left == nil) || node.isLeftChild()
        // 获取兄弟节点
        var sibling = isLeft ? parent?.right : parent?.left
        
        if isLeft {// 被删除的节点在父节点的左边，那兄弟节点就是在父节点的右边
            // 如果兄弟节点是红色
            if isRed(node: sibling) {
                black(node: sibling)
                red(node: parent)
                leftRotate(node: parent)
                sibling = parent?.right
            }
            
            // 兄弟节点是黑色
            if isBlack(node: sibling?.left) && isBlack(node: sibling?.right) {// 兄弟节点左右都为nil，所以是左右都是黑色，此时父节点需要向下合并
                let isParentBlack = isBlack(node: parent)
                black(node: parent)
                red(node: sibling)
                // 如果父节点是黑色，父节点跟子节点合并的话，那必然会导致父节点下溢。所以这种情况就是相当于删除父节点
                if isParentBlack {
                    afterRemove(node: parent, replaceNode: nil)
                }
            } else {// 兄弟节点至少有一个红色的子节点。这种情况，就可以向兄弟节点借红色的子节点（一共有三种情况）
                /*
                 这里是删除88
                 情况一：
                     B(55)  -->    R(80)                                 B(55)  -->   R(80)
                   /           /          \         将76左旋之后          /            /     \
                 B(46)      B(76)->R(78)  B(88)                       B(46)  B(76)<-R(78)  B(88)
                 情况二：
                     B(55)  -->  R(80)
                   /            /      \
                 B(46)  R(72)<-B(76)  B(88)
                 情况三：
                     B(55)     -->    R(80)
                   /             /            \
                 B(46)  R(72)<-B(76)->R(78)  B(88)
                 */
                // 如果兄弟的左节点是黑色，那就证明兄弟节点的左节点是空的，红色节点在它的右边（情况一）；我们只需将76左旋然后就可以统一三种情况了
                if isBlack(node: sibling?.right) {
                    rightRotate(node: sibling)
                    // 本来兄弟节点是76的，但是旋转后，变成了78，所以需要更换 sibling
                    sibling = parent?.right
                }
                
                // 能来到这里，就统一处理三种情况（此时三种情况都是 LL，所以需要父节点右旋）
                // 先染色
                color(node: sibling, color: color(of: parent))
                black(node: sibling?.right)
                black(node: parent)
                // 再旋转
                leftRotate(node: parent)
            }
        } else {// 被删除的节点在父节点的右边，那兄弟节点就是在父节点的左边
            // 如果兄弟节点是红色
            if isRed(node: sibling) {
                black(node: sibling)
                red(node: parent)
                rightRotate(node: parent)
                sibling = parent?.left
            }
            
            // 兄弟节点是黑色
            if isBlack(node: sibling?.left) && isBlack(node: sibling?.right) {// 兄弟节点左右都为nil，所以是左右都是黑色，此时父节点需要向下合并
                let isParentBlack = isBlack(node: parent)
                black(node: parent)
                red(node: sibling)
                // 如果父节点是黑色，父节点跟子节点合并的话，那必然会导致父节点下溢。所以这种情况就是相当于删除父节点
                if isParentBlack {
                    afterRemove(node: parent, replaceNode: nil)
                }
            } else {// 兄弟节点至少有一个红色的子节点。这种情况，就可以向兄弟节点借红色的子节点（一共有三种情况）
                /*
                 这里是删除88
                 情况一：
                     B(55)  -->    R(80)                                 B(55)  -->   R(80)
                   /           /          \         将76左旋之后          /            /     \
                 B(46)      B(76)->R(78)  B(88)                       B(46)  B(76)<-R(78)  B(88)
                 情况二：
                     B(55)  -->  R(80)
                   /            /      \
                 B(46)  R(72)<-B(76)  B(88)
                 情况三：
                     B(55)     -->    R(80)
                   /             /            \
                 B(46)  R(72)<-B(76)->R(78)  B(88)
                 */
                // 如果兄弟的左节点是黑色，那就证明兄弟节点的左节点是空的，红色节点在它的右边（情况一）；我们只需将76左旋然后就可以统一三种情况了
                if isBlack(node: sibling?.left) {
                    leftRotate(node: sibling)
                    // 本来兄弟节点是76的，但是旋转后，变成了78，所以需要更换 sibling
                    sibling = parent?.left
                }
                
                // 能来到这里，就统一处理三种情况（此时三种情况都是 LL，所以需要父节点右旋）
                // 先染色
                color(node: sibling, color: color(of: parent))
                black(node: sibling?.left)
                black(node: parent)
                // 再旋转
                rightRotate(node: parent)
            }
        }
    }
}

// 辅助函数
extension RBTree {
    /// 对节点进行染色
    /// - Parameters:
    ///   - node: 需要染色的节点
    ///   - color: 需要染成什么颜色
    /// - Returns: 返回已经被染色的节点；如果传进的节点为 nil，那返回 nil
    @discardableResult
    private func color(node: BinaryNode?, color: Bool) -> BinaryNode? {
        guard let node = node else {
            return node
        }
        
        node.color = color
        return node
    }
    
    /// 把节点染成红色
    /// - Parameter node: 需要染色的节点
    /// - Returns: 返回已经被染色的节点
    @discardableResult
    private func red(node: BinaryNode?) -> BinaryNode? {
        return color(node: node, color: Constants.red)
    }
    
    /// 把节点染成黑色
    /// - Parameter node: 需要染色的节点
    /// - Returns: 返回已经被染色的节点
    @discardableResult
    private func black(node: BinaryNode?) -> BinaryNode? {
        return color(node: node, color: Constants.black)
    }
    
    ///  获取节点颜色
    /// - Parameter node: 需要获取颜色的节点
    /// - Returns: 节点的颜色
    private func color(of node: BinaryNode?) -> Bool {
        guard let node = node else {
            return Constants.black
        }
        return node.color
    }
    
    /// 节点是否为红色
    /// - Parameter node: 需要判断的节点
    /// - Returns: 如果是红色，返回 true，反着返回 false
    private func isRed(node: BinaryNode?) -> Bool {
        return color(of: node) == Constants.red
    }
    
    /// 节点是否为黑色
    /// - Parameter node: 需要判断的节点
    /// - Returns: 如果是黑色，返回 true，反着返回 false
    private func isBlack(node: BinaryNode?) -> Bool {
        return color(of: node) == Constants.black
    }
}
