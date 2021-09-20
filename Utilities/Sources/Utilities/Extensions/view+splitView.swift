//
//  view+splitView.swift 
//
//  Created by Geoff Burns on 20/9/21.
//

import Foundation
import SwiftUI
 
@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
struct SplitViewModifier: ViewModifier {
    let isSplit: Bool
    func body(content: Content) -> some View {
        #if os(macOS)
            content.navigationViewStyle(DoubleColumnNavigationViewStyle())
        #else
        if isSplit
        {
            content.navigationViewStyle(DoubleColumnNavigationViewStyle())
        } else
        {
            content.navigationViewStyle(StackNavigationViewStyle())
        }
        #endif
    }
}
@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
struct SplitViewOnLandscapeModifier: ViewModifier {
    #if os(macOS)
    private var isSplit : Bool { true }
    #else
    @State private var orientation = UIDevice.current.orientation
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    private var isSplit : Bool { idiom == .pad && !orientation.isPortrait }
    #endif
    
    func body(content: Content) -> some View {
        #if os(macOS)
          content
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
        #else
          content
                .onRotate { newOrientation in
                    orientation = newOrientation
                }
            .navigationViewStyleChoice(isSplit)
        #endif 
    }
}

extension View {
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
    public func navigationViewStyleChoice(_ isSplit: Bool) -> some View
        {
            self.modifier(SplitViewModifier(isSplit: isSplit))
        }
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
    public func splitOnLandscapeMavigationViewStyle() -> some View
      {
          self.modifier(SplitViewOnLandscapeModifier())
      }

}

