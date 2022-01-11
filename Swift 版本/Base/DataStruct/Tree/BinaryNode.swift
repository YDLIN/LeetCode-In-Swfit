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
