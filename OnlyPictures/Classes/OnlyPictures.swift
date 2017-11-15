//
//  OnlyPictures.swift
//  KJBubblePictures
//
//  Created by Karan on 28/09/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.
//

import UIKit

private var STACKVIEW_SPACING = -10
private var IMAGEVIEW_BORDERWIDTH = 2.0
private var SIZE_OF_IMAGEVIEWS: CGFloat = 0.0

@objc public protocol OnlyPicturesDataSource {
    func numberOfPictures() -> Int
    @objc optional func visiblePictures() -> Int
    @objc optional func pictureViews(index: Int) -> UIImage
    @objc optional func pictureViews(_ imageView: UIImageView, index: Int)
}

@objc public protocol OnlyPicturesDelegate {
    func pictureView(_ imageView: UIImageView, didSelectAt index: Int)
    @objc optional func pictureViewCountDidSelect()
    @objc optional func pictureViewCount(value: Int)
    @objc optional func pictureViewDidSelect()
}

public enum ListOrder {
    case ascending, descending
}


public class OnlyPictures: UIView {
    
    
    internal let viewBase = UIView()                          // Superview of all.
    internal var listPictureImageViews: [OnlyPictureImageView] = []           // Holds all imageviews.
    internal var scrollView: UIScrollView = UIScrollView()              // scrollview of images.
    internal var stackView: UIStackView = UIStackView()                 // Stackview holds this imageViews & count
    internal var stackviewOfImageViews: UIStackView = UIStackView()     // Stackview holds this images in imageViews
    
