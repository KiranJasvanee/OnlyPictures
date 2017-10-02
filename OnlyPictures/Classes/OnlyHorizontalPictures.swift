//
//  OnlyHorizontalPictures.swift
//  KJBubblePictures
//
//  Created by Karan on 28/09/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.
//

import UIKit

public enum PositionOfCount {
    case left, right
}

public enum Alignment {
    case left, center, right
}

public enum RecentAt {
    case left, right
}


public class OnlyHorizontalPictures: OnlyPictures {
    
    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    // layout subviews when layout changes
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.doLayoutChanges()
    }
    
    private func doLayoutChanges() {
        // Set frame of whole buuble picture
        self.resetLayoutBasedOnCurrentPropertyValues()
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    func resetLayoutBasedOnCurrentPropertyValues() {
        
        // OnlyPictures functions
        self.setGap()
        self.setSpacing()
        
        // OnlyHorizontalPictures functions
        self.setPicturesAlignment()
        self.setRecentAt()
        self.setCountPosition()
    }
    
    
    // set pictures alignment --------
    public var alignment: Alignment = .center {
        didSet {
            if (self.dataSource != nil) {
                self.setPicturesAlignment()
            }
        }
    }
    func setPicturesAlignment() {
        
        // Remove constraints of stackview.
        for constraint in super.scrollView.constraints {
            if constraint.firstItem as! NSObject == self.stackView{
                self.scrollView.removeConstraint(constraint)
            }
        }
        
        if checkSupperViewRunningOutOfBounds() {
            
            switch self.alignment {
            case .left, .center, .right:
                self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
                self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
                self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
                self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
                break
            }
            
            self.scrollView.layoutIfNeeded()                          // Based on orientation change, we have to occupy new contentSize to scrollview to receive exact layout.
            self.scrollView.contentSize = self.stackView.bounds.size  // Update scrollview contentSize
            switch self.alignment {
            case .left, .center:
                self.scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
                break
            case .right:
                self.scrollView.scrollRectToVisible(CGRect(x: self.scrollView.contentSize.width-1, y: self.scrollView.contentSize.height-1, width: 1, height: 1), animated: false)
                break
            }
        }else{
            self.scrollView.contentSize = self.stackView.bounds.size // Scrollview size automatically set it's content size based on stackview bounds size increases, but when stackview size decreases it stucks at OnlyHorizontalPictures view's bounds with some extra width. So, it requires to set scrollview content size again with equal to stackview bounds size.
            
            switch self.alignment {
            case .left:
                self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
                self.stackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor).isActive = true
                break
            case .center:
                self.stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
                self.stackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor).isActive = true
                break
            case .right:
                // scrollView's trailingAnchor will return wrong value, which will be in minus to leadingAnchor. Will result to invisible stackview.
                // Solution of this issue: set leadingAnchor of stackView with distance.
                /*
                 <------- Self ----------->
                 --------------------------
                 | distance |<-StackView->|
                 --------------------------
                 */
                self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: (self.bounds.size.width-self.stackView.bounds.size.width)).isActive = true
                self.stackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor).isActive = true
                break
            }
        }
    }
    func checkSupperViewRunningOutOfBounds() -> Bool{
        /*
         If stackview width size greater than super (OnlyPictures) bounds size, it indicates scrollview content size shoulbe be activated.
         Activate it by replacing constraints of scrollview.
         */
        self.layoutIfNeeded()
        if self.stackView.bounds.size.width >= self.bounds.size.width {
            return true
        }else{
            return false
        }
    }
    // -----------------------------
    
    
    // set recentAt ----------------
    public var recentAt: RecentAt = .right {
        didSet {
            if (self.dataSource != nil) {
                self.setRecentAt()
            }
        }
    }
    func setRecentAt() {
        switch self.recentAt {
        case .left:
            self.stackviewOfImageViews.semanticContentAttribute = .forceRightToLeft
            break
        case .right:
            self.stackviewOfImageViews.semanticContentAttribute = .forceLeftToRight
            break
        }
    }
    // -----------------------------
    
    
    
    
    // set count position ----------------
    public var countPosition: PositionOfCount = .right {
        didSet {
            if (self.dataSource != nil) {
                self.setCountPosition()
            }
        }
    }
    func setCountPosition() {
        switch self.countPosition {
        case .left:
            self.stackView.semanticContentAttribute = .forceRightToLeft
            break
        case .right:
            self.stackView.semanticContentAttribute = .forceLeftToRight
            break
        }
    }
    // --------------------------------------------
}

