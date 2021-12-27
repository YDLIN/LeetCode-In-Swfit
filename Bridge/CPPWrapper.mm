//
//  CPPWrapper.mm
//  LeetCode
//
//  Created by Du on 2021/12/26.
//  Copyright © 2021 Du. All rights reserved.
//

#import "CPPWrapper.h"
#import "CPP_0704.hpp"
#import "CPP_027.hpp"
#import "CPP_0209.hpp"


@implementation CPPWrapper
- (void)startTest {
//    [self test0704];
//    [self test027];
    [self test0209];
}

#pragma mark - Private
- (void)test0704 {
    auto sp = CPP_0704();
    vector<int> v{1, 2, 3, 4, 7, 9, 10};
    vector<int> v2{-1, 0, 3, 5, 9, 12};
    NSLog(@"%d", sp.search(v, 2));
    NSLog(@"%d", sp.search_2(v2, 9));
}

- (void)test027 {
    auto sp = CPP_027();
    vector<int> v{1, 2, 3, 4, 2, 9, 2};
    vector<int> v2{-1, 0, 3, 5, 7, 9, 9, 9};
    NSLog(@"%d", sp.removeElement(v, 2));
    NSLog(@"%d", sp.removeElement_2(v2, 9));
}

- (void)test0209 {
    auto sp = CPP_0209();
    vector<int> v{2, 3, 1, 2, 4, 3};
    vector<int> v2{4, 6, 2, 4, 9, 8, 7};
    vector<int> v3{1, 1, 1, 1, 1, 1, 1, 1};
    NSLog(@"%d", sp.minSubArrayLen(v, 7));
    NSLog(@"%d", sp.minSubArrayLen_2(v3, 11));
}
@end
