//
//  OnlyPicturesProtocol.swift
//  KJBubblePictures
//
//  Created by Karan on 28/09/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.
//

import Foundation
import UIKit

protocol OnlyPictureInsertRemoveProtocol{
    
    func insertLast(image: UIImage, withAnimation animation: InsertionAnimation)
    func insertLast(withAnimation animation: InsertionAnimation, ImageViewCallback: (UIImageView) -> ())
    func insertFirst(image: UIImage, withAnimation animation: InsertionAnimation)
    func insertFirst(withAnimation animation: InsertionAnimation, ImageViewCallback: (UIImageView) -> ())
    func insertPicture(_ image: UIImage, atIndex index: Int, withAnimation animation: InsertionAnimation)
    func insertPicture(atIndex index: Int, withAnimation animation: InsertionAnimation, ImageViewCallback: (UIImageView) -> ())
    
    
    func removeFirst(withAnimation animation: RemovationAnimation)
    func removeLast(withAnimation animation: RemovationAnimation)
    func removePicture(atIndex index: Int, withAnimation animation: RemovationAnimation)
}






extension OnlyPictures: OnlyPictureInsertRemoveProtocol{
    
    public func insertFirst(image: UIImage, withAnimation animation: InsertionAnimation) {
        
        if self.order == .ascending{
            
            if self.picturesCount <= self.visiblePictures || self.visiblePictures == 0 {
                // Simply append in ascending case. First should be shown up in last. Simply add it at index 0.
                let pictureImageView = self.insertAtFirstPictureMethod(withAnimation: animation)
                self.setImageInImageView(image, inImageView: pictureImageView)
            }else{
                self.insertPicture(image, atIndex: 0, withAnimation: animation)         // Only count update will occur
            }
            
        }else{
            
            // Simply append in descending case. First should be shown up in recent.
            let pictureImageView = self.appendPictureMethod(withAnimation: animation)
            self.setImageInImageView(image, inImageView: pictureImageView)
        }
    }
    
    public func insertFirst(withAnimation animation: InsertionAnimation, ImageViewCallback: (UIImageView) -> ()) {
        
        if self.order == .ascending{
            
            if self.picturesCount <= self.visiblePictures || self.visiblePictures == 0 {
                // Simply append in ascending case. First should be shown up in last. Simply add it at index 0.
                let pictureImageView = self.insertAtFirstPictureMethod(withAnimation: animation)
                self.setImageInImageView(self.defaultPicture ?? UIImage(), inImageView: pictureImageView)
                ImageViewCallback(pictureImageView)
            }else{
                self.insertPicture(atIndex: 0, withAnimation: animation, ImageViewCallback: { (imageView) in    // Only count update will occur
                    ImageViewCallback(imageView)
                })
            }
            
        }else{
            // Simply append in descending case. First should be shown up in recent.
            let pictureImageView = self.appendPictureMethod(withAnimation: animation)
            self.setImageInImageView(self.defaultPicture ?? UIImage(), inImageView: pictureImageView)
            ImageViewCallback(pictureImageView)
        }
    }
    
    public func insertLast(image: UIImage, withAnimation animation: InsertionAnimation) {
        
        if self.order == .ascending{
            
            // append - when pictures are in ascending, and descending too but only if visible pictures are not there.
            let pictureImageView = self.appendPictureMethod(withAnimation: animation)
            self.setImageInImageView(image, inImageView: pictureImageView)
            
        }else{
            
            if self.picturesCount <= self.visiblePictures || self.visiblePictures == 0 {
                // Simply append in descending case. last should be shown up in first. Simply add it at index 0.
                let pictureImageView = self.insertAtFirstPictureMethod(withAnimation: animation)
                self.setImageInImageView(image, inImageView: pictureImageView)
            }else{
                self.insertPicture(image, atIndex: self.picturesCount, withAnimation: animation)         // Only count update will occur
            }
        }
    }
    
