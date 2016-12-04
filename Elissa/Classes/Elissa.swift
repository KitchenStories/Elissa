//
//  Elissa.swift
//  Kitchen Stories
//
//  Created by Kersten Broich on 05/04/16.
//  Copyright © 2016 Kitchen Stories. All rights reserved.
//

import Foundation

public class ElissaConfiguration : NSObject {
    public var message: String?
    public var image: UIImage?
    public var backgroundColor: UIColor?
    public var textColor: UIColor?
    public var font: UIFont?
    
    public override init() {}
}

open class Elissa: UIView {

    open static var isVisible: Bool {
        return staticElissa != nil
    }
    
    private static var staticElissa: Elissa?

    open static func dismiss() {
        if staticElissa != nil {
            staticElissa!.removeFromSuperview()
            staticElissa = nil
        }
        NotificationCenter.default.removeObserver(self)
    }

    static func showElissa(_ sourceView: UIView, configuration: ElissaConfiguration, handler: ((Void) -> (Void))?) -> UIView? {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        staticElissa = Elissa(view: sourceView, configuration: configuration)
        staticElissa?.handler = handler
        return staticElissa
    }
    
    static func orientationChange() {
        Elissa.dismiss()
    }
    
    private var handler: ((Void) -> (Void))?
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
 
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        handler?()
    }
    
    private let arrowSize: CGSize = CGSize(width: 20, height: 10)
    private let popupHeight: CGFloat = 36.0
    private let offsetToSourceView: CGFloat = 5.0
    private var popupMinMarginScreenBounds: CGFloat = 5.0
    
    private init(view: UIView, configuration: ElissaConfiguration) {
        
        super.init(frame: CGRect.zero)
        
        let bundle = Bundle(for: type(of: self))
        let views = bundle.loadNibNamed("Elissa", owner: self, options: nil)
        
        guard let embeddedContentView = views?.first as? UIView else { return }
        addSubview(embeddedContentView)
        
        embeddedContentView.backgroundColor = configuration.backgroundColor
        
        messageLabel.text = configuration.message
        messageLabel.font = configuration.font
        messageLabel.textColor = configuration.textColor
        layoutIfNeeded()
        
        iconImageView.image = configuration.image
        iconImageView.tintColor = configuration.textColor
        
        calculatePositon(sourceView: view, contentView: self, backgroundColor: configuration.backgroundColor ?? self.tintColor)
        embeddedContentView.layer.cornerRadius = 3.0

        embeddedContentView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        bringSubview(toFront: embeddedContentView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult private func calculatePositon(sourceView: UIView, contentView: UIView, backgroundColor: UIColor) -> UIView {
        var updatedFrame = CGRect()
        updatedFrame.size.width = iconImageView.frame.size.width + messageLabel.frame.size.width + 24
        updatedFrame.size.height = popupHeight
        updatedFrame.origin.x = sourceView.center.x - updatedFrame.size.width / 2
        updatedFrame.origin.y = (sourceView.frame.origin.y - sourceView.frame.size.height) + offsetToSourceView
        
        contentView.frame = updatedFrame
        contentView.layer.cornerRadius = 5
        
        let checkPoint = contentView.frame.origin.x + contentView.frame.size.width
        let appWidth = UIScreen.main.applicationFrame.size.width
        
        var offset: CGFloat = 0.0
        
        if checkPoint > appWidth {
            offset = checkPoint - appWidth
        } else if contentView.frame.origin.x < 5 {
            popupMinMarginScreenBounds *= -1
            offset = contentView.frame.origin.x
        }
        applyOffset(offset, view: contentView)
        
        drawTriangleForTabBarItemIndicator(contentView, tabbarItem: sourceView, backgroundColor: backgroundColor)
        
        return contentView
    }
    
    private func drawTriangleForTabBarItemIndicator(_ popupView: UIView, tabbarItem: UIView, backgroundColor: UIColor) {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        let startPoint = (tabbarItem.center.x - arrowSize.width / 2) - popupView.frame.origin.x
        
        path.move(to: CGPoint(x: startPoint, y: popupView.frame.size.height))
        path.addLine(to: CGPoint(x: startPoint + (arrowSize.width / 2), y: popupView.frame.size.height + arrowSize.height))
        path.addLine(to: CGPoint(x: startPoint + arrowSize.width, y: popupView.frame.size.height))
        
        path.close()
        
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = backgroundColor.cgColor
        popupView.layer.addSublayer(shapeLayer)
    }
    
    private func applyOffset(_ offset: CGFloat, view: UIView) {
        var frame = view.frame
        frame.origin.x -= (offset + popupMinMarginScreenBounds)
        view.frame = frame
    }
}

