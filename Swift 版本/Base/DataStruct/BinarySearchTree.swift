//
//  BinarySearchTree.swift
//  LeetCode
//
//  Created by Du on 2022/1/4.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation

/********************二叉搜索树的节点**********************/
public class BSTNode<T> {
    var value: T
    var left: BSTNode<T>?
    var right: BSTNode<T>?
    var parent: BSTNode<T>?
    init(value: T, parent: BSTNode<T>?) {
        self.value = value
        self.parent = parent
    }
}

extension BSTNode: CustomStringConvertible {
    public var description: String {
        diagram(for: self)
    }
      
    private func diagram(for node: BSTNode?,
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

/********************二叉搜索树**********************/
public class BinarySearchTree<T: Comparable> {
    /// 节点总数
    private var nodeCount = 0
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
    private var root: BSTNode<T>?
    
    init() {}
    
    init(root: BSTNode<T>?) {
        self.nodeCount = 0
        self.root = root
    }
    
    public func isEmpty() -> Bool {
        return nodeCount == 0
    }
    
    public func clear() {
        
    }
    
    /// 添加节点
    /// - Parameter value: 新节点的值
    public func add(value: T) {
        // 1、如果根节点为空，则添加的元素就是根节点
        if root == nil {
            root = BSTNode(value: value, parent: nil)
            nodeCount += 1
            return
        }
        
        // 2、如果根节点不为空
        var parent = root
        var node = root
        var cmp = 0
        // 比较
        while node != nil {
            // 在向左向右之前，先保存父节点
            parent = node
            
            if value > node!.value {
                cmp = 1
                node = node?.right
            } else if value < node!.value {
                cmp = -1
                node = node?.left
            } else {
                // 相等，需要覆盖旧值
                node?.value = value
                return
            }
        }
        
        // 3、找到父节点后，看看新的节点要插入到什么位置
        // 创建新的节点
        let newNode = BSTNode(value: value, parent: parent)
        // 插入
        if cmp > 0 {
            parent?.right = newNode
        } else {
            parent?.left = newNode
        }
        
        // 4、节点数加一
        nodeCount += 1
    }
    
    public func addRecursive() {
        
    }
    
    public func remove(element: T) {
        
    }
    
    public func contains(element: T) -> Bool {
        return false
    }
}

// 打印二叉树
extension BinarySearchTree: CustomDebugStringConvertible {
    public var debugDescription: String {
        guard let root = root else {
            return "Empty tree"
        }
        
        return String(describing: root)
    }
}

// 遍历
extension BinarySearchTree {
    /// 前序遍历-递归
    public func preorder() {
        preorderTraversal(node: root)
    }
    private func preorderTraversal(node: BSTNode<T>?) {
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
    
    private func inorderTraversal(node: BSTNode<T>?) {
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
    
    private func postorderTraversal(node: BSTNode<T>?) {
        guard let node = node else {
            return
        }
        postorderTraversal(node: node.left)
        postorderTraversal(node: node.right)
        print(node.value)
    }
    
    /// 层序遍历-迭代
    public func levelOrder() -> [T] {
        guard let rootNode = root else {
            return []
        }
        
        var resultArray = [T]()
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

extension BinarySearchTree {
    // 递归
    private func treeHeightWithRecursion() -> Int {
        return height(with: root)
    }
    
    private func height(with node: BSTNode<T>?) -> Int {
        guard let node = node else {
            return 0
        }
        return 1 + max(height(with: node.left), height(with: node.right))
    }
    
    // 迭代
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
}
