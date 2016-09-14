//
//  UIViewControllerExtension.swift
//  Pods
//
//  Created by Kersten Broich on 27/05/16.
//
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


public typealias CompletionHandlerClosure = () -> ()?

extension UIViewController {
    
    public func showElissaFromTabbar(itemIndex tabbarItemIndex: Int, configuration: ElissaConfiguration, onTouchHandler: @escaping CompletionHandlerClosure) {
        guard
            tabBarController != nil && tabbarItemIndex <= tabBarController?.tabBar.items?.count,
            let view = tabBarController?.tabBar.items?[tabbarItemIndex].value(forKey: "view") as? UIView
            else { return }
        
        if Elissa.isVisible {
            Elissa.dismiss()
        }
        
        let delayTime = DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            guard let elissa = Elissa.showElissa(self.updatePresentingFrame(view), configuration: configuration, handler: onTouchHandler) else { return }
            
            self.tabBarController?.view.addSubview(elissa)
            elissa.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6, options: UIViewAnimationOptions(), animations: {
                elissa.transform = CGAffineTransform.identity
                }, completion: { _ in
                    self.tabBarController?.view.bringSubview(toFront: elissa)
            })
        }
    }
    
    fileprivate func updatePresentingFrame(_ sourceView: UIView) -> UIView {
        var sourceFrame = sourceView.frame
        
        if let height = tabBarController?.tabBar.frame.size.height {
            sourceFrame.origin.y = UIScreen.main.applicationFrame.size.height - height / 2
        }
        
        let updatedSourceView = UIView(frame: sourceFrame)
        
        return updatedSourceView
    }
}
