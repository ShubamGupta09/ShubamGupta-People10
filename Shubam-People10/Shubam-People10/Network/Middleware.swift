//
//  Middleware.swift
//  Binger
//
//  Created by Appiness on 8/27/19.
//  Copyright © 2019 Appiness. All rights reserved.
//

import Foundation

/// Middleware to handle all the api call except music
class Middleware {
    
    weak var delegate: HTTPDelegate?
    var completionBlock: CompletionBlock?
    
    private lazy var httpClient: HTTP = {
        if let completionBlock = completionBlock {
            return HTTP(withBlock: completionBlock)
        }
        return HTTP(delegate: self.delegate)
    }()
    
    init(withDelegate delegate: HTTPDelegate? = nil, completionBlock: CompletionBlock? = nil) {
        self.delegate = delegate
        self.completionBlock = completionBlock
    }
    
    func cancelRequest() {
        httpClient.cancel()
    }
    
    // MARK: - SAMPLE API
    func sampleAPI() {
         let endpoint = Endpoint(withPath: Path.sampleAPI)
        httpClient.request(ofType: .get, responseType: LunchDetails.self, endPoint: endpoint)
    }
}
