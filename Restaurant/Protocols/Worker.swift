//
//  Worker.swift
//  Restaurant
//
//  Created by Denis Denisov on 4/7/25.
//

import Foundation

protocol Worker: Sendable {
    func makeOrder(completion: @escaping (OrderState) -> Void) async
}
