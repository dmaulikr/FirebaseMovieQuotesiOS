//
//  MovieQuote.swift
//  MovieQuotesFirebase
//
//  Created by CSSE Department on 4/26/15.
//  Copyright (c) 2015 CSSE Department. All rights reserved.
//

import Foundation

class MovieQuote {
    let key : String
    var movie : String
    var quote : String
    
    init(key: String, quote: String, movie: String) {
        self.key = key
        self.quote = quote
        self.movie = movie
    }
}