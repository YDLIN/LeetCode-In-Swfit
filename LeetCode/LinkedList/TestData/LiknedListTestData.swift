//
//  LiknedListTestData.swift
//  LeetCode
//
//  Created by Du on 2021/3/1.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 此文件包含链表测试所需要的数据
 */
/********************移除链表元素********************/
func removeElementsInLinkedList() -> LinkedList<Int> {
    var removeElementsList = LinkedList<Int>()
    removeElementsList.append(6)
    removeElementsList.append(2)
    removeElementsList.append(6)
    removeElementsList.append(3)
    removeElementsList.append(4)
    removeElementsList.append(5)
    removeElementsList.append(6)
    return removeElementsList
}
