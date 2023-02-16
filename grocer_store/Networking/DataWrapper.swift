//
//  DataWrapper.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 14/02/23.
//

import Foundation

struct DataWrapper<T> {
    var isLoading: Bool = false
    var success: T?
    var error: String = ""
}
