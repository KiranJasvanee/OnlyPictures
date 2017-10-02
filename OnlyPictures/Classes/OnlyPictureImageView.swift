//
//  OnlyPictureImageView.swift
//  KJBubblePictures
//
//  Created by Karan on 28/09/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.
//

import UIKit

class OnlyPictureImageView: UIImageView {

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    
    internal var isDefaultPicture: Bool = true
    


}
