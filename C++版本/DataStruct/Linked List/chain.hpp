//
//  chain.hpp
//  LeetCode
//
//  Created by Du on 2021/12/29.
//  Copyright © 2021 Du. All rights reserved.
//

#ifndef chain_hpp
#define chain_hpp

#include <stdio.h>
#include "linearList.h"
#include "chainNode.h"

template<class T>
class chain: public linearList<T> {
public:
    // 构造函数
    chain(int initialCapacity = 10);
    // 复制构造函数
    chain(const chain<T>&);
    // 析构函数
    ~chain();
    
    bool empty() const {
        return listSize == 0;
    }
    int size() const {
        return  listSize;
    }
    T& get(int theIndex) const;
    int indexOf(const T& theElement) const;
    void erase(int theIndex);
    void insert(int theIndex, const T& theElement);
    void output(ostream& out) const;
protected:
    // 如果索引无效，抛出异常
    void checkIndex(int theIndex) const;
    // 指向链表第一个节点的指针
    chainNode<T>* firstNode;
    // 线性表的元素个数
    int listSize;
};


#endif /* chain_hpp */
