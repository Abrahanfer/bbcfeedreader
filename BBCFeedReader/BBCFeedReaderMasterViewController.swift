//
//  ViewController.swift
//  BBCFeedReader
//
//  Created by Abrahán Fernández Nieto on 12/11/16.
//  Copyright © 2016 Abrahanfer. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import SDWebImage

class BBCFeedReaderMasterViewController: UITableViewController {
    
    let cellIdentifier = "Cell"
    var news = [News]()
    
    @IBOutlet var newsTableView: UITableView!
    
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

        barButtonItem.isEnabled = true
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        // SplitViewController delegate
        self.splitViewController?.delegate = self
        
        Alamofire.request("http://feeds.bbci.co.uk/news/world/rss.xml")
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                switch response.result {
                case .success(let value):
                    let xml = SWXMLHash.parse(value)
                    
                    let channel = xml["rss"]["channel"]
                    
                    var newsResults = [News]()
                    for item in channel["item"].all {
                        
                        let headline = item["title"].element?.text
                        let date = item["pubDate"].element?.text
                        let description = item["description"].element?.text
                        let link = item["link"].element?.text
                        let thumbnail = item["media:thumbnail"].element?.attribute(by: "url")?.text
                        
                        if let headlineUnwrapped = headline,
                            let dateUnwrapped = date,
                            let descriptionUnwrapped = description,
                            let linkUnwrapped = link,
                            let thumbnailUnwrapped = thumbnail {
                            
                            let news = News()
                            news.headline = headlineUnwrapped
                            news.date = dateUnwrapped
                            news.description = descriptionUnwrapped
                            news.sourceURL = linkUnwrapped
                            news.thumbnailURL = thumbnailUnwrapped
                            newsResults.append(news)
                        }
                    }
                    
                    self.news = newsResults
                    self.tableView.reloadData()
                case .failure(let error):
                    print("error: ", error)
                }
        }
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
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BBCFeedReaderCell
        let newsItem = news[indexPath.row]
        
        cell.headlineLabel.text = newsItem.headline
        cell.dateLabel.text = newsItem.date
        cell.descriptionLabel.text = newsItem.description
        
        cell.thumbnailImageView.sd_setImage(with: URL(string: newsItem.thumbnailURL)!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? BBCFeedReaderCell {
            let index = self.tableView.indexPath(for: cell)
            let newsItem = news[(index?.row)!]
            if let detailVC = segue.destination as? BBCFeedReaderDetailViewController {
                print("Entra aqui")
               detailVC.newsItem = newsItem
            }
        }
    }
    
}

extension BBCFeedReaderMasterViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        /*guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? BBCFeedReaderDetailViewController else { return false }
        if topAsDetailController.newsItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false*/
        
        return true
    }
}