    public func insertLast(withAnimation animation: InsertionAnimation, ImageViewCallback: (UIImageView) -> ()){
        
        if self.order == .ascending{
            
            // append - when pictures are in ascending, and descending too but only if visible pictures are not there.
            let pictureImageView = self.appendPictureMethod(withAnimation: animation)
            self.setImageInImageView(self.defaultPicture ?? UIImage(), inImageView: pictureImageView)
            ImageViewCallback(pictureImageView)
            
        }else{
            
            if self.picturesCount <= self.visiblePictures || self.visiblePictures == 0 {
                // Simply append in descending case. last should be shown up in first. Simply add it at index 0.
                let pictureImageView = self.insertAtFirstPictureMethod(withAnimation: animation)
                self.setImageInImageView(self.defaultPicture ?? UIImage(), inImageView: pictureImageView)
                ImageViewCallback(pictureImageView)
            }else{
                
                self.insertPicture(atIndex: self.picturesCount, withAnimation: animation, ImageViewCallback: { (imageView) in    // Only count update will occur
                    ImageViewCallback(imageView)
                })
            }
        }
    }
    
    
    
    
    
    private func insertAtFirstPictureMethod(withAnimation animation: InsertionAnimation) -> OnlyPictureImageView{
        
        let pictureImageView: OnlyPictureImageView = self.addImageView(at: 0)
        self.listPictureImageViews.insert(pictureImageView, at: 0)
        
        // Up onwards other recent imageviews after insertion at 0th position.
        for index in stride(from: 0, to: self.listPictureImageViews.count, by: 1) {
            stackviewOfImageViews.bringSubview(toFront: self.listPictureImageViews[index])
        }
        
        self.updateVisiblePicturesWithEffectOfNewInsertionMethod()      // It works to remove first picture to show last/middle inserted picture.
        
        (self as? OnlyHorizontalPictures)?.resetLayoutBasedOnCurrentPropertyValues()    // Update layout
        self.animateFocusAtIndexInIP(pictureImageView, withAnimation: animation)                      // animate insertion focus at specific index.
        return pictureImageView
    }
    private func appendPictureMethod(withAnimation animation: InsertionAnimation) -> OnlyPictureImageView{
        
        // add picture imageview.
        let pictureImageView: OnlyPictureImageView = self.addImageView()
        self.listPictureImageViews.append(pictureImageView)
        
        
        self.updateVisiblePicturesWithEffectOfNewInsertionMethod()      // It works to remove first picture to show last/middle inserted picture.
        
        (self as? OnlyHorizontalPictures)?.resetLayoutBasedOnCurrentPropertyValues()    // Update layout
        self.animateFocusAtIndexInIP(pictureImageView, withAnimation: animation)                      // animate insertion focus at specific index.
        return pictureImageView
    }
    
    
    
    
    
    
    
    
    
    
    public func insertPicture(_ image: UIImage, atIndex index: Int, withAnimation animation: InsertionAnimation) {
        
        // When order is ascending, last comes recent. adding at last index, simply append it.
        // When order is descending, first comes recent. adding at first index, simply append it.
        if (self.order == .ascending && index == self.picturesCount) || (self.order == .descending && index == 0) {
            let pictureImageView = self.appendPictureMethod(withAnimation: animation)
            self.setImageInImageView(image, inImageView: pictureImageView)
            return
        }
        
        
        if let pictureImageView = self.insertPictureWithIndexMethod(atIndex: index, withAnimation: animation){
            self.setImageInImageView(image, inImageView: pictureImageView)
        }
    }
    
