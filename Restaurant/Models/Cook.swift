//
//  Cook.swift
//  Restaurant
//
//  Created by Denis Denisov on 3/7/25.
//

import Foundation

actor Cook: Worker {
    func makeOrder(callback: @escaping OrderCallback) {
        let timePreparation = Int.random(in: 3...7)
        Task { await (callback(.processing, timePreparation)) }
        sleep(UInt32(timePreparation))
    }
}
