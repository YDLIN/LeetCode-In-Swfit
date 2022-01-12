//
//  BinaryNode.swift
//  LeetCode
//
//  Created by Du on 2022/1/10.
//  Copyright © 2022 Du. All rights reserved.
//

import Foundation

/********************二叉树节点**********************/
public class BinaryNode: Comparable {
    public static func < (lhs: BinaryNode, rhs: BinaryNode) -> Bool {
        return  lhs.value < rhs.value
    }
    
    public static func > (lhs: BinaryNode, rhs: BinaryNode) -> Bool {
        return  lhs.value > rhs.value
    }
    
    public static func == (lhs: BinaryNode, rhs: BinaryNode) -> Bool {
        return  lhs.value == rhs.value
    }
    
    var value: Int
    var left: BinaryNode?
    var right: BinaryNode?
    var parent: BinaryNode?
    init(value: Int, parent: BinaryNode?) {
        self.value = value
        self.parent = parent
    }
    
    /// 是否是叶子节点
    /// - Returns:  true: 是叶子节点；false：不是叶子节点
    func isLeaf() -> Bool {
        return left == nil && right == nil
    }
    
    /// 度是否为2的节点
    /// - Returns: true：是度为2的节点；false：不是度为2的节点
    func hasTwoChildren() -> Bool {
        return left != nil && right != nil
    }
    
    /// 是否是父节点的左节点
    /// - Returns: true：是左节点；false：不是左节点
    func isLeftChild() -> Bool {
        return parent != nil && self == parent?.left
    }
    
    /// 是否是父节点的右节点
    /// - Returns: true：是右节点；false：不是右节点
    func isRightChild() -> Bool {
        return parent != nil && self == parent?.right
    }
}

extension BinaryNode: CustomStringConvertible {
    public var description: String {
        diagram(for: self)
    }
      
    private func diagram(for node: BinaryNode?,
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
