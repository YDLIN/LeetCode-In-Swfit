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


@implementation CPPWrapper
- (void)startTest {
//    [self test0704];
    [self test027];
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
@end