    public func insertPicture(atIndex index: Int, withAnimation animation: InsertionAnimation, ImageViewCallback: (UIImageView) -> ()){
        
        // When order is ascending, last comes recent. adding at last index, simply append it.
        // When order is descending, first comes recent. adding at first index, simply append it.
        if (self.order == .ascending && index == self.picturesCount) || (self.order == .descending && index == 0) {
            let pictureImageView = self.appendPictureMethod(withAnimation: animation)
            self.setImageInImageView(self.defaultPicture ?? UIImage(), inImageView: pictureImageView)
            ImageViewCallback(pictureImageView)
        }
        
        
        if let pictureImageView = self.insertPictureWithIndexMethod(atIndex: index, withAnimation: animation){
            self.setImageInImageView(self.defaultPicture ?? UIImage(), inImageView: pictureImageView)
            ImageViewCallback(pictureImageView)
        }
    }
    
    
    
    
    private func insertPictureWithIndexMethod(atIndex index: Int, withAnimation animation: InsertionAnimation) ->  OnlyPictureImageView?{
        
        // Indicates that, index should be above visible pictures starting index to ending index.
        guard index <= self.picturesCount else {
            print("OnlyPictures error: Index out of bounds. ")
            return nil
        }
        
        
        func returnWithIndexNotInVisiblePicturesWindow(stringLowerUpper: String){
            print("OnlyPictures: Index is \(stringLowerUpper) than the boundary of visible pictures, we will increment count. It's your responsibility to add picture in array you used for allocating OnlyPictures.")
            
            // Increment count to plus one.
            self.picturesCount += 1
            self.setCountRuntimeFlexibility(count: self.picturesCount-self.visiblePictures)
        }
        
        
        // Checking index belongs to visible pictures?
        var indexOfStartingPosition = 0
        if self.isVisibleCountExists() {
            
            if self.order == .ascending {
                indexOfStartingPosition = self.picturesCount > self.visiblePictures ? (self.picturesCount - self.visiblePictures) : 0
                if index < indexOfStartingPosition {
                    returnWithIndexNotInVisiblePicturesWindow(stringLowerUpper: "lower")
                    return nil
                }
            }else{
                indexOfStartingPosition = self.picturesCount > self.visiblePictures ? self.visiblePictures : self.picturesCount
                if index > indexOfStartingPosition {
                    returnWithIndexNotInVisiblePicturesWindow(stringLowerUpper: "upper")
                    return nil
                }
            }
            
        }else{
            if self.order == .ascending {
                indexOfStartingPosition = 0
            }else{
                indexOfStartingPosition = self.picturesCount
            }
        }
        
        
        
        // insert picture at specific position in stackview
        var indexInStackView = index        // default is okay for descending.
        if self.order == .ascending {
            indexInStackView = index - indexOfStartingPosition
        }else{
            indexInStackView = indexOfStartingPosition - index
        }
        
        
        
        let pictureImageView: OnlyPictureImageView = self.addImageView(at: indexInStackView)
        self.listPictureImageViews.insert(pictureImageView, at: indexInStackView)
        
        
        // Up onwards other recent imageviews after insertion at specific position.
        for index in stride(from: indexInStackView, to: self.listPictureImageViews.count, by: 1) {
            stackviewOfImageViews.bringSubview(toFront: self.listPictureImageViews[index])
        }
        
        self.updateVisiblePicturesWithEffectOfNewInsertionMethod()
        
        
        
        (self as? OnlyHorizontalPictures)?.resetLayoutBasedOnCurrentPropertyValues() // set alignment based on new insertions, it's required because when insertion happens and images goes out of OnlyPictures boundaries, scroll should auto ON automatically.
        self.animateFocusAtIndexInIP(pictureImageView, withAnimation: animation)     // animate insertion focus at specific index.
        
        return pictureImageView
    }
    
    private func animateFocusAtIndexInIP(_ pictureImageView: OnlyPictureImageView, withAnimation animation: InsertionAnimation) {
        
        self.stackView.layoutIfNeeded()
        let positionOfImageView = self.stackView.convert(pictureImageView.frame, from: pictureImageView.superview)
        self.scrollView.scrollRectToVisible(positionOfImageView, animated: false)
        
        self.animate(pictureImageView, withAnimation: animation)
    }
    
