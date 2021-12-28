//
//  CPP_0059.cpp
//  LeetCode
//
//  Created by Du on 2021/12/28.
//  Copyright © 2021 Du. All rights reserved.
//

#include "CPP_0059.hpp"

vector<vector<int>> CPP_0059::generateMatrix(int n) {
    vector<vector<int>> matrix(n, vector<int>(n, 0));
    int startRow = 0, startColum = 0;
    int loopCount = n / 2, mid = n / 2;
    int count = 1;
    int offset = 1;
    int row, column;
    
    while (loopCount--) {
        row = startRow;
        column = startColum;
        
        for (column = startColum; column < startColum + n - offset; ++column) {
            matrix[row][column] = count++;
        }
        
        for (row = startRow; row < startRow + n - offset; ++row) {
            matrix[row][column] = count++;
        }
        
        for (; column > startColum; --column) {
            matrix[row][column] = count++;
        }
    
        for (; row > startRow; --row) {
            matrix[row][column] = count++;
        }
        
        startRow++;
        startColum++;
        
        offset += 2;
        
    }
    
    if (n % 2) {
        matrix[mid][mid] = count;
    }
    
    return matrix;
}
