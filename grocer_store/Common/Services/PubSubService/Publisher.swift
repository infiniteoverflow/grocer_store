//
//  Publisher.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 25/02/23.
//

import Foundation

/// A Publisher class that sends notifications to its subscibers.
class Publisher {
    
    // Making this class a singleton
    static let instance = Publisher()
    private init() {}
    
    // Stores the list of subscribers.
    var subscribers: [String : Subscriber] = [:]
    
    // Add a new Subscriber.
    func subscribe(subscriber: Subscriber) {
        let nameOfTheSubscriber = String(describing: type(of: subscriber.self))
        subscribers[nameOfTheSubscriber] = subscriber
    }
    
    // Removes a Subsciber.
    func unsubscribe(subscriber: Subscriber) {
        let nameOfTheSubscriber = String(describing: type(of: subscriber.self))
        subscribers.removeValue(forKey: nameOfTheSubscriber)
    }
    
    // Notify all subscribers.
    func notifyAll(state : NetworkState, extra: Any?) {
        subscribers.forEach { (key: String, value: Subscriber) in
            subscribers[key]?.getPublisherData(state: state,extra: extra)
        }
    }
    
    // Notify selected subscribers.
    func notify(list: [String], state: NetworkState, extra: Any?) {
        list.forEach { sub in
            subscribers[sub]?.getPublisherData(state: state,extra: extra)
        }
    }
}
