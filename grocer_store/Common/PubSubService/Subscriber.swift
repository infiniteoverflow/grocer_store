//
//  Subscriber.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 25/02/23.
//

import Foundation

protocol Subscriber {
    func getPublisherData(state: NetworkState, extra: Any?)
}
