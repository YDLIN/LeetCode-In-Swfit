//
//  BinaryTree.swift
//  LeetCode
//
//  Created by Du on 2022/1/9.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation
// 这个文件包含是二叉树节点，和二叉树的定义
/********************二叉树节点**********************/
public class BinaryTreeNode: Comparable {
    public static func < (lhs: BinaryTreeNode, rhs: BinaryTreeNode) -> Bool {
        return  lhs.value < rhs.value
    }
    
    public static func > (lhs: BinaryTreeNode, rhs: BinaryTreeNode) -> Bool {
        return  lhs.value > rhs.value
    }
    
    public static func == (lhs: BinaryTreeNode, rhs: BinaryTreeNode) -> Bool {
        return  lhs.value == rhs.value
    }
    
    var value: Int
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    var parent: BinaryTreeNode?
    init(value: Int, parent: BinaryTreeNode?) {
        self.value = value
        self.parent = parent
    }
}

extension BinaryTreeNode: CustomStringConvertible {
    public var description: String {
        diagram(for: self)
    }
      
    private func diagram(for node: BinaryTreeNode?,
                           _ top: String = "",
                           _ root: String = "",
                           _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        
        if node.left == nil && node.right == nil {
            return root + "\(node.value)\n"
        }
        
        let str = diagram(for: node.right, top + " ", top + "┌──", top + "│ ")
        + root + "\(node.value)\n"
        + diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
        return String(describing: str)
    }
}

/********************二叉树**********************/
public class BinaryTree {
    /// 节点总数
    public var nodeCount = 0
    public var size: Int {
        get {
            return nodeCount
        }
    }
    
    /// 树的高度
    public var height: Int {
        get {
//            return treeHeightWithRecursion()
            return treeHeightWithIteration()
        }
    }
    
    /// 根节点
    public var root: BinaryTreeNode?
    
    init() {}
    
    init(root: BinaryTreeNode?) {
        self.nodeCount = 0
        self.root = root
    }
    
    public func isEmpty() -> Bool {
        return nodeCount == 0
    }
    
    public func clear() {
        root = nil
        nodeCount = 0
    }
}

// 打印二叉树
extension BinaryTree: CustomDebugStringConvertible {
    public var debugDescription: String {
        guard let root = root else {
            return "Empty tree"
        }
        
        return String(describing: root)
    }
}

// 遍历
extension BinaryTree {
    /// 前序遍历-递归
    public func preorder() {
        preorderTraversal(node: root)
    }
    private func preorderTraversal(node: BinaryTreeNode?) {
        guard let node = node else {
            return
        }
        print(node.value)
        preorderTraversal(node: node.left)
        preorderTraversal(node: node.right)
    }
    
    /// 中序遍历-递归
    public func inorder() {
         inorderTraversal(node: root)
    }
    
    private func inorderTraversal(node: BinaryTreeNode?) {
        guard let node = node else {
            return
        }
        inorderTraversal(node: node.left)
        print(node.value)
        inorderTraversal(node: node.right)
    }
    
    /// 中序遍历-递归
    public func postorder() {
        postorderTraversal(node: root)
    }
    
    private func postorderTraversal(node: BinaryTreeNode?) {
        guard let node = node else {
            return
        }
        postorderTraversal(node: node.left)
        postorderTraversal(node: node.right)
        print(node.value)
    }
    
    /// 层序遍历-迭代
    public func levelOrder() -> [Int] {
        guard let rootNode = root else {
            return []
        }
        
        var resultArray = [Int]()
        // 先将头节点放到队列
        var queue = [rootNode]
        
        while !queue.isEmpty {
            let firstNode = queue.removeFirst()
            resultArray.append(firstNode.value)
            
            if let leftNode = firstNode.left {
                queue.append(leftNode)
            }
            
            if let rightNode = firstNode.right {
                queue.append(rightNode)
            }
        }
        return resultArray
    }
}

