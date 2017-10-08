//
//  ViewController.swift
//  OnlyPictures
//
//  Created by Kiran Jasvanee on 10/02/2017.
//  Copyright (c) 2017 Kiran Jasvanee. All rights reserved.
//

import UIKit
import OnlyPictures
import AlamofireImage

class ViewController: UIViewController {
    


    @IBOutlet weak var onlyPictures: OnlyHorizontalPictures!
    var pictures: [String]  = [
        "https://media.licdn.com/mpr/mpr/shrinknp_200_200/p/3/000/076/07f/0d01ca8.jpg",
        "http://static3.businessinsider.com/image/51700e6b69beddc119000015/this-31-year-old-advisor-wants-to-change-the-way-young-people-invest.jpg",
        "https://i.pinimg.com/736x/41/17/5b/41175b8393965fbac6d31e5b495065ee--pretty-people-beautiful-people.jpg",
        "https://www.getaround.com/img/public/rent/owner_bruno.jpg",
        "https://static.pexels.com/photos/355164/pexels-photo-355164.jpeg",
        "https://onehdwallpaper.com/wp-content/uploads/2016/11/Beautiful-Girls-Photos-Free-For-Download.jpg",
        "https://pbs.twimg.com/profile_images/1717956431/BP-headshot-fb-profile-photo_400x400.jpg"
    ]

    
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
        
        onlyPictures.backgroundColorForCount = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        onlyPictures.textColorForCount = .red
        onlyPictures.fontForCount = UIFont(name: "HelveticaNeue", size: 18)!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addMoreWithReloadActionListener(_ sender: Any) {
        
        pictures.append("http://insightstobehavior.com/wp-content/uploads/2017/08/testi-5.jpg")
        pictures.append("https://cdn.wallpapersafari.com/79/67/oUExzR.jpg")
        pictures.append("http://steezo.com/wp-content/uploads/2012/12/man-in-suit2-300x223.jpg")
        pictures.append("http://www.daymarkinteractive.com/wp-content/uploads/2014/04/35.jpg")
        self.onlyPictures.reloadData()
    }
    
    @IBAction func insertAtFirstActionListener(_ sender: Any) {
        let urlString = "http://insightstobehavior.com/wp-content/uploads/2017/08/testi-5.jpg"
        let url = URL(string: urlString)
        pictures.insert(urlString, at: 0)
        onlyPictures.insertFirst(withAnimation: .popup) { (imageView) in
            imageView.image = #imageLiteral(resourceName: "defaultProfilePicture")
            imageView.af_setImage(withURL: url!)
        }
    }
    @IBAction func insertLastActionListener(_ sender: Any) {
        let urlString = "https://cdn.wallpapersafari.com/79/67/oUExzR.jpg"
        let url = URL(string: urlString)
        pictures.append(urlString)
        onlyPictures.insertLast(withAnimation: .popup) { (imageView) in
            imageView.image = #imageLiteral(resourceName: "defaultProfilePicture")
            imageView.af_setImage(withURL: url!)
        }
    }
    @IBAction func insertAt2ndPositionActionListener(_ sender: Any) {
        
        let urlString = "https://cdn.wallpapersafari.com/79/67/oUExzR.jpg"
        let url = URL(string: urlString)
        pictures.insert(urlString, at: 2)
        onlyPictures.insertPicture(atIndex: 2, withAnimation: .popup) { (imageView) in
            imageView.image = #imageLiteral(resourceName: "defaultProfilePicture")
            imageView.af_setImage(withURL: url!)
        }
    }
    @IBAction func removeFirstActionListener(_ sender: Any) {
        pictures.removeFirst()
        onlyPictures.removeFirst(withAnimation: .popdown)
    }
    @IBAction func removeLastActionListener(_ sender: Any) {
        pictures.removeLast()
        onlyPictures.removeLast(withAnimation: .popdown)
    }
    @IBAction func removeAt2ndPositionActionListener(_ sender: Any) {
        pictures.remove(at: 2)
        onlyPictures.removePicture(atIndex: 2, withAnimation: .popdown)
    }
}


extension ViewController: OnlyPicturesDataSource {
    func numberOfPictures() -> Int {
        return self.pictures.count
    }
    func visiblePictures() -> Int {
        return 8
    }
    func pictureViews(_ imageView: UIImageView, index: Int) {
        let url = URL(string: self.pictures[index])
        imageView.image = #imageLiteral(resourceName: "defaultProfilePicture")
        imageView.af_setImage(withURL: url!)
    }
}

extension ViewController: OnlyPicturesDelegate {
    
    // ---------------------------------------------------
    // receive an action of selected picture tap index
    
    func pictureView(_ imageView: UIImageView, didSelectAt index: Int) {
        print("Selected index: \(index)")
    }
    
    // ---------------------------------------------------
    // receive an action of tap upon count
    
    func pictureViewCountDidSelect() {
        print("Tap on count")
    }
    
    // ---------------------------------------------------
    // receive a count, incase you want to do additionally things with it.
    // even if your requirement is to hide count and handle it externally with below fuction, you can hide it using property `isVisibleCount = true`.
    
    func pictureViewCount(value: Int) {
        print("count value: \(value)")
    }
    
    
    // ---------------------------------------------------
    // receive an action, whem tap occures anywhere in OnlyPicture view.
    
    func pictureViewDidSelect() {
        print("tap on picture view")
    }
}
