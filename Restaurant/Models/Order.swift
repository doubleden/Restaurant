//
//  OrderState.swift
//  Restaurant
//
//  Created by Denis Denisov on 3/7/25.
//

import Foundation

enum OrderState {
    case inQueue
    case processing
    case waitingForDelivery
    case delivering
    case delivered
    
    var description: String {
        switch self {
        case .inQueue: "В очереди 🕐"
        case .processing: "Готовится 👨‍🍳"
        case .waitingForDelivery: "Готов, ожидает курьера 🍔"
        case .delivering: "Доставляется 🚚"
        case .delivered: "Доставлен ✅"
        }
    }
}

struct Order: Identifiable {
    let id = UUID()
    
    var title = ["Суп", "Котлеты", "Салат"].randomElement() ?? "Суп"
    var isFoodReady = false
    var state = OrderState.inQueue
    var preparationTime = 0
}
