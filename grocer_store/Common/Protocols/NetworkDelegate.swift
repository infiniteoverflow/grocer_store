//
//  NetworkDelegate.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 27/02/23.
//

import Foundation

protocol NetworkDelegate {
    func updateViewWithData(state: NetworkState, extra: Any?)
}