    internal func updateVisiblePicturesWithEffectOfNewInsertionMethod() {
        
        self.picturesCount += 1 // Increase picture count.
        
        // If visible pictures are there, add it run time.
        if let _ = self.dataSource?.visiblePictures?(onlyPictureView: self) {
            
            
            // If total picturesCount are more than visiblePictures
            if self.picturesCount > self.visiblePictures {
                
                /*
                 Desc            Asc
                 <------     ------>
                 0 1 2 3 4 5 6 7 8 9
                 
                 So in Descending, inserting at 1, will switch present 1,2 & 3 to backwards. So removing 3 (first one) is valid.
                 So in Ascending, inserting at 7, will switch present 7 & 6 to backwards. So removing 6 (first one) is valid.
                 
                 */
                // Remove first imageView from stackView.
                let imageViewStartingFrom = self.listPictureImageViews[0] // First one ofcourse will be at 0th position. Remove it.
                self.listPictureImageViews.remove(at: 0)
                imageViewStartingFrom.removeFromSuperview()
                
            }
            self.setCountRuntimeFlexibility(count: self.picturesCount-self.visiblePictures)
        }
    }
    
    
    
}









extension OnlyPictures{
    public func removeFirst(withAnimation animation: RemovationAnimation){
        
        // ascending order
        // If it's descending,
        if self.order == .ascending {
            
            // This condition indicates, either less or no visible pictures, so in state of no remaining count, simply remove first one.
            if self.picturesCount <= self.visiblePictures || self.visiblePictures == 0 {
                self.removeFirstImageView(withAnimation: animation)
            }else{
                self.removePicture(atIndex: 0, withAnimation: animation)
            }
            
        }else{
            
            // This condition indicates, either less or no visible pictures, so in state of no remaining count, simply remove first one. Which is last in descending.
            if self.picturesCount <= self.visiblePictures || self.visiblePictures == 0{
                self.removeLastImageView(withAnimation: animation)
            }else{
                self.removePicture(atIndex: 0, withAnimation: animation)
            }
        }
        
    }
    public func removeLast(withAnimation animation: RemovationAnimation){
        if self.order == .ascending {
            
            // This condition indicates, either less or no visible pictures, so in state of no remaining count, simply remove last one.
            if self.picturesCount <= self.visiblePictures || self.visiblePictures == 0{
                self.removeLastImageView(withAnimation: animation)
            }else{
                self.removePicture(atIndex: self.picturesCount-1, withAnimation: animation)
            }
        }else{
            
            // This condition indicates, either less or no visible pictures, so in state of no remaining count, simply remove first one. Which is first in case of descending.
            if self.picturesCount <= self.visiblePictures || self.visiblePictures == 0{
                self.removeFirstImageView(withAnimation: animation)
            }else{
                self.removePicture(atIndex: self.picturesCount-1, withAnimation: animation)
            }
        }
    }
    
    private func removeFirstImageView(withAnimation animation: RemovationAnimation) {
        let imageViewStartingFrom = self.listPictureImageViews[0] // First one ofcourse will be at 0th position. Remove it.
        self.listPictureImageViews.remove(at: 0)
        self.decrementCountToMinusOne()
        
        (self as? OnlyHorizontalPictures)?.resetLayoutBasedOnCurrentPropertyValues()
        self.animateFocusAtIndexInRP(imageViewStartingFrom, withAnimation: animation)   // Remove from super view will occure here.
    }
    
    private func removeLastImageView(withAnimation animation: RemovationAnimation) {
        let imageViewStartingFrom = self.listPictureImageViews[self.listPictureImageViews.count-1] // First one ofcourse will be at 0th position. Remove it.
        self.listPictureImageViews.remove(at: self.listPictureImageViews.count-1)
        self.decrementCountToMinusOne()
        
        (self as? OnlyHorizontalPictures)?.resetLayoutBasedOnCurrentPropertyValues()
        self.animateFocusAtIndexInRP(imageViewStartingFrom, withAnimation: animation)
    }
    
    private func animateFocusAtIndexInRP(_ pictureImageView: OnlyPictureImageView, withAnimation animation: RemovationAnimation) {
        
        self.stackView.layoutIfNeeded()
        let positionOfImageView = self.stackView.convert(pictureImageView.frame, from: pictureImageView.superview)
        self.scrollView.scrollRectToVisible(positionOfImageView, animated: false)
        
        self.animate(pictureImageView, withAnimation: animation)
    }
    
