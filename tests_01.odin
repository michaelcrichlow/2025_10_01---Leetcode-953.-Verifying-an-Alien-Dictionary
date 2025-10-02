/*
Leetcode 953. Verifying an Alien Dictionary
*/

package test

import "core:fmt"
print :: fmt.println

main :: proc() {
    print(is_alien_sorted(words = {"hello","leetcode"}, order = "hlabcdefgijkmnopqrstuvwxyz"))      // true
    print(is_alien_sorted(words = {"word","world","row"}, order = "worldabcefghijkmnpqstuvxyz"))    // false
    print(is_alien_sorted(words = {"apple","app"}, order = "abcdefghijklmnopqrstuvwxyz"))           // false
    print(is_alien_sorted(words = {"kuvp","q"}, order = "ngxlkthsjuoqcpavbfdermiywz"))           // true

    // OUTPUT:
    // true
    // false
    // false
    // true
}

// Determines whether a list of words is sorted according to a custom alien dictionary order.
is_alien_sorted :: proc(words: []string, order: string) -> bool {
    // Create a fixed-size array to store the rank of each ASCII character based on the alien order.
    // Each character in 'order' is assigned a unique rank from 0 to 25 (or however long 'order' is).
    rank := [256]u8{}

    // Populate the rank array: rank[char] = position of char in 'order'
    // If 'h' is first, then rank['h'] = 0, and so on...
    for i in 0 ..< len(order) {
        rank[order[i]] = u8(i)
    }

    // Helper function to compare two words based on the alien rank map.
    // Returns true if w1 comes before w2 in alien order, false otherwise.
    in_order :: proc(w1: string, w2: string, rank: []u8) -> bool {
        // Compare characters one by one until a difference is found or one word ends.
        for i in 0 ..< min(len(w1), len(w2)) {
            if rank[w1[i]] < rank[w2[i]] {
                return true  // w1 is less than w2
            }
            if rank[w1[i]] > rank[w2[i]] {
                return false // w1 is greater than w2
            }
        }
        // If all compared characters are equal, the shorter word should come first.
        return len(w1) <= len(w2)
    }

    // Iterate through the list of words and check if each pair is in correct order.
    for i in 1 ..< len(words) {
        if !in_order(words[i - 1], words[i], rank[:]) {
            return false  // Found a pair out of order
        }
    }

    // All pairs are in correct order
    return true
}


// another solution that uses `rank := [26]u8` 
is_alien_sorted :: proc(words: []string, order: string) -> bool {
    // Create a fixed-size array to store the rank of each ASCII character based on the alien order.
    // Each character in 'order' is assigned a unique rank from 0 to 25 (or however long 'order' is).
    // rank := [256]u8{}
    rank := [26]u8{}

    // Populate the rank array: rank[char] = position of char in 'order'
    // If 'h' is first, then rank['h'] = 0, and so on...
    for i in 0 ..< len(order) {
        rank[order[i] - 'a'] = u8(i)
    }

    // Helper function to compare two words based on the alien rank map.
    // Returns true if w1 comes before w2 in alien order, false otherwise.
    in_order :: proc(w1: string, w2: string, rank: []u8) -> bool {
        // Compare characters one by one until a difference is found or one word ends.
        for i in 0 ..< min(len(w1), len(w2)) {
            if rank[w1[i] - 'a'] < rank[w2[i] - 'a'] {
                return true  // w1 is less than w2
            }
            if rank[w1[i] - 'a'] > rank[w2[i] - 'a'] {
                return false // w1 is greater than w2
            }
        }
        // If all compared characters are equal, the shorter word should come first.
        return len(w1) <= len(w2)
    }

    // Iterate through the list of words and check if each pair is in correct order.
    for i in 1 ..< len(words) {
        if !in_order(words[i - 1], words[i], rank[:]) {
            return false  // Found a pair out of order
        }
    }

    // All pairs are in correct order
    return true
}


/*
PYTHON:
class Solution:
    def isAlienSorted(self, words: List[str], order: str) -> bool:
        rank = {char: i for i, char in enumerate(order)}

        def in_order(w1, w2):
            for c1, c2 in zip(w1, w2):
                if rank[c1] < rank[c2]:
                    return True
                if rank[c1] > rank[c2]:
                    return False
            return len(w1) <= len(w2)

        for i in range(1, len(words)):
            if not in_order(words[i - 1], words[i]):
                return False
        return True

*/



