//
//  DeliveryMen.swift
//  Restaurant
//
//  Created by Denis Denisov on 3/7/25.
//

import Foundation

actor DeliveryMen: Worker {
    func makeOrder(callback: @escaping OrderCallback) {
        Task {  await callback(.delivering) }
        sleep(UInt32.random(in: 2...5))
    }
}
