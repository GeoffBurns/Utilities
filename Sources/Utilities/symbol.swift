//
//  Symbol.swift
//  matcher
//
//  Created by Geoff Burns on 13/11/19.
//  Copyright © 2019 Geoff Burns. All rights reserved.
//


import SwiftUI

#if os(macOS)

public enum Device
{
    static var isPad: Bool {
        true
    }
}
#else

public enum Device
{
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}
#endif

public enum Symbol
{
    case up
    case down
    case left
    case right
    case help
    case undo
    case concede
    case gear
    case gameCenter
    
    public var name :String
    {
        switch self
        {
        case .up : return "arrow.up"
        case .down : return "arrow.down"
        case .left : return "arrow.left"
        case .right : return "arrow.right" 
        case .help : return "book"
        case .undo : return "memories"
        case .concede : return "clear"
        case .gear : return "gear"
        case .gameCenter : return "person.2.fill"
        }
    }
    public var image : some View {
        
        return Image(systemName: self.name).font(Font.system(size: Symbol.fontsize, weight: .black))
    }
    public static let smallfont : CGFloat = 30
    public static let bigfont : CGFloat = 60
    public static var fontsize : CGFloat {get{ Device.isPad ? Symbol.bigfont : Symbol.smallfont}}
    public static func ones(_ score:Int) -> some View
    {
        
        return Image(systemName: "\(score%10).circle.fill").font(Font.system(size: Symbol.fontsize, weight: .black))
    }
    
    public static func tens(_ score:Int) -> some View
    {
            return Image(systemName: "\((score/10)%10).circle.fill").font(Font.system(size: Symbol.fontsize, weight: .black))
    }
    public static func hundreds(_ score:Int) -> some View
    {

        return Image(systemName: "\((score/100)%10).circle.fill").font(Font.system(size: Symbol.fontsize, weight: .black))

    }
    public static func thousands(_ score:Int) -> some View
    {
                return Image(systemName: "\((score/1000)%10).circle.fill").font(Font.system(size: Symbol.fontsize, weight: .black))
    }
    public static func showScore(_ score:Int) -> some View {
        return Group {
        
                            Spacer()
                            if score >= 1000 {
                                Symbol.thousands(score)
                            }
                             Symbol.hundreds(score)
                             Symbol.tens(score)
                             Symbol.ones(score)
      }
    }
 
}
