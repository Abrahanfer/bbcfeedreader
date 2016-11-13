//
//  BBCFeedReaderDetailViewController.swift
//  BBCFeedReader
//
//  Created by Abrahán Fernández Nieto on 13/11/16.
//  Copyright © 2016 Abrahanfer. All rights reserved.
//

import UIKit

class BBCFeedReaderDetailViewController: UIViewController {
    
    var newsItem: News?
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
        self.navigationItem.leftItemsSupplementBackButton = true
        
        if let newsItemUnwrapped = newsItem {
            webView.loadRequest(URLRequest(url: URL(string: newsItemUnwrapped.sourceURL)!))
        }
    }
}

extension BBCFeedReaderDetailViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Error: ", error)
    }
}
