//
//  miscExtension.swift
//  matcher
//
//  Created by Geoff Burns on 12/11/19.
//  Copyright © 2019 Geoff Burns. All rights reserved.
//

import Foundation

public extension Int
{
    var random : Int
    {
             return Int(arc4random_uniform(UInt32(self)))
    }
}
public enum Coin
{
    static var flip : Bool { get { return 0 == 2.random }}
}
