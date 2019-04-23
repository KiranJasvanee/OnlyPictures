//
//  ViewController.swift
//  OnlyPictures
//
//  Created by Kiran Jasvanee on 10/02/2017.
//  Copyright (c) 2017 Kiran Jasvanee. All rights reserved.
//

import UIKit
import OnlyPictures

class ViewController: UIViewController {

    @IBOutlet weak var onlyPictures: OnlyHorizontalPictures!
    //var pictures: [UIImage]  = [#imageLiteral(resourceName: "p1"),#imageLiteral(resourceName: "p2"),#imageLiteral(resourceName: "p3"),#imageLiteral(resourceName: "p4"),#imageLiteral(resourceName: "p5"), UIImage(),#imageLiteral(resourceName: "p6"),#imageLiteral(resourceName: "p7"),#imageLiteral(resourceName: "p8"),#imageLiteral(resourceName: "p9"),#imageLiteral(resourceName: "p10"),#imageLiteral(resourceName: "p11"),#imageLiteral(resourceName: "p12"),#imageLiteral(resourceName: "p13"),#imageLiteral(resourceName: "p14"),#imageLiteral(resourceName: "p15")]
    
    
    var pictures: [UIImage]  = [#imageLiteral(resourceName: "p1"),#imageLiteral(resourceName: "p2"),#imageLiteral(resourceName: "p3"),#imageLiteral(resourceName: "p4"),#imageLiteral(resourceName: "p5"),#imageLiteral(resourceName: "p6"),#imageLiteral(resourceName: "p7"),#imageLiteral(resourceName: "p8"),#imageLiteral(resourceName: "p9"),#imageLiteral(resourceName: "p10"),#imageLiteral(resourceName: "p11"),#imageLiteral(resourceName: "p12"),#imageLiteral(resourceName: "p13"),#imageLiteral(resourceName: "p14"),#imageLiteral(resourceName: "p15")]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        onlyPictures.layer.cornerRadius = 20.0
        onlyPictures.layer.masksToBounds = true
        
        onlyPictures.dataSource = self
        onlyPictures.delegate = self
        onlyPictures.order = .descending
        onlyPictures.alignment = .center
        onlyPictures.countPosition = .right
        onlyPictures.recentAt = .left
        onlyPictures.spacingColor = UIColor.white
        onlyPictures.backgroundColorForCount = .red
        onlyPictures.defaultPicture = #imageLiteral(resourceName: "defaultProfilePicture")
        
        onlyPictures.backgroundColorForCount = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        onlyPictures.textColorForCount = .red
        onlyPictures.fontForCount = UIFont(name: "HelveticaNeue", size: 18)!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addMoreWithReloadActionListener(_ sender: Any) {
        pictures.append(#imageLiteral(resourceName: "p7"))
        pictures.append(#imageLiteral(resourceName: "p8"))
        pictures.append(#imageLiteral(resourceName: "p9"))
        pictures.append(#imageLiteral(resourceName: "p10"))
        pictures.append(#imageLiteral(resourceName: "p11"))
        pictures.append(#imageLiteral(resourceName: "p12"))
        pictures.append(#imageLiteral(resourceName: "p13"))
        pictures.append(#imageLiteral(resourceName: "p14"))
        self.onlyPictures.reloadData()
    }
    
    @IBAction func insertAtFirstActionListener(_ sender: Any) {
        onlyPictures.insertFirst(image: #imageLiteral(resourceName: "p11"), withAnimation: .popup)
        pictures.append(#imageLiteral(resourceName: "p12"))
    }
    @IBAction func insertLastActionListener(_ sender: Any) {
        pictures.append(#imageLiteral(resourceName: "p12"))
        onlyPictures.insertLast(image: #imageLiteral(resourceName: "p12"), withAnimation: .popup)
    }
    @IBAction func insertAt2ndPositionActionListener(_ sender: Any) {
        pictures.insert(#imageLiteral(resourceName: "p13"), at: 2)
        onlyPictures.insertPicture(#imageLiteral(resourceName: "p13"), atIndex: 2, withAnimation: .popup)
    }
    @IBAction func removeFirstActionListener(_ sender: Any) {
        onlyPictures.removeFirst(withAnimation: .popdown)
        pictures.removeFirst()      // Please do remove operations after does similar operations inside onlyPictures.
    }
    @IBAction func removeLastActionListener(_ sender: Any) {
        onlyPictures.removeLast(withAnimation: .popdown)
        pictures.removeLast()       // Please do remove operations after does similar operations inside onlyPictures.
    }
    @IBAction func removeAt2ndPositionActionListener(_ sender: Any) {
        onlyPictures.removePicture(atIndex: 2, withAnimation: .popdown)
        pictures.remove(at: 2)      // Please do remove operations after does similar operations inside onlyPictures.
    }
}


extension ViewController: OnlyPicturesDataSource {
    func numberOfPictures(onlyPictureView: OnlyPictures) -> Int {
        return self.pictures.count
    }
    func visiblePictures(onlyPictureView: OnlyPictures) -> Int {
        return 6
    }
    func pictureViews(onlyPictureView: OnlyPictures, index: Int) -> UIImage {
        return self.pictures[index]
    }
}

extension ViewController: OnlyPicturesDelegate {
    
    // ---------------------------------------------------
    // receive an action of selected picture tap index
    func pictureView(onlyPictureView: OnlyPictures, _ imageView: UIImageView, didSelectAt index: Int) {
        print("Selected index: \(index)")
    }
    
    // ---------------------------------------------------
    // receive an action of tap upon count
    
    func pictureViewCountDidSelect(onlyPictureView: OnlyPictures) {
        print("Tap on count")
    }
    
    // ---------------------------------------------------
    // receive a count, incase you want to do additionally things with it.
    // even if your requirement is to hide count and handle it externally with below fuction, you can hide it using property `isVisibleCount = true`.
    
    func pictureViewCount(onlyPictureView: OnlyPictures, value: Int) {
        print("count value: \(value)")
    }
    
    
    // ---------------------------------------------------
    // receive an action, whem tap occures anywhere in OnlyPicture view.
    
    func pictureViewDidSelect(onlyPictureView: OnlyPictures) {
        print("tap on picture view")
    }
}
