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
        
        
        if let newsItemUnwrapped = newsItem {
            webView.loadRequest(URLRequest(url: URL(string: newsItemUnwrapped.sourceURL)!))
        } else {
            webView.loadRequest(URLRequest(url: URL(string: "http://www.bbc.com/news")!))
        }
    }
}

extension BBCFeedReaderDetailViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Error: ", error)
    }
}
