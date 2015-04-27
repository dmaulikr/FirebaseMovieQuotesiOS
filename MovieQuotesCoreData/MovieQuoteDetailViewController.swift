//
//  MovieQuoteDetailViewController.swift
//  MovieQuotesCoreData
//
//  Created by CSSE Department on 3/24/15.
//  Copyright (c) 2015 CSSE Department. All rights reserved.
//

import UIKit

class MovieQuoteDetailViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    var quoteTextField: UITextField?
    var movieTextField: UITextField?
    var movieQuote : MovieQuote?
    var movieQuotesRef : Firebase?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "showEditQuoteDialog")
        //TODO: Listen for changes to the quote
        movieQuotesRef?.observeEventType(.ChildChanged, withBlock: {
            snapshot in
            if snapshot.key == "quote" {
                self.movieQuote?.quote = snapshot.value as! String
            } else {
                self.movieQuote?.movie = snapshot.value as! String
            }
            self.updateView()
        })
    }
    
    func showEditQuoteDialog() {
        let alertController = UIAlertController(title: "Edit new movie quote", message: "", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            textField.placeholder = "Quote"
            textField.text = self.movieQuote?.quote
            self.quoteTextField = textField
            textField.addTarget(self, action: "quoteChanged", forControlEvents: .EditingChanged)
        }
        alertController.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            textField.placeholder = "Movie Title"
            textField.text = self.movieQuote?.movie
            self.movieTextField = textField
            textField.addTarget(self, action: "quoteChanged", forControlEvents: .EditingChanged)
        }
        let cancelAction = UIAlertAction(title: "Done", style: .Cancel) {
            (_) -> Void in
            println("Done")
        }
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func quoteChanged() {
        let mq = ["quote":quoteTextField!.text!, "movie":movieTextField!.text!]
        movieQuotesRef?.setValue(mq)
    }
    
    func updateView() {
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
    }

}
