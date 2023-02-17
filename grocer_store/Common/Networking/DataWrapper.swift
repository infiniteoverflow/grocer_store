//
//  DataWrapper.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

/// A DataWrapper class that sets the following property:
/// 1. `isLoading` : When the network call is in progress, and to update the ui
/// with the appropriate content.
/// 2. `success` : Holds the data model of type T
/// 3. `error` : Failure reason of the network call
struct DataWrapper<T> {
    var isLoading: Bool = false
    var success: T?
    var error: String = ""
}
