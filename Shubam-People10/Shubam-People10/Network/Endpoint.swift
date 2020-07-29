//
//  Endpoint.swift
//  Binger
//
//  Created by Appiness on 8/27/19.
//  Copyright © 2019 Appiness. All rights reserved.
//

import Foundation

enum Environment {
    case production
    case development
}



// Production base url


// Development base url
let dev = "https://s3.amazonaws.com"


// Change the environment here...
let env: Environment = .development

// List of api path
enum Path: String {
    case sampleAPI =               "/br-codingexams/restaurants.json"
}

// Convert string to valid url using URL Components
struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem]?
    init(withPath path: Path, andSubpath subPath: String? = "", andQueryItems queryItems: [URLQueryItem]? = nil) {
        self.path = path.rawValue
        if let tempPath = subPath, !tempPath.isEmpty {
            self.path.append(tempPath)
        }
        self.queryItems = queryItems
    }
    
    var urlComponents: URLComponents {
        guard var components = URLComponents(string: dev) else {
            return URLComponents()
        }
        components.path = path
        if let queryItems = self.queryItems {
            components.queryItems = []
            components.queryItems?.append(contentsOf: queryItems)
        }
        return components
    }
    var url: URL? {
        return urlComponents.url
    }
}
