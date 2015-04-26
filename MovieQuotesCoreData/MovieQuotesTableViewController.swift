//
//  MovieQuotesTableViewController.swift
//  MovieQuotesCoreData
//
//  Created by CSSE Department on 3/23/15.
//  Copyright (c) 2015 CSSE Department. All rights reserved.
//

import UIKit

class MovieQuotesTableViewController: UITableViewController {

    let MovieQuotesCellIdentifier = "MovieQuoteCell"
    let NoMovieQuoteCellIdentifier = "NoMovieQuoteCell"
    let ShowDetailSegueIdentifier = "ShowDetailSegue"
    
    var movieQuotes = [MovieQuote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "showAddQuoteDialog")
        navigationItem.leftBarButtonItem = self.editButtonItem()
        movieQuotes.append(MovieQuote(quote: "I'll be back!", movie: "Terminator"))
        movieQuotes.append(MovieQuote(quote: "Yo, Adrian!", movie: "Rocky"))
    }
    
    func showAddQuoteDialog() {
        let alertController = UIAlertController(title: "Create a new movie quote", message: "", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            textField.placeholder = "Quote"
        }
        alertController.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            textField.placeholder = "Movie Title"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            (_) -> Void in
                println("Cancel")
        }
        let createQuoteAction = UIAlertAction(title: "Create Quote", style: .Default) {
            (_) -> Void in
            let quoteTextField = alertController.textFields![0] as! UITextField
            let movieTextField = alertController.textFields![1] as! UITextField
            self.movieQuotes.insert(MovieQuote(quote: quoteTextField.text, movie: movieTextField.text), atIndex: 0)
            if self.movieQuotes.count == 1 {
                self.tableView.reloadData()
            } else {
                self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
            }
            
        }
        alertController.addAction(cancelAction)
        alertController.addAction(createQuoteAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(movieQuotes.count, 1)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if movieQuotes.count == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier(NoMovieQuoteCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier(MovieQuotesCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
            let movieQuote = movieQuotes[indexPath.row]
            cell.textLabel?.text = movieQuote.quote
            cell.detailTextLabel?.text = movieQuote.movie

        }
        return cell
    }
 
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(movieQuotes.count > 0 && editing, animated: movieQuotes.count > 0 && animated)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return movieQuotes.count > 0
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            movieQuotes.removeAtIndex(indexPath.row)
            if movieQuotes.count > 0 {
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } else {
                tableView.reloadData()
                self.setEditing(false, animated: true)
            }
            
        }
    }

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ShowDetailSegueIdentifier {
            let detailController = segue.destinationViewController as! MovieQuoteDetailViewController
            let index = tableView.indexPathForSelectedRow()!.row
            detailController.movieQuote = movieQuotes[index]
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}
