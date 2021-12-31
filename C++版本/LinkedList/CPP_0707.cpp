//
//  CPP_0707.cpp
//  LeetCode
//
//  Created by Du on 2021/12/31.
//  Copyright © 2021 Du. All rights reserved.
//

#include "CPP_0707.hpp"
#include <iostream>

using namespace std;

int CPP_0707::get(int index) {
    if (index < 0 || index >= size) {
        return -1;
    }
    ListNode *cur = dummyHead->next;
    while (index--) {
        cur = cur->next;
    }
    return cur->val;
}

void CPP_0707::addAtHead(int val) {
    ListNode *newHead = new ListNode(val);
    newHead->next = dummyHead->next;
    dummyHead = newHead;
    size++;
}

void CPP_0707::addAtTail(int val) {
    ListNode *newNode = new ListNode(val);
    ListNode *cur = dummyHead;
    while (cur->next != NULL) {
        cur = cur->next;
    }
    cur->next = newNode;
    size++;
}

void CPP_0707::addAtIndex(int index, int val) {
    if (index > size) {
        return;
    }
    ListNode *newNode = new ListNode(val);
    ListNode *cur = dummyHead;
    while (index--) {
        cur = cur->next;
    }
    newNode->next = cur->next;
    cur->next = newNode;
    size++;
}

void CPP_0707::deleteAtIndex(int index) {
    if (index >= size || index < 0) {
        return;
    }
    ListNode *cur = dummyHead;
    while (index--) {
        cur = cur->next;
    }
    ListNode *tmp = cur->next;
    cur->next = cur->next->next;
    delete tmp;
    size--;
}

void CPP_0707::printLinkedList() {
    ListNode *cur = dummyHead;
    while (cur->next != NULL) {
        cout << cur->next->val << " ";
        cur = cur->next;
    }
    cout << endl;
}
