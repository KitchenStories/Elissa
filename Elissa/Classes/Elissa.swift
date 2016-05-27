//
//  Elissa.swift
//  Kitchen Stories
//
//  Created by Kersten Broich on 05/04/16.
//  Copyright © 2016 Kitchen Stories. All rights reserved.
//

import Foundation


public class Elissa: UIView {

    public static var isVisible: Bool {
        return true
    }
    
//    public static var handler: CompletionHandlerClosure!
//    static var contentView: ElissaContentView?

    public static func dismiss() {
//        if contentView != nil {
//            contentView!.removeFromSuperview()
//            contentView = nil
//        }
    }
    
    static func showElissa(sourceView: UIView, imageName: String, message: String, handler: CompletionHandlerClosure) -> UIView? {

        let elissa = Elissa(view: sourceView, imageName: imageName, message: message)
        elissa.handler = handler

        
//        if contentView == nil {
//            contentView = ElissaContentView(view: sourceView, imageName: imageName, message: message, handler: handler)
//            self.handler = handler
//        }
//    
//        return contentView
        return nil
    }
    
    private var handler: CompletionHandlerClosure!
    
    @IBOutlet weak var messageLabel: UILabel!
//        {
//        didSet {
//            messageLabel.font = Theme.currentTheme().textFont
//            messageLabel.textColor = Theme.currentTheme().textColor
//        }
//    }
    
    @IBOutlet weak var iconImageView: UIImageView!
//        {
//        didSet {
//            tintColor = Theme.currentTheme().textColor
//        }
//    }
//    
    @IBAction func actionButtonTapped(sender: UIButton) {
        handler()
    }
    
    private (set) var arrowSize: CGSize = CGSize(width: 20, height: 10)
    private (set) var popupHeight: CGFloat = 36.0
    private (set) var offsetToSourceView: CGFloat = 5.0
    private (set) var popupMinMarginScreenBounds: CGFloat = 5.0

    
    private init(view: UIView, imageName: String, message: String) {
        super.init(frame: CGRect.zero)
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let views = bundle.loadNibNamed("Elissa", owner: self, options: nil)
        
        guard let embeddedContentView = views.first as? UIView else { return }
        addSubview(embeddedContentView)
        
        embeddedContentView.backgroundColor = UIColor.lightGrayColor()
        messageLabel.text = message
        iconImageView.image = UIImage(named: imageName)
        
        calculatePositon(sourceView: view, contentView: self)
        embeddedContentView.layer.cornerRadius = 3.0
        
        embeddedContentView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        bringSubviewToFront(embeddedContentView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func calculatePositon(sourceView sourceView: UIView, contentView: UIView) -> UIView {
        let size = messageLabel.intrinsicContentSize()
        
        var updatedFrame = CGRect()
        updatedFrame.size.width = size.width + 45 // TODO: get values from autolayout constraints
        updatedFrame.size.height = popupHeight
        updatedFrame.origin.x = sourceView.center.x - updatedFrame.size.width / 2
        updatedFrame.origin.y = (sourceView.frame.origin.y - sourceView.frame.size.height) + offsetToSourceView
        
        contentView.frame = updatedFrame
        contentView.layer.cornerRadius = 3
        
        let checkPoint = contentView.frame.origin.x + contentView.frame.size.width
        let appWidth = UIScreen.mainScreen().applicationFrame.size.width
        
        var offset: CGFloat = 0.0
        
        if checkPoint > UIScreen.mainScreen().applicationFrame.size.width {
            offset = checkPoint - appWidth
            applyOffset(offset, view: contentView)
        }
        
        drawTriangleForTabBarItemIndicator(contentView, tabbarItem: sourceView)
        
        return contentView
    }
    
    private func drawTriangleForTabBarItemIndicator(popupView: UIView, tabbarItem: UIView) {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        let startPoint = (tabbarItem.center.x - arrowSize.width / 2) - popupView.frame.origin.x
        
        path.moveToPoint(CGPoint(x: startPoint, y: popupView.frame.size.height))
        path.addLineToPoint(CGPoint(x: startPoint + (arrowSize.width / 2), y: popupView.frame.size.height + arrowSize.height))
        path.addLineToPoint(CGPoint(x: startPoint + arrowSize.width, y: popupView.frame.size.height))
        
        path.closePath()
        
        shapeLayer.path = path.CGPath
//        shapeLayer.fillColor = Theme.currentTheme().highlightColor.CGColor
        shapeLayer.fillColor = UIColor.lightGrayColor().CGColor
        popupView.layer.addSublayer(shapeLayer)
    }
    
    private func applyOffset(offset: CGFloat, view: UIView) {
        var frame = view.frame
        frame.origin.x -= (offset + popupMinMarginScreenBounds)
        view.frame = frame
    }
}
