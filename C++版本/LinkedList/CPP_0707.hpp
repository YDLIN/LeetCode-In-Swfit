//
//  CPP_0707.hpp
//  LeetCode
//
//  Created by Du on 2021/12/31.
//  Copyright © 2021 Du. All rights reserved.
//

#ifndef CPP_0707_hpp
#define CPP_0707_hpp

#include <stdio.h>

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int v): val(v), next(nullptr) {}
//    ListNode(): val(0), next(nullptr) {}
//    ListNode(int v, ListNode *node): val(v), next(node) {}
};

class CPP_0707 {
private:
    // 虚拟头节点
    ListNode *dummyHead;
    int size;
public:
    CPP_0707() {
        dummyHead = new ListNode(0);
        size = 0;
    }
    int get(int index);
    void addAtHead(int val);
    void addAtTail(int val);
    void addAtIndex(int index, int val);
    void deleteAtIndex(int index);
    void printLinkedList();
};
#endif /* CPP_0707_hpp */
