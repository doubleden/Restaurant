//
//  DeliveryMen.swift
//  Restaurant
//
//  Created by Denis Denisov on 3/7/25.
//

import Foundation

actor DeliveryMen: Worker {
    func makeOrder(callback: @escaping OrderCallback) {
        let timePreparation = Int.random(in: 2...5)
        Task { await (callback(.delivering, timePreparation)) }
        sleep(UInt32(timePreparation))
    }
}
