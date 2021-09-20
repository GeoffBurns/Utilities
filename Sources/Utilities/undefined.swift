//
//  Undefined.swift
//
//  Created by Johannes Weiss
//  https://academy.realm.io/posts/swift-summit-johannes-weiss-the-type-system-is-your-friend/

import Foundation
import SwiftUI

func undefined<T>(_ message: String = "") -> T {
    fatalError("Undefined: \(message)")
}
 
