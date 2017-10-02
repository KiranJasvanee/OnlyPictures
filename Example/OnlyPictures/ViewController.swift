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
    var pictures: [UIImage]  = [#imageLiteral(resourceName: "p1"),#imageLiteral(resourceName: "p2"),#imageLiteral(resourceName: "p3"),#imageLiteral(resourceName: "p4"),#imageLiteral(resourceName: "p5"),#imageLiteral(resourceName: "p6"),#imageLiteral(resourceName: "p7"),#imageLiteral(resourceName: "p8"),#imageLiteral(resourceName: "p9"),#imageLiteral(resourceName: "p10"),#imageLiteral(resourceName: "p11"),#imageLiteral(resourceName: "p12"),#imageLiteral(resourceName: "p13"),#imageLiteral(resourceName: "p14"),#imageLiteral(resourceName: "p15")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        onlyPictures.dataSource = self
        onlyPictures.delegate = self
        onlyPictures.order = .ascending
        onlyPictures.alignment = .center
        onlyPictures.countPosition = .right
        onlyPictures.recentAt = .left
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: OnlyPicturesDataSource {
    func numberOfPictures() -> Int {
        return pictures.count
    }
    func visiblePictures() -> Int {
        return 6
    }
    func pictureViews(index: Int) -> UIImage {
        return pictures[index]
    }
}

extension ViewController: OnlyPicturesDelegate {
    func pictureView(_ imageView: UIImageView, didSelectAt index: Int) {
        
    }
}
