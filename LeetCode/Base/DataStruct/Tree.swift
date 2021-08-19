//
//  Tree.swift
//  LeetCode
//
//  Created by Du on 2021/3/29.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/********************LeetCode-树节点********************/
/// 二叉树节点
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public var next: TreeNode?
    public init() {
        self.val = 0
        self.left = nil
        self.right = nil
        self.next = nil
    }
    
    public init(_ value: Int) {
        self.val = value
        self.left = nil
        self.right = nil
        self.next = nil
    }
    
    public init(_ value: Int, _ left: TreeNode?, _ right: TreeNode?, _ next: TreeNode? = nil) {
        self.val = value
        self.left = left
        self.right = right
        self.next = next
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        return "root: \(val), \(val)-left = [\(left?.description ?? "")], \(val)-right = [\(right?.description ?? "")]"
    }
}

/// N叉树节点
public class NTreeNode {
    public var val: Int
    public var children: [NTreeNode]
    public init() {
        self.val = 0
        self.children = []
    }
    
    public init(_ value: Int) {
        self.val = value
        self.children = []
    }
    
    public init(_ value: Int, _ children: [NTreeNode]) {
        self.val = value
        self.children = children
    }
}

/********************普通树********************/
class ThreeNode<T> {
    // 节点值
    var value: T
    // 子节点
    var children: [ThreeNode] = []
    // 父节点
    weak var parent: ThreeNode?
    
    init(value: T) {
        self.value = value
    }
    
    // 添加节点
    func add(child: ThreeNode) {
        children.append(child)
        child.parent = self
    }
}

extension ThreeNode: CustomStringConvertible {
    var description: String {
        var text = "\(value)"
        
        if !children.isEmpty {
            text += " {" + children.map{ $0.description}.joined(separator: ", ") + "} "
        }
        
        return text
    }
}

extension ThreeNode where T: Equatable {
    //查询
    func search(value: T) -> ThreeNode? {
        if value == self.value {
            return self
        }
        
        for child in children {
            if let found = child.search(value: value) {
                return found
            }
        }
        
        return nil
    }
}


/********************二叉树:枚举实现********************/
public indirect enum BinaryTreeEnum<T> {
    case node(BinaryTreeEnum<T>, T, BinaryTreeEnum<T>)
    case empty
    
    public var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
}


extension BinaryTreeEnum: CustomStringConvertible {
    public var description: String {
//        switch self {
//        case let .node(left, value, right):
//            return "value: \(value), \(value)-left = [\(left.description)], \(value)-right = [\(right.description)]"
//        case .empty:
//            return ""
//        }
        
        //这种写法根上面switch的写法的效果是一样的
        if case let .node(left, value, right) = self {
            return "root: \(value), \(value)-left = [\(left.description)], \(value)-right = [\(right.description)]"
        }else {
            return ""
        }
    }
}


/********************二叉树:类实现********************/
public class BinaryTreeClass<T> {
    public var value: T
    public var left: BinaryTreeClass?
    public var right: BinaryTreeClass?

    public init(_ value: T) {
        self.value = value
        self.left = nil
        self.right = nil
    }

    public init(_ value: T, _ left: BinaryTreeClass?, _ right: BinaryTreeClass?) {
        self.value = value
        self.left = left
        self.right = right
    }
}

extension BinaryTreeClass: CustomStringConvertible {
    public var description: String {
        return "root: \(value), \(value)-left = [\(left?.description ?? "")], \(value)-right = [\(right?.description ?? "")]"
    }
}

/*
打印出节点的结构
root: A,
A-left = [value: B,
    B-left = [value: D,
        D-left = [value: H,
            H-left = [],
            H-right = [value: K,
                K-left = [],
                K-right = []]],
        D-right = []],
    B-right = [value: E,
        E-left = [],
        E-right = []]],
A-right = [value: C,
    C-left = [value: F,
        F-left = [value: I,
            I-left = [],
            I-right = []],
        F-right = []],
    C-right = [value: G,
        G-left = [],
        G-right = [value: J,
            J-left = [],
            J-right = []]]]
*/
