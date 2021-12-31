//
//  ListNode.h
//  LeetCode
//
//  Created by Du on 2021/12/30.
//  Copyright © 2021 Du. All rights reserved.
//

#ifndef ListNode_h
#define ListNode_h
struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x): val(x), next(nullptr) {}
};

#endif /* ListNode_h */
