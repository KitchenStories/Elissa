//
//  Elissa.swift
//  Kitchen Stories
//
//  Created by Kersten Broich on 05/04/16.
//  Copyright © 2016 Kitchen Stories. All rights reserved.
//

import Foundation

public class ElissaConfiguration: NSObject {
    public var message: String?
    public var image: UIImage?
    public var backgroundColor: UIColor?
    public var textColor: UIColor?
    public var font: UIFont?
    public var arrowOffset: CGFloat = 2
    
    public override init() {}
}

open class Elissa: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    private let arrowSize: CGSize = CGSize(width: 20, height: 10)
    private let popupHeight: CGFloat = 36.0
    private let offsetToSourceView: CGFloat = 5.0
    private var popupMinMarginScreenBounds: CGFloat = 5.0
    
    private let configuration: ElissaConfiguration
    private static var staticElissa: Elissa?
    private var completionHandler: (() -> Void)?
    private weak var sourceView: UIView?
    
    open static var isVisible: Bool {
        return staticElissa != nil
    }
    
    internal init(sourceView: UIView, configuration: ElissaConfiguration, completionHandler: (() -> Void)?) {
        self.configuration = configuration
        self.completionHandler = completionHandler
        self.sourceView = sourceView
        
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
        
        if let image = configuration.image {
            iconImageView.image = image
            iconImageView.tintColor = configuration.textColor
        } else {
            iconImageView.removeFromSuperview()
        }
        
        calculatePositon()
        embeddedContentView.layer.cornerRadius = 3.0

        embeddedContentView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        bringSubview(toFront: embeddedContentView)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        calculatePositon()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open static func dismiss() {
        if let staticElissa = staticElissa {
            staticElissa.removeFromSuperview()
            self.staticElissa = nil
        }
        NotificationCenter.default.removeObserver(self)
    }
    
    static func showElissa(_ sourceView: UIView, configuration: ElissaConfiguration, completionHandler: (() -> Void)?) -> Elissa {
        NotificationCenter.default.addObserver(self, selector: #selector(dismiss), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        let staticElissa = Elissa(sourceView: sourceView, configuration: configuration, completionHandler: completionHandler)
        self.staticElissa = staticElissa
        return staticElissa
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        completionHandler?()
    }
    
    private func calculatePositon() {
        guard let sourceView = sourceView else { return }
        var updatedFrame = CGRect()
        
        let margin: CGFloat = 8
        if configuration.image != nil {
            updatedFrame.size.width = iconImageView.frame.size.width + messageLabel.frame.size.width + margin * 3
        } else {
            updatedFrame.size.width = messageLabel.frame.size.width + margin * 2
        }
        updatedFrame.size.height = popupHeight
        updatedFrame.origin.x = sourceView.center.x - updatedFrame.size.width / 2
        updatedFrame.origin.y = (sourceView.frame.origin.y - popupHeight) - arrowSize.height + configuration.arrowOffset
        
        frame = updatedFrame
        layer.cornerRadius = 5
        
        let checkPoint = frame.maxX
        
        let appWidth = superview?.frame.width ?? UIScreen.main.applicationFrame.size.width
        
        var offset: CGFloat = 0.0
        
        if checkPoint > appWidth {
            offset = checkPoint - appWidth
        } else if frame.origin.x < 5 {
            popupMinMarginScreenBounds *= -1
            offset = frame.origin.x
        }
        applyOffset(offset, view: self)
        
        drawTriangleForTabBarItemIndicator(self, sourceView: sourceView)
    }
    
    private func drawTriangleForTabBarItemIndicator(_ contentView: UIView, sourceView: UIView) {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        let startPoint = (sourceView.center.x - arrowSize.width / 2) - contentView.frame.origin.x
        
        path.move(to: CGPoint(x: startPoint, y: contentView.frame.size.height))
        path.addLine(to: CGPoint(x: startPoint + (arrowSize.width / 2), y: contentView.frame.size.height + arrowSize.height))
        path.addLine(to: CGPoint(x: startPoint + arrowSize.width, y: contentView.frame.size.height))
        
        path.close()
        
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = (configuration.backgroundColor ?? self.tintColor).cgColor
        contentView.layer.addSublayer(shapeLayer)
    }
    
    private func applyOffset(_ offset: CGFloat, view: UIView) {
        var frame = view.frame
        frame.origin.x -= (offset + popupMinMarginScreenBounds)
        view.frame = frame
    }
}
