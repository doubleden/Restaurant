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
        HStack {
            Spacer()
            Text(order.title)
            Text(order.state.description)
            Spacer()
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
