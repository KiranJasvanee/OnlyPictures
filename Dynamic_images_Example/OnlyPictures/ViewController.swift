//
//  ViewController.swift
//  OnlyPictures
//
//  Created by Kiran Jasvanee on 10/02/2017.
//  Copyright (c) 2017 Kiran Jasvanee. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableview.dataSource = self
        self.tableview.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "onlypicture_options"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        if indexPath.row == 0 {
            cell?.textLabel?.text = "Web Images Loader - 1"
        }else if indexPath.row == 1 {
            cell?.textLabel?.text = "Web Images Loader with manual count - 2"
        }
        cell?.textLabel?.font = UIFont.init(name: "HelveticaNeue", size: 18)
        cell?.textLabel?.textColor = .gray
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "WebImageLoader", sender: nil)
        }else if indexPath.row == 1 {
            self.performSegue(withIdentifier: "WebImageLoaderManualCount", sender: nil)
        }
    }
}
