//
//  OnlyPicturesAnimations.swift
//  KJBubblePictures
//
//  Created by Karan on 28/09/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.
//


import Foundation
import  UIKit


public enum InsertionAnimation {
    case none
    case fade
    case popup
    case scaleup
}

public enum RemovationAnimation {
    case none
    case fade
    case popdown
    case scaledown
}


extension OnlyPictures {
    
    func animate(_ pictureView: OnlyPictureImageView, withAnimation animation: InsertionAnimation) {
        switch animation {
        case .fade:
            self.animateWithFadeIn(pictureView)
            break
        case .popup:
            self.animateWithPopup(pictureView)
            break
        case .scaleup:
            self.animateWithScaleup(pictureView)
            break
        case .none:
            break
        }
    }
    
    func animateWithFadeIn(_ pictureView: OnlyPictureImageView){
        
        pictureView.alpha = 0.0
        UIView.animate(withDuration: 0.6, animations: {
            pictureView.alpha = 1.0
        }) { (_) in
            
        }
    }
    
    func animateWithPopup(_ pictureView: OnlyPictureImageView){
        
        UIView.animate(withDuration: 0.3, animations: {
            pictureView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (_) in
            UIView.animate(withDuration: 0.6) {
                pictureView.transform = CGAffineTransform.identity
            }
        }
    }
    
    func animateWithScaleup(_ pictureView: OnlyPictureImageView){
        
        pictureView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: 0.6, animations: {
            pictureView.transform = CGAffineTransform.identity
        }) { (_) in
            
        }
    }
    
    
    
    func animate(_ pictureView: OnlyPictureImageView, withAnimation animation: RemovationAnimation) {
        switch animation {
        case .fade:
            self.animateWithFadeRe(pictureView)
            break
        case .popdown:
            self.animateWithPopdown(pictureView)
            break
        case .scaledown:
            self.animateWithScaledown(pictureView)
            break
        case .none:
            break
        }
    }
    
    func animateWithFadeRe(_ pictureView: OnlyPictureImageView){
        
        pictureView.alpha = 1.0
        UIView.animate(withDuration: 0.6, animations: {
            pictureView.alpha = 0.0
        }) { (_) in
            pictureView.removeFromSuperview()
        }
    }
    
    func animateWithPopdown(_ pictureView: OnlyPictureImageView){
        
        UIView.animate(withDuration: 0.3, animations: {
            pictureView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                pictureView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }) { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    pictureView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }) { (_) in
                    pictureView.removeFromSuperview()
                }
            }
        }
    }
    
    func animateWithScaledown(_ pictureView: OnlyPictureImageView){
        
        UIView.animate(withDuration: 0.3, animations: {
            pictureView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (_) in
            pictureView.removeFromSuperview()
        }
    }
}
