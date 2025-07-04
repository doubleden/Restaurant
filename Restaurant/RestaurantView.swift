//
//  RestaurantView.swift
//  Restaurant
//
//  Created by Denis Denisov on 3/7/25.
//

import SwiftUI

struct RestaurantView: View {
    @State private var restaurantVM: RestaurantViewModel = .init()
    
    var body: some View {
        ZStack {
            List(restaurantVM.orders) { order in
                RowView(order: order)
            }
            
            OrderButton {
                Task {
                    await restaurantVM.placeOrder()
                }
            }
        }
    }
}

fileprivate struct RowView: View {
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(order.title)
                Text(order.state.description)
                Spacer()
            }
            
            Text("Время ожидания: \(order.preparationTime) сек")
                .opacity(
                    order.state == .processing
                    || order.state == .delivering
                    ? 1 : 0
                )
        }
    }
}

fileprivate struct OrderButton: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Button("Make Order", action: action)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    RestaurantView()
}
