//
//  linearList.h
//  LeetCode
//
//  Created by Du on 2021/12/29.
//  Copyright © 2021 Du. All rights reserved.
//

#ifndef linearList_h
#define linearList_h
#include <iostream>
using namespace std;

template<class T>

class linearList {
public:
    virtual ~linearList() {};
    // 当线性表为空时，返回 true
    virtual bool empty() const = 0;
    // 返回线性表的元素个数
    virtual int size() const = 0;
    // 返回索引为 theIndex 的元素
    virtual T& get(int theIndex) const = 0;
    // 返回元素 theElement 第一次出现时的索引
    virtual int indexOf(const T& theElement) const = 0;
    // 删除索引为 theIndex 的元素
    virtual void erase(int theIndex) = 0;
    // 把 theElement 插入线性表中索引为 theIndexde 位置上
    virtual void insert(int theIndex, const T& theElement) = 0;
    // 把线性表插入到输出流 out
    virtual void output(ostream& out) const = 0;
};

#endif /* linearList_h */
