//
//  Stack.swift
//  LeetCode
//
//  Created by Du on 2021/3/29.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation

/********************栈********************/
struct Stack<Element> {
    fileprivate var array: [Element] = []
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func push(_ element: Element?) {
        if let element = element {
            array.append(element)
        }
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        return array.popLast()
    }

    func peek() -> Element? {
        return array.last
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider = "-----Stack-----\n"
        let bottomDivider = "\n---------------\n"
        let stackElements = array.map{"\($0)"}.reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
}
