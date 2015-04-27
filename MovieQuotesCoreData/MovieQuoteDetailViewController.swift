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
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //TODO: Listen for changes to the quote
        
        updateView()
    }
    
    func quoteChanged() {
        //TODO: Push change to Firebase
    }
    
    func updateView() {
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "showEditQuoteDialog")
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

}
