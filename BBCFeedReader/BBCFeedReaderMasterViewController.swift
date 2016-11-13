//
//  ViewController.swift
//  BBCFeedReader
//
//  Created by Abrahán Fernández Nieto on 12/11/16.
//  Copyright © 2016 Abrahanfer. All rights reserved.
//

import UIKit

class BBCFeedReaderMasterViewController: UITableViewController {
    
    let cellIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        let imageView = UIImageView(image: UIImage(named: "BBClogo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        self.navigationItem.titleView = imageView
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search,
                                            target: nil,
                                            action: nil)

        barButtonItem.isEnabled = false
        self.navigationItem.rightBarButtonItem = barButtonItem
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableVIewController methods
    override func numberOfSections(in: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        // Return the number of rows in the section.
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        // TODO: Make BBCFeedReaderCell configuration
        
        return cell
    }

}

