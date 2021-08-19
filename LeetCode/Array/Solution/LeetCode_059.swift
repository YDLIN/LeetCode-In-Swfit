//
//  LeetCode_059.swift
//  LeetCode
//
//  Created by Du on 2021/2/4.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 59. 螺旋矩阵 II
 给你一个正整数 n ，生成一个包含 1 到 n² 所有元素，且元素按顺时针顺序螺旋排列的 n x n 正方形矩阵 matrix 。

 示例：
 输入：n = 3
 输出：[[1,2,3], [8,9,4], [7,6,5]]
 图解：
 01 → 02 → 03
           ↓
 08 → 09   04
 ↑         ↓
 07 ← 06 ← 05
 
 示例：
 输入：n = 4
 输出：[[1,2,3,4], [12,13,14,5], [11,16,15,6], [10,9,8,7]]
 图解：
  01 → 02 → 03 → 04
                 ↓
  12 → 13 → 14   05
  ↑         ↓    ↓
  11   16 ← 15   06
  ↑              ↓
  10 ← 09 ← 08 ← 07
 
 示例：
 输入：n = 5
 输出：[[1,2,3,4,5], [16,17,18,19,6], [15,24,25,20,7], [14,23,22,21,8], [13,12,11,10,9]]
 图解：
  01 → 02 → 03 → 04 → 05
                      ↓
  16 → 17 → 18 → 19   06
  ↑              ↓    ↓
  15   24 → 25   20   07
  ↑    ↑         ↓    ↓
  14   23 ← 22 ← 21   08
  ↑                   ↓
  13 ← 12 ← 11 ← 10 ← 09
 
 示例：
 输入：n = 6
 输出：[[1,2,3,4,5,6], [20,21,22,23,24,7], [19,32,33,34,25,8], [18,31,36,35,26,9], [17,30,29,28,27,10], [16,15,14,13,12,11]]
 图解：
  01 → 02 → 03 → 04 → 05 → 06
                           ↓
  20 → 21 → 22 → 23 → 24   07
  ↑                   ↓    ↓
  19   32 → 33 → 34   25   08
  ↑    ↑         ↓    ↓    ↓
  18   31   36 ← 35   26   09
  ↑    ↑              ↓    ↓
  17   30 ← 29 ← 28 ← 27   10
  ↑                        ↓
  16 ← 15 ← 14 ← 13 ← 12 ← 11
 */


/********************解题********************/
class Solution_059 {
    func generateMatrix(_ n: Int) -> [[Int]] {
        // 生成二维数组
        var result = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        
        var startRow = 0
        var startColumn = 0
        /*
         表示螺旋排列有多少圈
         如果（n == 3），则需要循环 1 次，中间的值，需要单独处理
         如果（n == 4），则需要循环 2 次，刚好两个圈
         如果（n == 5），则需要循环 2 次，中间的值，需要单独处理
         ...
         */
        var loopCount = n / 2
        
        // 如果n是单数的话，这个就是表示中点的的行列位置
        let mid = n / 2
        // 填充数
        var count = 1
        // 每循环一圈，需要控制每一条边遍历的长度
        var offset = 1
        // 行
        var row: Int
        // 列
        var column: Int
        
        while loopCount > 0 {
            row = startRow
            column = startColumn
            
            // 模拟填充上行，从左到右(左闭右开)
            // 填充上行的时候，行数不变，增加列数
            for c in column ..< startColumn + n - offset {
                result[startRow][c] = count
                count += 1
                column += 1
            }
            
            // 模拟填充右列，从上到下(上闭下开)
            // 填充右列的时候，列数不变（此时的列数是上一次填充行时的最大值，这样才能保证，行的末端跟列的开始位置连接上），增加行数
            for r in row ..< startRow + n - offset {
                result[r][column] = count
                count += 1
                row += 1
            }
            
            // 模拟填充下行，从右到左(右闭左开)
            // 填充下行的时候，行数不变，减少列数
            for _ in startColumn ..< column {
                result[row][column] = count
                count += 1
                column -= 1
            }
            
            // 模拟填充左列，从下到上(下闭上开)
            // 填充左列的时候，列数不变（此时的列数是上一次填充行时的最小值，这样才能保证，行的末端跟列的开始位置连接上），减少行数
            for _ in startRow ..< row {
                result[row][column] = count
                count += 1
                row -= 1
            }
            
            // 上面四个循环结束后，表示完成一圈了，所以startRow, startColumn需要 + 1，表示进入里面的一圈
            startRow += 1
            startColumn += 1
            
            // 随着圈数的增加，offset需要 + 2，因为每增加一圈，边长就缩短 2
            offset += 2
            // 减少循环次数（缩小圈子）
            loopCount -= 1
        }
        
        if (n % 2) != 0 {// 如果n是奇数，则单独处理中点
            result[mid][mid] = count
        }
        return result
    }
}

/********************测试代码********************/
extension Solution_059 {
    func solution_059_test(_ n: Int) {
        print(self.generateMatrix(n))
    }
}
