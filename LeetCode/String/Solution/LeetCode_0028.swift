//
//  LeetCode_0028.swift
//  LeetCode
//
//  Created by 余杜林 on 2021/9/4.
//  Copyright © 2021 Du. All rights reserved.
//

import Foundation
/**
 题目：
 28. 实现 strStr()
 实现 strStr() 函数。
 给你两个字符串 haystack 和 needle ，请你在 haystack 字符串中找出 needle 字符串出现的第一个位置（下标从 0 开始）。如果不存在，则返回  -1 。

 说明：
 当 needle 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。
 对于本题而言，当 needle 是空字符串时我们应当返回 0 。这与 C 语言的 strstr() 以及 Java 的 indexOf() 定义相符。
 */


/********************解题********************/
class Solution_0028 {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        return -1
    }
    
    /// Brute-Force算法
    func bruteForce(_ haystack: String, _ needle: String) -> Int {
        let lenS = haystack.count
        let lenP = needle.count
        var pos = -1
        
        /// 2种特殊情况
        if haystack.count < needle.count {
            return -1
        }
        
        if needle.count == 0 {
            return 0
        }
        
        // 主字符串的遍历区间是[0, lenS - lenP]
        // 因为：如果模式串右边超出主字符串的右边，那就肯定不会匹配成功了（因为 主串剩下的长度 跟 模式串的长度 已经不相等了），就没必要继续遍历下去了
        // 例如主字符串是：Abandon；模式串是：kdon，当匹配到这种情况，还没匹配上的时候，就没必须继续比较了
        /*
         上一步：
         S: Abandon
         P:    kdon
         下一步：
         S: Abandon
         P:     kdon
         这时候，模式串已经超过主字符串的右边了
        */
        for i in 0...(lenS - lenP) {
            // 用来标记是否匹配成功，默认成功
            var flag = true
            
            for j in 0..<lenP {
//                let kmpString_s = "AABDJHKLKERJBDJHKLKKFH"
//                let kmpString_p = "BDJHKLKK"
                let targetInS = haystack[haystack.index(haystack.startIndex, offsetBy: (i + j))]
                print("主串：\(targetInS)")
                let targetInP = needle[needle.index(needle.startIndex, offsetBy: j)]
                print("模式串：\(targetInP)")
                print("--------------------")
                if targetInS != targetInP {
                    flag = false
                    break
                }
                
                if flag {
                    pos = i
                }
            }
        }
        
        return pos
    }
    /*
     经过上面的暴力算法，可以得知，时间复杂度是在O(nm)，因为：
     最坏的情况就是主字符串是这种形式：AAAAAA...B，模式串是：AAA...B
     这里假设 n 是主字符串的长度，m 是模式串的长度，所以主字符串中，每向右挪一位，都需要比较整个模式串，也就是 m 次，而主字符串需要比较 (n - m  + 1) 次，所以复杂度是：O(m * (n - m  + 1))，但是一般情况下，主字符串比模式串长很多，忽略常数项，那时间复杂度是 O(nm)。
     ⭐⭐：而且如果主字符串中出现多个模式串，那 pos 只会记录最后匹配上的模式串的位置
     */
    
    /*
     //这一块比较难懂，不想看的同学可以忽略，了解大致含义即可，或者自己调试一下，看看运行情况
     //我会每一步都写上注释
     public  int[] next (char[] needle,int len) {
         //定义 next 数组
         int[] next = new int[len];
         // 初始化
         next[0] = -1;
         int k = -1;
         for (int i = 1; i < len; ++i) {
             //我们此时知道了 [0,i-1]的最长前后缀，但是k+1的指向的值和i不相同时，我们则需要回溯
             //因为 next[k]就时用来记录子串的最长公共前后缀的尾坐标（即长度）
             //就要找 k+1前一个元素在next数组里的值,即next[k+1]
             while (k != -1 && needle[k + 1] != needle[i]) {
                 k = next[k];
             }
             // 相同情况，就是 k的下一位，和 i 相同时，此时我们已经知道 [0,i-1]的最长前后缀
             //然后 k - 1 又和 i 相同，最长前后缀加1，即可
             if (needle[k+1] == needle[i]) {
                 ++k;
             }
             next[i] = k;

         }
         return next;
     }
     */
    
//    func getNext(needle: [Character], len: Int) -> [Int] {
//        var next = Array<Int>()
//
//        next[0] = -1
//        var k = -1
//
//        for i in 1..<len {
//            while k != -1 && needle[k + 1] != needle[i] {
//                k = next[k]
//            }
//
//            if needle[k+1] == needle[i] {
//                k += 1
//            }
//
//            next[i] = k
//        }
//
//        return next
//    }
    
    /*
     模式串：ababaab
     所有子串（包括本身）                前缀：                           后缀：                             最大相等前后缀的长度:
     a                                ~                               ~                                        0
     ab                               a                               b                                        0
     aba                              a,ab                            a,ba                                     1
     abab                             a,ab,aba                        b,ab,bab                                 2
     ababa                            a,ab,aba,abab                   a,ba,aba,baba                            3
     ababaa                           a,ab,aba,abab,ababa             a,aa,baa,abaa,babaa                      1
     ababaab                          a,ab,aba,abab,ababa,ababaa      b,ab,aab,baab,abaab,babaab               2
     */
    
    /// 根据模式串来计算next数组
    /// - Parameter needle: 模式串字符数组
    /// - Returns: 返回数组，数组保存着模式串 所有子串 的 最大相等前后缀 的 长度
    func getNext(needle: [Character]) -> [Int] {
        /*
         初始化next数组，长度肯定跟模式串一致，
         这里先用-1填充各个元素。但是next数组的元素最后肯定都是≥0的，因为最大相等前后缀，要么没有（就是0），要么就有若干个，一旦有一个，那这个相等的前后缀就肯定大于0
         */
        var next = Array<Int>(repeating: -1, count: needle.count)
        // 当模式串的子串是只有一个字符，那它就是没有前后缀，所以该子串的 最大相等前后缀 的 长度为0
        next[0] = 0
        
        var j = 0
        
        for i in 1..<needle.count {
            while j > 0 && needle[j] != needle[i] {
                j = next[j - 1]
            }
            /*
             当i = 1，j = 0时，也就是子串只有两个字符的时候，我们next数组第1个元素要么是0，要么是1
             例如，模式串的子串是ab，那最大相等前后缀就是0；如果模式串的子串是aa，那最大相等前后缀就是1。
             在我们的这个例子中，我们是ab，所以j依然等于0，所以当前next数组是[0,0]
             
             当i = 2，j = 0时，也就是子串只有三个字符的时候，我们next数组第2个元素要么是0，要么是1
             */
            if needle[j] == needle[i] {
                j += 1
            }
            
            next[i] = j
        }
        
        return next
    }
}