    // Delegate
    public var dataSource: OnlyPicturesDataSource? = nil {
        didSet {
            if self.dataSource != nil {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.reloadData()
                })
            }
        }
    }
    public var delegate: OnlyPicturesDelegate? = nil {
        didSet {
            self.delegate?.pictureViewCount?(value: self.picturesCount-self.visiblePictures)
        }
    }
    
    
    
    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupInitLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupInitLayout()
    }
    
    func setupInitLayout() {
        self.addSubview(self.viewBase)
        
        self.setMainScrollView()
        self.setMainStackView()
        self.setStackViewOfImageViews()
    }
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    
    // layout subviews when layout changes
    override public func layoutSubviews() {
        super.layoutIfNeeded()
        self.doLayoutChanges()
    }
    
    private func doLayoutChanges() {
        
        // Set frame of whole buuble picture
        self.viewBase.frame = self.bounds
    }
    
    
    // Count -----------------------------------------------------------
    internal var picturesCount: Int = 0
    internal var visiblePictures: Int = 0
    
    internal var buttonCount: UIButton? = nil
    internal var calculatedWidthOfCount: CGFloat = 0.0

    public var imageInPlaceOfCount: UIImage? = nil {
        didSet {
            if let image = self.imageInPlaceOfCount {
                self.setCountImage(image)
            }
        }
    }
    public var backgroundColorForCount: UIColor? = UIColor.gray {
        didSet {
            self.buttonCount?.backgroundColor = self.backgroundColorForCount
        }
    }
    public var textColorForCount: UIColor = UIColor.white {
        didSet {
            self.setCountTheme(font: self.fontForCount, textColor: self.textColorForCount)
        }
    }
    public var fontForCount: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 16)! {
        didSet {
            self.setCountTheme(font: self.fontForCount, textColor: self.textColorForCount)
        }
    }
    public var isHiddenVisibleCount: Bool = false {
        didSet {
            if self.isHiddenVisibleCount {
                self.buttonCount?.removeFromSuperview()
            }
        }
    }
    
    
    
    
    // Order -----------------------------------------------------------
    public var order: ListOrder = .ascending
    
    
    
    
    // Reload data -----------------------------------------------------
    public func reloadData(){
        
        SIZE_OF_IMAGEVIEWS = self.bounds.size.height // Generic instance for ImageView size.
        
        guard let picturesCount: Int = self.dataSource?.numberOfPictures(), picturesCount != 0 else{
            return
        }
        self.picturesCount = picturesCount  // assign new pictures count to pictureCount
        
        // If listPictureImageViews are blank, it indicates OnlyPictures loading first time.
        if self.listPictureImageViews.count == 0 {
            
            var isCountRequired = false
            // Visible picture logic --------------------------
            if let visiblePictures = self.dataSource?.visiblePictures?(), visiblePictures > 0{
                self.visiblePictures = visiblePictures

                // If pictureCount is less or equal to visiblePictures, walk up to pictureCount OR we will need a count
                if self.picturesCount > visiblePictures  {
                    isCountRequired = true
                }
            }
            // ------------------------------------------------

            self.initPicturesLayout(isCountRequired)   // Create all things from scractch.
            
        }else{
            
            // reload in existing ImageViews --------------------------
            
            if let visiblePictures = self.dataSource?.visiblePictures?(), visiblePictures > 0{
                self.visiblePictures = visiblePictures
                
                var indexForStackviewOfImageView: Int = 0
                var indexStopeedAt = 0
                var isAppendPicturesStarted = false
                
                // Common nested function to be called from inside of .ascending/.descending choice made following this function.
                func assignImages (index: Int){
                    print(indexForStackviewOfImageView)
                    if self.stackviewOfImageViews.arrangedSubviews.indices.contains(indexForStackviewOfImageView) && !isAppendPicturesStarted{
                        
                        // Starting index can be anyone, whereas we requires stackview index to be starting from 0th only and to be incremented till stackview images available. That's why we requires different index for stackviewImageViews and actual index image to be filled up inside that imageView in stackview. 'Whereas in other case, where visible pictures are not accountable, index will be starting from 0th for both'
                        self.updateImageInStackviewOfImageViews(atIndex: indexForStackviewOfImageView, withPictureIndex: index)
                        indexForStackviewOfImageView += 1
                    }else{
                        isAppendPicturesStarted = true
                        self.createAndAppendNewPicture(atIndex: index)
                    }
                }
                
                
                
                // choose indices based on .ascending/.descending
                if self.order == .ascending {
                    
                    // For ascending order
                    let startingPosition = self.picturesCount > self.visiblePictures ? (self.picturesCount-self.visiblePictures) : 0
                    
                    for index in startingPosition..<self.picturesCount {
                        assignImages(index: index)
                        indexStopeedAt = index
                    }
                }else{
                    
                    // For descending order
                    let startingPosition = self.picturesCount > self.visiblePictures ? self.visiblePictures-1 : self.picturesCount-1
                    indexStopeedAt = startingPosition
                    
                    for index in stride(from: startingPosition, through: 0, by: -1) {
                        assignImages(index: index)
                    }
                }
                
                
                self.setCountRuntimeFlexibility(count: self.picturesCount-self.visiblePictures) // Set updated count
                self.removeAdditionalImageViewsInsideStackView(indexStopped: indexStopeedAt+1)  // Remove additional imageViews from self.stackviewOfImageViews
                
                // Reset layout
                (self as? OnlyHorizontalPictures)?.resetLayoutBasedOnCurrentPropertyValues()
                
            }else{
                
                var indexForStackviewOfImageView = 0
                var indexStopeedAt = 0
                var isAppendPicturesStarted = false
                // up to new picture count.
                
                
                // Common nested function to be called from inside of .ascending/.descending choice made following this function.
                func assignImages(index: Int){
                    if self.stackviewOfImageViews.arrangedSubviews.indices.contains(indexForStackviewOfImageView) && !isAppendPicturesStarted{
                        self.updateImageInStackviewOfImageViews(atIndex: indexForStackviewOfImageView, withPictureIndex: index)
                        indexForStackviewOfImageView += 1
                    }else{
                        isAppendPicturesStarted = true
                        self.createAndAppendNewPicture(atIndex: index)
                    }
                }
                
                
                
                // choose indices based on .ascending/.descending
                if self.order == .ascending {
                    for index in 0..<self.picturesCount {
                        assignImages(index: index)
                        indexStopeedAt = index
                    }
                }else{
                    indexStopeedAt = self.picturesCount-1
                    for index in stride(from: indexStopeedAt, through: 0, by: -1) {
                        assignImages(index: index)
                        
                    }
                }
                self.removeAdditionalImageViewsInsideStackView(indexStopped: indexStopeedAt+1) // Remove additional imageViews from self.stackviewOfImageViews
                
                // Reset layout
                (self as? OnlyHorizontalPictures)?.resetLayoutBasedOnCurrentPropertyValues()
            }
        }
    }
    
    
    
    private func updateImageInStackviewOfImageViews(atIndex indexOfStackviewImageView: Int, withPictureIndex indexOfPicture: Int){
        
        let imageView: OnlyPictureImageView? = self.stackviewOfImageViews.arrangedSubviews[indexOfStackviewImageView] as? OnlyPictureImageView
        if let defaultPictureConfirmed = self.defaultPicture {
            self.setImageInImageView(defaultPictureConfirmed, inImageView: imageView!)
        }else{
            imageView?.backgroundColor = UIColor.lightGray
        }
        
        
        if let image = self.dataSource?.pictureViews?(index: indexOfPicture) {
            if !__CGSizeEqualToSize(image.size, .zero){
                imageView?.image = image
            }
        }
        
        // If picture set inside 'pictureViews(_ imageView: UIImageView, index: Int)' by developer himself/herself.
        self.dataSource?.pictureViews?(imageView!, index: indexOfPicture)
    }
    
    private func removeAdditionalImageViewsInsideStackView(indexStopped: Int){
        let endingIndex = self.stackviewOfImageViews.arrangedSubviews.count
        if indexStopped < endingIndex {
            for _ in indexStopped..<endingIndex {
                let imageview = self.stackviewOfImageViews.arrangedSubviews[indexStopped]
                imageview.removeFromSuperview()
            }
        }
    }
    
    
    
    
    
    
    
    
    
    // Create extension for Swift_4 ---------------------------------------------------------------
    
    public var gap: Float = Float(STACKVIEW_SPACING) {
        didSet {
            self.setGap()
        }
    }
    
    
    public var spacing: Float = Float(IMAGEVIEW_BORDERWIDTH) {
        didSet {
            self.setSpacing()
        }
    }
    
    public var defaultPicture: UIImage? = nil {
        didSet {
            self.setDefaultPicturesInAllImageViews()
        }
    }
    
    
    public var spacingColor: UIColor = .white {
        didSet {
            self.setSpacingColor()
        }
    }
    
    
    
    
    // ------------------------------------------------------------------------------------
}





