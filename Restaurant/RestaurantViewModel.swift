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
    
    private var timerTasks: [UUID: Task<Void, any Error>] = [:]
    
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
        await worker.makeOrder { [weak self] orderState, timePreparation in
            guard let self else { return }
            
            Task { @MainActor in
                guard let orderIndex = self.getOrderIndex(by: order.id) else { return }
                self.orders[orderIndex].state = orderState
                self.orders[orderIndex].preparationTime = timePreparation
                self.startTimer(for: order)
            }
        }
    }
    
    func startTimer(for order: Order, interval seconds: UInt64 = 1) {
        guard timerTasks[order.id] == nil else { return }
        
        let task = Task { [weak self] in
          while !Task.isCancelled {
            try await Task.sleep(nanoseconds: seconds * 1_000_000_000)
              
            guard let self = self else { break }
            guard let orderIndex = self.getOrderIndex(by: order.id) else { break }
            self.orders[orderIndex].preparationTime -= 1
            
            if self.orders[orderIndex].preparationTime <= 0 {
              self.stopTimer(for: order)
              break
            }
          }
        }
        
        timerTasks[order.id] = task
      }
      
      func stopTimer(for order: Order) {
        let id = order.id
        timerTasks[id]?.cancel()
        timerTasks.removeValue(forKey: id)
      }
}
