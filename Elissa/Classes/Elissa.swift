//
//  Elissa.swift
//  Kitchen Stories
//
//  Created by Kersten Broich on 05/04/16.
//  Copyright © 2016 Kitchen Stories. All rights reserved.
//

import Foundation


public class Elissa: UIView {

    static var isVisible: Bool {
        return true
    }
    
    static var handler: CompletionHandlerClosure = { return nil }
//    static var contentView: ElissaContentView?

    static func dismiss() {
//        if contentView != nil {
//            contentView!.removeFromSuperview()
//            contentView = nil
//        }
    }
    
    static func showElissa(sourceView: UIView, imageName: String, message: String, handler: CompletionHandlerClosure) -> UIView? {
//        if contentView == nil {
//            contentView = ElissaContentView(view: sourceView, imageName: imageName, message: message, handler: handler)
//            self.handler = handler
//        }
//    
//        return contentView
        return nil
    }
}

