//
//  RestaurantViewModel.swift
//  Restaurant
//
//  Created by Denis Denisov on 3/7/25.
//

import Foundation
import Observation

@MainActor
@Observable
final class RestaurantViewModel {
    var orders: [Order] = []
    
    private let cook = Cook()
    private let deliveryMen = DeliveryMen()
    
    func placeOrder() async {
        let order = Order()
        orders.append(order)
        
        await give(order: order, to: cook)
        
        guard let orderIndex = getOrderIndex(by: order.id) else { return }
        orders[orderIndex].state = .waitingForDelivery
        
        await give(order: order, to: deliveryMen)
        
        guard let orderIndex = getOrderIndex(by: order.id) else { return }
        orders[orderIndex].state = .delivered
    }
}

// MARK: - Private Methods
private extension RestaurantViewModel {
    func getOrderIndex(by id: UUID) -> Int? {
        orders.firstIndex(where: { $0.id == id })
    }
    
    func give<T: Worker>(order: Order, to worker: T) async {
        await worker.makeOrder { [weak self] orderState in
            guard let self else { return }
            
            guard let orderIndex = self.getOrderIndex(by: order.id) else { return }
            self.orders[orderIndex].state = orderState
        }
    }
}
