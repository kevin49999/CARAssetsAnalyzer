//
//  Asset.swift
//  CARAssetsAnalyzer
//
//  Created by Kevin Johnson on 2/20/19.
//  Copyright © 2019 Kevin Johnson. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

struct Asset {
    let imageName: String
    let bytes: Int64
    
    init?(json: JSON) {
        guard let imageName = json["Name"] as? String,
            let bytes = json["SizeOnDisk"] as? Int64 else {
                return nil
        }
        self.imageName = imageName
        self.bytes = bytes
    }
}
