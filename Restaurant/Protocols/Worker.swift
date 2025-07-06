//
//  Worker.swift
//  Restaurant
//
//  Created by Denis Denisov on 4/7/25.
//

import Foundation

typealias OrderCallback = @Sendable (OrderState, Int) -> Void

protocol Worker: Sendable {
    func makeOrder(callback: OrderCallback) async
}
