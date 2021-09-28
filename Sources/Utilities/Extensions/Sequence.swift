//
//  SequenceTypeExtension.swift 
//
//  Created by Geoff Burns on 28/10/2015.
//  Copyright © 2015 Nereids Gold. All rights reserved.
//

import Foundation

public extension Sequence {
    
    /// Categorises elements of self into a dictionary, with the keys given by keyFunc
    
    func categorise<U : Hashable>(_ keyFunc: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var dict: [U:[Iterator.Element]] = [:]
        for el in self {
            let key = keyFunc(el)
            dict[key]?.append(el) ?? {dict[key] = [el]}()
        }
        return dict
    }
    func then<S: Sequence>(_ sequence: S) -> AnySequence<Self.Element> where Self.Element == S.Element {
      var (first, second) = (self.makeIterator(), sequence.makeIterator())
      return AnySequence(AnyIterator { first.next() ?? second.next() })
    }
    func from(_ n: Int, forLength: Int) -> [Iterator.Element] {
        
        var result : [Iterator.Element]
        result = []
        result.reserveCapacity(forLength)
        
        var g = makeIterator()
        for _ in 0..<n {
            if let _ = g.next() { /* skip */ } else { return [] }
        }
        for _ in 0..<forLength {
            if let e = g.next() { result.append(e) } else { return result }
        }
        
        return result
    }
    
     func rotate(_ n: Int) -> [Iterator.Element] {
        
        var result : [Iterator.Element]
        result = []
        result.reserveCapacity(self.underestimatedCount)
        
        var g = makeIterator()
        for _ in 0..<n {
            if let _ = g.next() { /* skip */ } else { return Array(self) }
        }
        repeat {
            if let e = g.next() { result.append(e) } else { break }
        } while true
        g = makeIterator()
        for _ in 0..<n {
            if let e = g.next() { result.append(e) } else { break }
        }
        return result
    }
    var head : Iterator.Element? {

        var g = makeIterator()
    
        return g.next() 
    }
    
    func notAll(_ predicate: (Iterator.Element) -> Bool) -> Bool {
        
        var g = makeIterator()
        
        repeat {
            if let e = g.next() {
                if !predicate(e) { return true }
                
            }
            else { return false }
        } while true
    }
     func all(_ predicate: (Iterator.Element) -> Bool) -> Bool {
        
        var g = makeIterator()
        
        repeat {
            if let e = g.next() {
                if !predicate(e) { return false }
                
            }
            else { return true }
        } while true
    }
    func some(_ predicate: (Iterator.Element) -> Bool) -> Bool {
        
        var g = makeIterator()
        
        repeat {
            if let e = g.next() {
                if predicate(e) { return true }
                
            }
            else { return false }
        } while true
    }
    func none(_ predicate: (Iterator.Element) -> Bool) -> Bool {
        
        var g = makeIterator()
        
        repeat {
            if let e = g.next() {
                if predicate(e) { return false }
                
            }
            else { return true }
        } while true
    }
    var tail : [Iterator.Element] {
        
        var result : [Iterator.Element]
        result = []
        result.reserveCapacity(self.underestimatedCount)
        
        var g = makeIterator()
        
        if let _ = g.next() { /* skip */ } else { return [] }
        
        repeat {
            if let e = g.next() { result.append(e) } else { return result }
        } while true
        
    }

}
