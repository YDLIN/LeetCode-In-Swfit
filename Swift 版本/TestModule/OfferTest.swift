//
//  OfferTest.swift
//  LeetCode
//
//  Created by Du on 2021/8/13.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/********************剑指Offer的测试写在这里********************/
class OfferTest {
    func startTest() {
//        offer29()
//        offer05()
        offer58_II()
    }
}

extension OfferTest {
    func offer29() {
        Offer_29().offer_29_test(matrix_3)
    }
    
    func offer05() {
        Offer_05().offer_05_test(string_5)
    }
    
    func offer58_II() {
        Offer_58_II().offer_58_II_test(string_1, 3)
//        offer58_II().offer_58_II_test(string_2, 4)
    }
}

