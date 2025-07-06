//
//  Cook.swift
//  Restaurant
//
//  Created by Denis Denisov on 3/7/25.
//

import Foundation

actor Cook: Worker {
    func makeOrder(callback: OrderCallback) {
        let timePreparation = Int.random(in: 3...7)
        callback(.processing, timePreparation)
        sleep(UInt32(timePreparation))
    }
}