extension BinaryTree {
    // 递归求树的高度
    private func treeHeightWithRecursion() -> Int {
        return height(with: root)
    }
    
    private func height(with node: BinaryTreeNode?) -> Int {
        guard let node = node else {
            return 0
        }
        return 1 + max(height(with: node.left), height(with: node.right))
    }
    
    // 迭代求树的高度
    private func treeHeightWithIteration() -> Int {
        guard let rootNode = root else {
            return 0
        }
        // 先将头节点放到队列
        var queue = [rootNode]
        // 初始化树的高度
        var height = 0
        // 每一层的长度（该层元素的个数），一开始只有头节点，所以是1
        var levelSize = 1
        
        while !queue.isEmpty {
            let firstNode = queue.removeFirst()
            // 元素出队列，该层元素个数就应该减1
            levelSize -= 1
            
            if let leftNode = firstNode.left {
                queue.append(leftNode)
            }
            
            if let rightNode = firstNode.right {
                queue.append(rightNode)
            }
            
            // 如果这一层的最后一个元素都出队列了，那表示该层已经处理完
            if levelSize == 0 {
                // levelSize 就要等于 queue 的长度，也就是下层元素的个数
                levelSize = queue.count
                height += 1
            }
        }
        return height
    }
    
    
    /// 查找前驱节点
    /// 前驱节点的意思就是：中序遍历时的前一个节点
    /// - Parameter node: 需要找前驱节点的节点
    /// - Returns: 返回前驱节点，可能为 nil
    public func predecessor(node: BinaryTreeNode?) -> BinaryTreeNode? {
        guard var node = node else {
            return nil
        }
        
        /*
         情况一：
         如果有左子树，根据中序遍历的顺序，前驱就是该左子树中，最右边的那个节点（如果是二叉搜索树，就是该左子树中值最大的那个节点）
         */
        // 前驱节点
        var preNode = node.left
        if preNode != nil {
            while preNode!.right != nil {
                preNode = preNode!.right!
            }
            return preNode
        }

        /*
         情况二：
         来到情况二，就说明左子树是空，因为中序遍历是左中右，那左都为空了，那前驱节点只能从父节点里面找。那就是情况三了
         
         情况三：
         如果父节点不为空，那父节点一定就是该节点的前驱节点吗？不一定。
         1、如果该节点是父节点的右子树，那父节点就是前驱节点（如下图的节点12）；
         2、如果该节点是父节点的左子树，那前驱节点就(该节点的父节点)或者是(该节点的父节点的父节点...)，一直找到什么时候才停止呢？根据第一点就直到，我们只需一直找到该节点是父节点的右子树就行，前驱节点就是那个父节点了（如下图的节点9）（PS: 如果父节点是空，那就是返回空）
         
         图例：
             (8)
                \
                (13)
               /
              (10)
             /   \
            (9)  (12)
                /
               (11)
         */
        guard let parentNode = node.parent, let leftNode = parentNode.left else {
            return nil
        }
        while node == leftNode {
            node = parentNode
        }
        // 能来到这里，表示 node.parent == nil 或者 node == node.parent.right
        /*
        // 1、node.parent == nil
        if node.parent == nil {
            return nil
        } else {// 当前节点是父节点的右子树，那前驱节点就是父节点
            return node.parent
        }
         */
        
        // 统一上面情况，也就是返回node.parent
        return node.parent
    }
    
    public func successor(node: BinaryTreeNode?) -> BinaryTreeNode? {
        guard var node = node else {
            return nil
        }
        
        // 后驱节点
        var successorNode = node.right
        if successorNode != nil {
            while successorNode!.left != nil {
                successorNode = successorNode!.left!
            }
            return successorNode
        }
        
        guard let parentNode = node.parent, let rightNode = parentNode.right else {
            return nil
        }
        
        while node == rightNode {
            node = parentNode
        }
        
        return node.parent
    }
}
