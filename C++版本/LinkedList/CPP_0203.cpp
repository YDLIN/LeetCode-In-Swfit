//
//  CPP_0203.cpp
//  LeetCode
//
//  Created by Du on 2021/12/28.
//  Copyright © 2021 Du. All rights reserved.
//

#include "CPP_0203.hpp"

// 没有虚拟头头节点
ListNode* CPP_0203::removeElements(ListNode* head, int val) {
    while (head != NULL && head->val == val) {
        ListNode* tmp = head;
        head = head->next;
        delete tmp;
    }
    
    ListNode* cur = head;
    while (cur != NULL && cur->next != NULL) {
        if (cur->next->val == val) {
            ListNode* tmp = cur->next;
            cur->next = cur->next->next;
            delete tmp;
        } else {
            cur = cur->next;
        }
    }
    return head;
}

// 有虚拟节点的情况
ListNode* CPP_0203::removeElements_2(ListNode* head, int val) {
    ListNode *dummyHead = new ListNode(0);
    dummyHead->next = head;
    ListNode *cur = dummyHead;
    while (cur->next != NULL) {
        if (cur->next->val == val) {
            ListNode *tmp = cur->next;
            cur->next = cur->next->next;
            delete tmp;
        } else {
            cur = cur->next;
        }
    }
    head = dummyHead->next;
    delete dummyHead;
    return head;
}

