//
//  ViewController.swift
//  Shorty
//
//  Created by Anatoliy Goodz on 6/8/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var urlField: UITextField!
    @IBOutlet var webView: UIWebView!
    @IBOutlet var shortenButton: UIBarButtonItem!
    @IBOutlet var shortLabel: UIBarButtonItem!
    @IBOutlet var clipboardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadLocation( _: AnyObject ) {
        var urlText = urlField.text
        if urlText!.hasPrefix("http:") && urlText!.hasPrefix("https:") {
            if urlText!.hasPrefix("//") {
                urlText! = "//" + urlText!
            }
            
            urlText! = "http:" + urlText!
        }
        
        let url = NSURL(string: urlText!)
        webView!.loadRequest(NSURLRequest(URL: url!))
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        shortenButton.enabled = false
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        shortenButton.enabled = true
        urlField.text = webView.request!.URL!.absoluteString
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        let message = "That page could not be loaded. " +
            error!.localizedDescription
        let alert = UIAlertController(title: "Could not load URL",
                                      message: message,
                                      preferredStyle: .Alert )
        let okAction = UIAlertAction(title: "That's Sad",
                                     style: .Default,
                                     handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
}

