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
     模式串：ababb
     所有子串（包括本身）                前缀：                           后缀：                             最大相等前后缀的长度:
     a                                ~                               ~                                        0
     ab                               a                               b                                        0
     aba                              a,ab                            a,ba                                     1
     abab                             a,ab,aba                        b,ab,bab                                 2
     ababb                            a,ab,aba,abab                   b,bb,abb,babb                            0
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
            /*
             当i = 4，j = 2时，我们从(i == 3)这一步中，就明白：我们当前已经找到了长度为2的相等前后缀了。所以这一步，我们先将needle[4]跟needle[2]比较，
             1.如果相等，就找到的最大相等前后缀的长度就是3，就是在上一步中(i == 3)找到的最大相等前后缀的基础上，长度再加1；就是（needle[3] + 1）
             2.如果不相等，
            
             */
            while j > 0 && needle[j] != needle[i] {
                j = next[j - 1]
            }
            /*
             当i = 1，j = 0时，也就是子串只有两个字符的时候，我们next数组第1个元素要么是0，要么是1
             例如，模式串的子串是ab，那最大相等前后缀就是0；如果模式串的子串是aa，那最大相等前后缀就是1。
             在我们的这个例子中，我们是ab，所以j依然等于0，所以当前next数组是[0,0]
             -----------------------------分割线-----------------------------
             当i = 2，j = 0时，也就是子串只有三个字符的时候（假设是ab(x)），那么该子串的前缀是:a,ab；后缀是:x, bx;
             所以得知，如果x是非a，那么我们next数组第2个元素就是0，没有找到相等的前后缀；如果是a，则next数组第2个元素就是1，所以j += 1。
             在我们的这个例子中，我们是aba，找到一个相等的前后缀（a），所以当前next数组是[0,0,1]
             -----------------------------分割线-----------------------------
             当i = 3，j = 1时，我们从上一步（i = 2的时候）就得知，next数组为[0,0,1]，从这里我们可以得出什么信息呢？就是在长度为三个字符的子串中，第一，第二个字符肯定是不相等的，因为next数组第一个元素为0，
             同理可得，第三个字符是跟第一个字符相等的。
             结论：
             needle[0] != needle[1]
             needle[0] == needle[2]
             来到这一步，我们的子串是：aba(x)，那么该子串的前缀就是：a,ab,aba；后缀是：x,ax,bax；来到这一步，我们似乎多了个疑问，就是needle[3]应该先跟谁去坐对比？
             答案就是先跟needle[1]去比较，为什么呢？
             因为我们从前后缀可以获取到的信息就是：无论x是什么，aba这个前缀，跟bax这个后缀是肯定不相等的，那么前缀只剩下a,ab可以跟后缀x,ax来比较；而我们当前的next数组是[0,0,1]，
             说明我们之前的子串中，已经找到一个相等的前后缀了，它的长度是1；所以我们这一步就直接比较needle[3]跟needle[1]就行了，没有必要再从第一个字符开始比较了。
             举个例子：
             就好像去玩刮刮乐，规则就是你只能拿走最高奖金的那张券去兑换奖金。目前情况就是你的钱只能够买4张刮刮乐，而且现在已经刮出来：0元，0元，1元，裤兜还剩下只能购买一张刮刮乐的钱。
             当你准备买最后一张刮刮乐的时候，突然有个小道士跟你说『我看你骨骼惊奇，指条明路给你吧』，然后拿起一张刮刮乐，叫你买它，并偷偷告诉了你『这是一张神券，有50%的概率是2元，有50%概率
             是0元』。可惜这句话被隔壁的路人甲听到了，然后路人甲跟你说：『小兄弟，我这里有一张1元的券，要不要跟你换，免得你有50%的概率得到0元』。这个时候你怎么选，肯定不跟他换，因为你已经有一张
             1元的券了，你拿再多的1元券，你最后也只能兑换1元，那还不如博一把，起码有50%的概率是可以得2元，所以这就是为什么needle[3]要先跟needle[1]比较。
             因为有50%的概率会找到长度为2的相等前后缀。最后，我们得出needle[3]跟needle[1]相等，所以next数组为：[0,0,1,2]
             */
            if needle[j] == needle[i] {
                j += 1
            }
            
            next[i] = j
        }
        
        return next
    }
}