internal extension OnlyPictures {
    
    func isVisibleCountExists() -> Bool {
        return self.visiblePictures != 0
    }
    
    func initPicturesLayout(_ isCountRequired: Bool) {
        
        /*
         Suppose, Total count are 16 and visibile pictures are 6. Then 11 to 16 indexed pictures will be shown with remaining count of +10.
         So, (self.picturesCount-self.visiblePictures) will give us index 10, which should run up to <16.
         This will consider last added picture recent.
         */
        var startingPosition = 0
        if self.order == .ascending {
            
            // For ascending order
            if self.isVisibleCountExists() {
                startingPosition = (self.picturesCount-self.visiblePictures) <= 0 ? 0 : (self.picturesCount-self.visiblePictures)
            }
            for index in startingPosition..<self.picturesCount {
                self.createAndAppendNewPicture(atIndex: index)
            }
        }else{
            
            // For descending order
            startingPosition = self.isVisibleCountExists() && (self.picturesCount-self.visiblePictures) > 0 ? self.visiblePictures-1 : self.picturesCount-1     // Improvement change
            for index in stride(from: startingPosition, through: 0, by: -1) {
                self.createAndAppendNewPicture(atIndex: index)
            }
        }
        
        
        // if we requires to add count
        if isCountRequired {
            
            self.delegate?.pictureViewCount?(value: self.picturesCount-self.visiblePictures)
            
            // If count visibility available, then continue.
            if !self.isHiddenVisibleCount {
                self.buttonCount = self.addCountCircle()
                if self.isVisibleCountExists(){
                    self.setCountFlexibleWidthWith(self.picturesCount-self.visiblePictures)
                }
            }
        }
        
        
        // NOTE: Check on this. Unable to load default picture set up by
        // self.setDefaultPicturesInAllImageViews() // check if there are empty images. if there set it out a default picture in place of empty imageviews.
        
        // Reset layout
        (self as? OnlyHorizontalPictures)?.resetLayoutBasedOnCurrentPropertyValues()
    }
    
    
    func createAndAppendNewPicture(atIndex index: Int) {
        let pictureImageView: OnlyPictureImageView = self.addImageView()
        self.listPictureImageViews.append(pictureImageView)
        
        // If picture in UIImage format sent by 'pictureViews(index: Int) -> UIImage'
        if let image = self.dataSource?.pictureViews?(index: index) {
            self.setImageInImageView(image, inImageView: pictureImageView)
        }
        
        // If picture set inside 'pictureViews(_ imageView: UIImageView, index: Int)' by developer himself/herself.
        self.dataSource?.pictureViews?(pictureImageView, index: index)
    }
    
