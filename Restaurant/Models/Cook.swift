//
//  Cook.swift
//  Restaurant
//
//  Created by Denis Denisov on 3/7/25.
//

import Foundation

actor Cook: Worker {
    func makeOrder(completion: @escaping (OrderState) -> Void) {
        completion(.processing)
        sleep(UInt32.random(in: 3...7))
    }
}
