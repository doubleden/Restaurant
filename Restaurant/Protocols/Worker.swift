//
//  Worker.swift
//  Restaurant
//
//  Created by Denis Denisov on 4/7/25.
//

import Foundation

typealias OrderCallback = @MainActor @Sendable (OrderState) -> Void

protocol Worker: Sendable {
    func makeOrder(callback: @escaping OrderCallback) async
}
