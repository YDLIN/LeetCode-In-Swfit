//
//  BinarySearchTree.swift
//  LeetCode
//
//  Created by Du on 2022/1/4.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation

/********************二叉搜索树的节点**********************/
public class BSTNode<T: Comparable>: Comparable {
    public static func == (lhs: BSTNode<T>, rhs: BSTNode<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    public static func < (lhs: BSTNode<T>, rhs: BSTNode<T>) -> Bool {
        return lhs.value < rhs.value
    }
    
    public static func > (lhs: BSTNode<T>, rhs: BSTNode<T>) -> Bool {
        return lhs.value > rhs.value
    }
    
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
        root = nil
        nodeCount = 0
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
        remove(node: getNode(element: element))
    }
    
    public func contains(element: T) -> Bool {
        return getNode(element: element) != nil
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
    // 递归求树的高度
    private func treeHeightWithRecursion() -> Int {
        return height(with: root)
    }
    
    private func height(with node: BSTNode<T>?) -> Int {
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
    private func predecessor(node: BSTNode<T>?) -> BSTNode<T>? {
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
        
        while node.parent != nil && node == node.parent!.left {
            node = node.parent!
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
    
    private func successor(node: BSTNode<T>?) -> BSTNode<T>? {
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
        
        while node.parent != nil && node == node.parent!.right {
            node = node.parent!
        }
        
        return node.parent
    }
    
    
    /// 根据给定的值，来获取节点
    /// - Parameter element: 给定的值
    /// - Returns: 获取到的节点
    private func getNode(element: T) -> BSTNode<T>? {
        var curNode = root
        while curNode != nil {
            if curNode!.value == element {
                return curNode
            } else if curNode!.value > element {// 要找的元素在左子树
                curNode = curNode?.left
            } else {// 要找的元素在右子树
                curNode = curNode?.right
            }
        }
        // 来到这里表示没找到，所以返回 nil
        return nil
    }
    
    /// 移除节点
    /// - Parameter node: 需要移除的节点
    private func remove(node: BSTNode<T>?) {
        guard var node = node else {
            return
        }
        
        // 节点数减1
        nodeCount -= 1
        
        // 度为2的节点需要特殊处理
        if node.left != nil && node.right != nil {
            // 找到度为2的节点的前驱节点（这里也可以用后驱节点）
            if let preNode = predecessor(node: node) {
                // 将前驱节点的值，覆盖度为2的节点的值
                node.value = preNode.value
                /*
                 用 node 指向前驱节点，就是统一后面的删除操作。
                 因为传进来的参数 node，如果它不是度为2的节点，就不会进来这个 if 代码块
                 而是直接执行后面的删除操作
                 */
                node = preNode
            }
        }
        
        // 删除 node 节点（这里node的度，不是0，就是1）
        let replacementNode = node.left != nil ? node.left : node.right
        
        /*
         一、度为1的节点,该节点所处的位置有一下三种情况：
            1、该节点是根节点
            2、该节点是左节点
            3、该节点是右节点
         二、replacementNode就是用来替换度为1的那个节点
         */
        if replacementNode != nil {
            // 替换节点的父节点
            replacementNode?.parent = node.parent
            // 替换父节点的左节点或者右节点
            if node.parent == nil {
                root = replacementNode
            } else if node == node.parent?.left {// 如果删除的节点，是父节点的左节点，那替换节点应该也是父节点的左节点
                node.parent?.left = replacementNode
            } else {// node == node.parent?.right
                node.parent?.right = replacementNode
            }
        } else {//度为0的节点
            if node.parent == nil {// node 是叶子节点，并且是根节点
                root = nil
            } else {// node 是叶子节点，但不是根节点
                if node == node.parent?.left {// 如果要删除的叶子节点是处于左边
                    node.parent?.left = nil
                } else {// 如果要删除的叶子节点是处于右边
                    node.parent?.right = nil
                }
            }
        }
    }
}
