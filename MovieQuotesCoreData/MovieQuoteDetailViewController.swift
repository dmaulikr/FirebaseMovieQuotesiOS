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
    var movieQuote : MovieQuote?
    
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
        }
        alertController.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            textField.placeholder = "Movie Title"
            textField.text = self.movieQuote?.movie
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            (_) -> Void in
            println("Cancel")
        }
        let editQuoteAction = UIAlertAction(title: "Edit Quote", style: .Default) {
            (_) -> Void in
            let quoteTextField = alertController.textFields![0] as UITextField
            let movieTextField = alertController.textFields![1] as UITextField
            self.movieQuote?.quote = quoteTextField.text
            self.movieQuote?.movie = movieTextField.text
            self.quoteLabel.text = self.movieQuote?.quote
            self.movieLabel.text = self.movieQuote?.movie
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(editQuoteAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
    }

}
