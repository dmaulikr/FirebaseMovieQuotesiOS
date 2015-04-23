//
//  MovieQuote.swift
//  MovieQuotesCoreData
//
//  Created by CSSE Department on 3/23/15.
//  Copyright (c) 2015 CSSE Department. All rights reserved.
//

import UIKit

class MovieQuote: NSObject {
    var quote : String
    var movie : String
    
    init(quote : String, movie : String) {
        self.quote = quote
        self.movie = movie
    }
}
