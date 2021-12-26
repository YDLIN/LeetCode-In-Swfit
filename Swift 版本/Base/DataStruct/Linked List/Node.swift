//
//  Node.swift
//  LeetCode
//
//  Created by Du on 2021/8/17.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation

/********************链表节点********************/
public class Node<Value> {
    public var value: Value
    public var next: Node?

    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        
        return "\(value) ->" + String(describing: next) + " "
    }
}