    func setImageInImageView(_ image: UIImage, inImageView pictureImageView: OnlyPictureImageView) {
        if !__CGSizeEqualToSize(image.size, .zero){
            pictureImageView.image = image
            pictureImageView.isDefaultPicture = false
        }else{
            if let defaultPictureConfirmed = self.defaultPicture {
                pictureImageView.image = defaultPictureConfirmed
            }else{
                pictureImageView.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    
    func setMainScrollView() {
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.viewBase.addSubview(self.scrollView)
        self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setMainStackView() {
        self.stackView = UIStackView()
        self.stackView.axis = .horizontal;
        self.stackView.alignment = .center;
        self.stackView.spacing = CGFloat(STACKVIEW_SPACING)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.semanticContentAttribute = .forceLeftToRight
        self.scrollView.addSubview(stackView)
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.backgroundColor = UIColor.brown
    }
    
    func setStackViewOfImageViews() {
        
        // Add stackview of images.
        self.stackviewOfImageViews.axis = .horizontal;
        self.stackviewOfImageViews.alignment = .center;
        self.stackviewOfImageViews.spacing = CGFloat(STACKVIEW_SPACING)
        self.stackviewOfImageViews.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(stackviewOfImageViews)
        self.stackviewOfImageViews.semanticContentAttribute = .forceLeftToRight
    }
}


internal extension OnlyPictures {
    func addImageView(at index: Int? = nil) -> OnlyPictureImageView{
        
        let imageview: OnlyPictureImageView = OnlyPictureImageView()
        
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        
        if let insertIndex = index{
            // Consider insert call
            stackviewOfImageViews.insertArrangedSubview(imageview, at: insertIndex)
        }else{
            // Consider add call
            stackviewOfImageViews.addArrangedSubview(imageview)
        }
        
        imageview.heightAnchor.constraint(equalToConstant: SIZE_OF_IMAGEVIEWS).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: SIZE_OF_IMAGEVIEWS).isActive = true
        imageview.makeBorderWithCornerRadius(radius: SIZE_OF_IMAGEVIEWS/2, borderColor: self.spacingColor, borderWidth: CGFloat(CGFloat(IMAGEVIEW_BORDERWIDTH)))
        imageview.isUserInteractionEnabled = true
        if let defaultPictureConfirmed = self.defaultPicture {
            imageview.image = defaultPictureConfirmed
        }else{
            imageview.backgroundColor = UIColor.lightGray
        }
        
        // add imageview tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.pictureTapActionListener(recognizer:)))
        imageview.addGestureRecognizer(tapGesture)
        
        return imageview
    }
    
    internal func setBorderImageViewPath(_ view: UIView) {
        
        let layerMask = CAShapeLayer()
        let bezierPath = UIBezierPath.init(arcCenter: CGPoint(x: SIZE_OF_IMAGEVIEWS/2, y: SIZE_OF_IMAGEVIEWS/2), radius: (SIZE_OF_IMAGEVIEWS/2) - 0.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: false)
        layerMask.path = bezierPath.cgPath
        view.layer.mask = layerMask
    }
    
    internal func setBorderRemainingCountPath(_ view: UIView) {
        
        let layerMask = CAShapeLayer()
        //let bezierPath = UIBezierPath.init(arcCenter: CGPoint(x: SIZE_OF_IMAGEVIEWS/2, y: SIZE_OF_IMAGEVIEWS/2), radius: (SIZE_OF_IMAGEVIEWS/2) - 0.5, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: false)
        let bezierPath = UIBezierPath.init(ovalIn: CGRect(x: 0, y: 0, width: SIZE_OF_IMAGEVIEWS, height: SIZE_OF_IMAGEVIEWS))
        layerMask.path = bezierPath.cgPath
        view.layer.mask = layerMask
    }
    
    @objc private func pictureTapActionListener(recognizer: UITapGestureRecognizer){
        if let imageviewTapped = recognizer.view as? UIImageView {
            if let index = self.stackviewOfImageViews.arrangedSubviews.index(of: imageviewTapped) {
                self.delegate?.pictureView(imageviewTapped, didSelectAt: index)
            }
        }
        
        // generic tap called
        self.delegate?.pictureViewDidSelect?()
    }
    
    func addCountCircle() -> UIButton{
        let buttonRemainingCount: UIButton = UIButton()
        
        // print(upto-index)
        buttonRemainingCount.translatesAutoresizingMaskIntoConstraints = false
        buttonRemainingCount.backgroundColor = UIColor.darkGray
        buttonRemainingCount.titleLabel?.textColor = UIColor.white
        self.stackView.addArrangedSubview(buttonRemainingCount)
        
        buttonRemainingCount.heightAnchor.constraint(equalToConstant: SIZE_OF_IMAGEVIEWS).isActive = true
        self.calculatedWidthOfCount = SIZE_OF_IMAGEVIEWS    // default width of count.
        self.buttonCount?.makeCountBorderWithCornerRadius(radius: SIZE_OF_IMAGEVIEWS/2, countWidth: SIZE_OF_IMAGEVIEWS, borderColor: self.spacingColor, borderWidth: CGFloat(CGFloat(IMAGEVIEW_BORDERWIDTH)))
        
        buttonRemainingCount.addTarget(self, action: #selector(self.tapActionListenerOfCount(sender:)), for: .touchUpInside)
        
        return buttonRemainingCount
    }
    
    @objc private func tapActionListenerOfCount(sender: UIButton) {
        
        self.delegate?.pictureViewCountDidSelect?()
        
        // generic tap called
        self.delegate?.pictureViewDidSelect?()
    }
}









internal extension OnlyPictures {
    func setDefaultPicturesInAllImageViews() {
        for imageView in listPictureImageViews {
            if imageView.isDefaultPicture {
                if let defaultPictureConfirmed = self.defaultPicture {
                    imageView.image = defaultPictureConfirmed
                }else{
                    imageView.backgroundColor = UIColor.lightGray
                }
            }
        }
    }
}

internal extension OnlyPictures {
    func setSpacingColor() {
        self.setSpacingColorForAllImageViews(self.spacingColor)
    }
    func setSpacingColorForAllImageViews(_ spacingColor: UIColor) {
        for imageView in listPictureImageViews {
            imageView.layer.borderColor = spacingColor.cgColor
        }
        self.buttonCount?.layer.borderColor = spacingColor.cgColor  // If button will be there, if will apply border color to it.
    }
}

extension OnlyPictures {
    fileprivate func setCountTheme(font: UIFont, textColor: UIColor) {
        
        if self.isVisibleCountExists() {
            self.setCountRuntimeFlexibility(count: self.picturesCount-self.visiblePictures)
        }
    }
    func setCountRuntimeFlexibility(count: Int) {
        
        // self.isVisibleCount indicates, developer wants count, or he/she wants to handle count externally disregard this library. In this scenario this library sends count through delegate function -
        guard !self.isHiddenVisibleCount else {
            self.setCountFlexibleWidthWith(count)
            return
        }
        
        // button is already available, and count is greater than 0.
        if let buttonRemainingCount = self.buttonCount, count > 0{
            for constraint in buttonRemainingCount.constraints {
                if constraint.firstAttribute == .width {
                    self.buttonCount?.removeConstraint(constraint)
                }
            }
            self.setCountFlexibleWidthWith(count)
        }else if count > 0{
            // if button is not available and count is greather than 0. Create count circle.
            self.buttonCount = self.addCountCircle()
            self.setCountFlexibleWidthWith(count)
        }else{
            // Indicates count is less than 0
            // count <= 0
            // Remove count circle if available, if count is less than or equal to 0.
            self.buttonCount?.removeFromSuperview()
            self.buttonCount = nil
        }
    }
    
    func setCountFlexibleWidthWith(_ count: Int){
        
        self.delegate?.pictureViewCount?(value: count)       // Send count value for external use.
        
        // self.isVisibleCount indicates, developer wants count, or he/she wants to handle count externally disregard this library. In this scenario this library sends count through delegate function -
        guard !self.isHiddenVisibleCount else {
            return
        }
        
        // it indicates that, if there are no image assignment, set count values.
        if let image = self.imageInPlaceOfCount {
            // if there is custom image to apply.
            self.buttonCount?.setTitle("", for: .normal)
            self.buttonCount?.setImage(image, for: .normal)
            self.buttonCount?.backgroundColor = .white
            self.buttonCount?.widthAnchor.constraint(equalToConstant: SIZE_OF_IMAGEVIEWS).isActive = true  // We have remove width, if there is image to show, set default width to count circle.

        }else{
            self.buttonCount?.titleLabel?.font = self.fontForCount
            let countForCountCircle = "+\(count)"
            self.buttonCount?.setTitle(countForCountCircle, for: .normal)
            let width = countForCountCircle.width(withConstrainedHeight: SIZE_OF_IMAGEVIEWS, font: self.fontForCount)
            self.calculatedWidthOfCount = (width+24)>SIZE_OF_IMAGEVIEWS ? (width+24) : SIZE_OF_IMAGEVIEWS
            self.buttonCount?.widthAnchor.constraint(equalToConstant: self.calculatedWidthOfCount).isActive = true

            // custom colors if developer set for count circle.
            self.buttonCount?.backgroundColor = self.backgroundColorForCount
            self.buttonCount?.setTitleColor(self.textColorForCount, for: .normal)
        }
        
        self.buttonCount?.makeCountBorderWithCornerRadius(radius: SIZE_OF_IMAGEVIEWS/2, countWidth: self.calculatedWidthOfCount, borderColor: self.spacingColor, borderWidth: CGFloat(CGFloat(IMAGEVIEW_BORDERWIDTH)))
    }
}






internal extension OnlyPictures {
    
    func setCountImage(_ image: UIImage) {
        if !__CGSizeEqualToSize(image.size, .zero){
            self.buttonCount?.setTitle("", for: .normal)
            self.buttonCount?.backgroundColor = .white
            self.buttonCount?.setBackgroundImage(image, for: .normal)
            
            // Change size of existing width constraint.
            if let buttonRemainingCount = self.buttonCount{
                for constraint in buttonRemainingCount.constraints {
                    if constraint.firstAttribute == .width {
                        constraint.constant = SIZE_OF_IMAGEVIEWS
                    }
                }
            }
        }
    }
    
}



internal extension OnlyPictures {
    func setSpacing() {
        self.increaseWidthOfAllImageViews(self.spacing)
    }
    func increaseWidthOfAllImageViews(_ width: Float) {
        for imageView in listPictureImageViews {
            imageView.makeBorderWithCornerRadius(radius: SIZE_OF_IMAGEVIEWS/2, borderColor: self.spacingColor, borderWidth: CGFloat(width))
        }
        self.buttonCount?.makeCountBorderWithCornerRadius(radius: SIZE_OF_IMAGEVIEWS/2, countWidth: self.calculatedWidthOfCount, borderColor: self.spacingColor, borderWidth: CGFloat(width))   // If button will be there, if will apply border width to it.
    }
}

internal extension OnlyPictures {
    func setGap() {
        
        /*
         Suppose, size of images are 44*44, it indicates SIZE_OF_IMAGEVIEWS is 44. So maximum negative values should be -44. That's why condition of `Float(SIZE_OF_IMAGEVIEWS).negative() <= calculatedGap` checking gap, which should be up to -44 maximum.
         
         Whereas, we assign values of gap 0 upwards. Simply minus it with 44 will result -44 upwards. Which called calculatedGap.
         */
        
        let calculatedGap = self.gap.roundToKJ(places: 2) - Float(SIZE_OF_IMAGEVIEWS)
        
        if Float(SIZE_OF_IMAGEVIEWS).negative() <= calculatedGap{
            
            self.stackviewOfImageViews.spacing = CGFloat(calculatedGap)
            self.stackView.spacing = CGFloat(calculatedGap)
            
            (self as? OnlyHorizontalPictures)?.setPicturesAlignment()
        }
    }
}










private extension Float {
    func roundToKJ(places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
    
    func negative() -> Float {
        let number = NSDecimalNumber(value: self)
        let negativeNo = number.multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
        return negativeNo.floatValue
    }
}


extension String {
    fileprivate func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    fileprivate func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.width
    }
}



protocol CornerRadius {
    func makeBorderWithCornerRadius(radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat)
}

extension UIView: CornerRadius {
    
    func makeBorderWithCornerRadius(radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        
        let rect = CGRect.init(x: 0, y: 0, width: SIZE_OF_IMAGEVIEWS, height: SIZE_OF_IMAGEVIEWS)
        self.createBorderMark(rect: rect, radius: radius, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    func makeCountBorderWithCornerRadius(radius: CGFloat, countWidth: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        
        let rect = CGRect.init(x: 0, y: 0, width: countWidth, height: SIZE_OF_IMAGEVIEWS)
        self.createBorderMark(rect: rect, radius: radius, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    func createBorderMark(rect: CGRect, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        
        // Create the shape layer and set its path
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path  = maskPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        self.layer.mask = maskLayer
        
        
        // sublayers
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                if layer.name == "masklayer" {
                    layer.removeFromSuperlayer()
                }
            }
            
        }
        
        
        //Create path for border
        let borderPath = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        
        // Create the shape layer and set its path
        let borderLayer = CAShapeLayer()
        
        borderLayer.frame       = rect
        borderLayer.path        = borderPath.cgPath
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor   = UIColor.clear.cgColor
        borderLayer.lineWidth   = borderWidth * UIScreen.main.scale
        borderLayer.name = "masklayer"
        
        //Add this layer to give border.
        self.layer.addSublayer(borderLayer)
    }
    
}

