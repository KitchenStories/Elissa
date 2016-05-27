//
//  UIViewControllerExtension.swift
//  Pods
//
//  Created by Kersten Broich on 27/05/16.
//
//

import Foundation

public typealias CompletionHandlerClosure = () -> ()?

extension UIViewController {
    
    public func showElissaFromTabbar(itemIndex tabbarItemIndex: Int, imageName: String, message: String, onTouchHandler: CompletionHandlerClosure) {
        guard tabBarController != nil else { return }
        
        guard tabbarItemIndex <= tabBarController?.tabBar.items?.count else { return }
        
        guard let view = tabBarController?.tabBar.items?[tabbarItemIndex].valueForKey("view") as? UIView else { return }
        
        if Elissa.isVisible {
            Elissa.dismiss()
        }
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            if let elissa = Elissa.showElissa(self.updatePresentingFrame(view), imageName: imageName, message: message, handler: onTouchHandler) {
                self.tabBarController?.view.addSubview(elissa)
                elissa.transform = CGAffineTransformMakeScale(0.8, 0.8)
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6, options: .CurveEaseInOut, animations: {
                    elissa.transform = CGAffineTransformIdentity
                    }, completion: { _ in
                        self.tabBarController?.view.bringSubviewToFront(elissa)
                })
            }
        }
    }
    
    public func dismissElissa() {
        Elissa.dismiss()
    }
    
    private func updatePresentingFrame(sourceView: UIView) -> UIView {
        var sourceFrame = sourceView.frame
        
        if let height = tabBarController?.tabBar.frame.size.height {
            sourceFrame.origin.y = UIScreen.mainScreen().applicationFrame.size.height - height / 2
        }
        
        let updatedSourceView = UIView(frame: sourceFrame)
        
        return updatedSourceView
    }
}
