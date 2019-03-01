//
//  Result.swift
//  WeatherApp
//
//  Created by Nathan Sharma on 27/02/2019.
//  Copyright © 2019 Nathan Sharma. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
