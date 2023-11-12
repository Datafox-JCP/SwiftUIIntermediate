//
//  ScrollHomeView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 05/11/23.
//

import SwiftUI

struct ScrollHomeView: View {
    // MARK: Properties
    @State private var allExpenses: [Expense] = []
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Mis Gastos")
                        .font(.largeTitle.bold())
                        .padding(.horizontal, 16)
                    
                    GeometryReader {
                        let rect = $0.frame(in: .scrollView)
                    } //Reader
                    .frame(height: 120)
                } // VStack
                
                LazyVStack(spacing: 16) {
                    Menu {
                        
                    } label: {
                        HStack(spacing: 4) {
                            Text("Filtrar por")
                            Image(systemName: "chevron.down")
                        } // Hstack
                        .font(.caption)
                        .foregroundStyle(.gray)
                    } // Menu
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    ForEach(allExpenses) { expense in
                        
                    } // Loop
                } // LVStack
                .padding(16)
            } // VStack
            .padding(.vertical, 16)
        } // Scroll
        .scrollIndicators(.hidden)
        .onAppear {
            allExpenses = expenses.shuffled()
        }
    }
    
    // MARK: - Expense Card View
    @ViewBuilder
    func ExpenseCardView(_ expense: Expense) -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4, content: {
                Text(expense.product)
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Text(expense.spendType)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
            }) // VSTack
            
            Spacer(minLength: 0)
            
            Text(expense.amountSpent)
                .fontWeight(.bold)
        } // HStack
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
    }
}

#Preview {
    ScrollHomeView()
}