    public func removePicture(atIndex index: Int, withAnimation animation: RemovationAnimation){
        
        // Indicates that, index should be above visible pictures starting index to ending index.
        guard index < self.picturesCount else {
            print("OnlyPictures error: Index out of bounds. ")
            return
        }
        
        
        func returnWithIndexNotInVisiblePicturesWindow(stringLowerUpper: String){
            print("OnlyPictures: Index is \(stringLowerUpper) than the boundary of visible pictures, we will increment count. It's your responsibility to add picture in array you used for allocating pictures.")
            
            // Increment count to plus one.
            self.decrementCountToMinusOne()
        }
        
        
        
        /*
         for ascending ->  +1 0 0 0
         -->
         Starting position '1'
         
         for descending ->   0 0 0 0 +2
         <--
         Starting position '3'
         */
        // Checking index belongs to visible pictures?
        var indexOfStartingPosition = 0
        if self.isVisibleCountExists() {
            
            if self.order == .ascending {
                indexOfStartingPosition = self.picturesCount > self.visiblePictures ? (self.picturesCount - self.visiblePictures) : 0
                if index < indexOfStartingPosition {
                    returnWithIndexNotInVisiblePicturesWindow(stringLowerUpper: "lower")
                    return
                }
            }else{
                indexOfStartingPosition = self.picturesCount > self.visiblePictures ? self.visiblePictures-1 : self.picturesCount-1
                if index > indexOfStartingPosition {
                    returnWithIndexNotInVisiblePicturesWindow(stringLowerUpper: "upper")
                    return
                }
            }
        }else{
            if self.order == .ascending {
                indexOfStartingPosition = 0
            }else{
                indexOfStartingPosition = self.picturesCount-1
            }
        }
        
        
        // insert picture at specific position in stackview
        var indexInStackView = index
        if self.order == .ascending {
            indexInStackView = index - indexOfStartingPosition  // here, index always been greater than starting position.
        }else{
            indexInStackView = indexOfStartingPosition - index  // here, index always been smaller than starting position.
        }
        
        
        self.removeImage(atIndex: indexInStackView, withAnimation: animation)
    }
    
    private func removeImage(atIndex index: Int, withAnimation animation: RemovationAnimation) {
        
        let imageViewStartingFrom = self.listPictureImageViews[index]
        self.listPictureImageViews.remove(at: index)
        
        self.decrementCountToMinusOne()
        
        // set layout and remove specific imageview from stack with animation.
        (self as? OnlyHorizontalPictures)?.resetLayoutBasedOnCurrentPropertyValues()
        self.animateFocusAtIndexInRP(imageViewStartingFrom, withAnimation: animation)   // Remove from super view will occure here.
        
        // Simply, if there are more to load in picture count, grab a next recent one to show.
        if self.isVisibleCountExists() {
            if self.picturesCount >= self.visiblePictures {
                
                var startingPosition = 0
                if self.order == .ascending {
                    startingPosition = self.picturesCount-self.visiblePictures
                }else{
                    startingPosition = visiblePictures
                }
                
                let pictureImageView: OnlyPictureImageView = self.addImageView(at: 0)
                self.listPictureImageViews.insert(pictureImageView, at: 0)
                
                
                if let image = self.dataSource?.pictureViews?(onlyPictureView: self, index: startingPosition) {
                    self.setImageInImageView(image, inImageView: pictureImageView)
                }
                
                // If picture set inside 'pictureViews(_ imageView: UIImageView, index: Int)' by developer himself/herself.
                self.dataSource?.pictureViews?(onlyPictureView: self, pictureImageView, index: startingPosition)
                
                // Up onwards imageview after insertion position.
                for indexOfUpward in stride(from: 1, to: self.listPictureImageViews.count, by: 1) {
                    stackviewOfImageViews.bringSubview(toFront: self.listPictureImageViews[indexOfUpward])
                }
            }
        }
    }
    
    
    private func decrementCountToMinusOne(){
        self.picturesCount -= 1
        if self.isVisibleCountExists() {
            self.setCountRuntimeFlexibility(count: self.picturesCount-self.visiblePictures)
        }
    }
}



