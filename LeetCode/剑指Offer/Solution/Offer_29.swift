//
//  Offer_29.swift
//  LeetCode
//
//  Created by Du on 2021/8/13.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 29. 顺时针打印矩阵
 输入一个矩阵，按照从外向里以顺时针的顺序依次打印出每一个数字。
 示例1：
 输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]
 输出：[1,2,3,6,9,8,7,4,5]
 
 示例2：
 输入：matrix = [[1,2,3],
                [4,5,6]]
 输出：[1,2,3,6,5,4]
 */


/********************解题********************/
class Offer_29 {
    // 
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        guard matrix.count > 0 else {
            return []
        }
        
        guard let firstMatrix = matrix.first else {
            return []
        }
        
        // 定义四条边界
        var top = 0
        var right = firstMatrix.count - 1
        var bottom = matrix.count - 1
        var left = 0
        
        // 存放结果数组
        var result = [Int]()
        
        // 因为矩阵不一定是方形矩阵，所以有可能出现不成环的情况，能成环的必要条件是 (left < right && top < bottom)
        while left < right && top < bottom {
            // 上边
            for i in left..<right {
                result.append(matrix[top][i])
            }
            
            // 右边
            for i in top..<bottom {
                result.append(matrix[i][right])
            }
            
            // 下边
            for i in stride(from: right, to: left, by: -1) {
                result.append(matrix[bottom][i])
            }
            
            // 左边
            for i in stride(from: bottom, to: top, by: -1) {
                result.append(matrix[i][left])
            }
            
            // 缩圈
            top += 1
            right -= 1
            bottom -= 1
            left += 1
        }
        
        // 如果能成圈的处理完，或者一开始就是不成圈，就需要单独处理一行，或者一列，或者单单只有一个
        if top == bottom {// 这就是只有一行，从左往右遍历就行
            // 如果 left 比 right 大的时候，会崩溃
//            for i in left...right {
//                result.append(matrix[top][i])
//            }
            
            for i in stride(from: left, through: right, by: 1) {
                result.append(matrix[top][i])
            }
        } else if left == right {// 这就是只有一列，从上往下遍历就行
            // 如果 top 比 bottom 大的时候，会崩溃
//            for i in top...bottom {
//                result.append(matrix[i][left])
//            }
            
            for i in stride(from: top, through: bottom, by: 1) {
                result.append(matrix[i][left])
            }
        }
        
        return result
    }
}

/********************测试代码********************/
extension Offer_29 {
    func offer_29_test(_ matrix: [[Int]]) {
        print(self.spiralOrder(matrix))
    }
}
