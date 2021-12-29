//
//  CPPWrapper.mm
//  LeetCode
//
//  Created by Du on 2021/12/26.
//  Copyright © 2021 Du. All rights reserved.
//

#import "CPPWrapper.h"
#import "CPP_0704.hpp"
#import "CPP_0027.hpp"
#import "CPP_0209.hpp"
#import "CPP_0059.hpp"
#import "CPP_0977.hpp"
#import "CPP_0203.hpp"


@implementation CPPWrapper
- (void)startTest {
    [self leetCodeTest];
//    [self offerTest];
}

#pragma mark - 题目总分类
- (void)leetCodeTest {
//    [self test0704];
//    [self test0027];
//    [self test0209];
//    [self test0059];
//    [self test0977];
    [self test0203];
}

- (void)offerTest {
    
}

#pragma mark - Private
- (void)test0704 {
    auto sp = CPP_0704();
    vector<int> v{1, 2, 3, 4, 7, 9, 10};
    vector<int> v2{-1, 0, 3, 5, 9, 12};
    NSLog(@"%d", sp.search(v, 2));
    NSLog(@"%d", sp.search_2(v2, 9));
}

- (void)test0027 {
    auto sp = CPP_0027();
    vector<int> v{1, 2, 3, 4, 2, 9, 2};
    vector<int> v2{-1, 0, 3, 5, 7, 9, 9, 9};
    NSLog(@"%d", sp.removeElement(v, 2));
    NSLog(@"%d", sp.removeElement_2(v2, 9));
}

- (void)test0059 {
    auto sp = CPP_0059();
    vector<vector<int>> matrixThree = sp.generateMatrix(1);
//    vector<vector<int>> matrixFive = sp.generateMatrix(5);
    for (int i = 0; i < matrixThree.size(); ++i) {
        vector<int> subVector = matrixThree[i];
        for (int j = 0; j < subVector.size(); ++j) {
            NSLog(@"%d", subVector[j]);
        }
    }
//    NSLog(@"%@", static_cast<void>(sp.generateMatrix(4)));
//    NSLog(@"%@", static_cast<void>(sp.generateMatrix(5)));
}

- (void)test0209 {
    auto sp = CPP_0209();
    vector<int> v{2, 3, 1, 2, 4, 3};
    vector<int> v2{4, 6, 2, 4, 9, 8, 7};
    vector<int> v3{1, 1, 1, 1, 1, 1, 1, 1};
    NSLog(@"%d", sp.minSubArrayLen(v, 7));
    NSLog(@"%d", sp.minSubArrayLen_2(v3, 11));
}

- (void)test0977 {
    auto sp = CPP_0977();
    vector<int> v{-4, -1, 0, 3, 10};
    sp.sortedSquares(v);
}

- (void)test0203 {
//    auto sp = CPP_0203();
//    
//    sp.removeElements(NULL, 4);
    
}
@end
