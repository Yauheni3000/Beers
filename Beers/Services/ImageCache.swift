//
//  ImageCache.swift
//  Beers
//
//  Created by Yauheni Yursha on 22/11/2023.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    private init () {}
}
