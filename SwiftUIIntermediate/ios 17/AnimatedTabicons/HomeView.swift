//
//  HomeView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 06/09/23.
//

import SwiftUI

struct HomeView: View {
    // MARK: View properties
    @State private var activeTab: Tab = .photos
    /// all tab's
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab? in
        return .init(tab: tab)
    }
    /// bounce property
    @State private var bounceDown = true
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                /// Tabviews
                NavigationStack {
                    VStack {
                        
                    } // VStack
                    .navigationTitle(Tab.photos.title)
                } // Nav
                .setUpTab(.photos)
                
                NavigationStack {
                    VStack {
                        
                    } // VStack
                    .navigationTitle(Tab.chat.title)
                } // Nav
                .setUpTab(.chat)
                
                NavigationStack {
                    VStack {
                        
                    } // VStack
                    .navigationTitle(Tab.apps.title)
                } // Nav
                .setUpTab(.apps)
                
                NavigationStack {
                    VStack {
                        
                    } // VStack
                    .navigationTitle(Tab.notifications.title)
                } // Nav
                .setUpTab(.notifications)
                
                NavigationStack {
                    VStack {
                        
                    } // VStack
                    .navigationTitle(Tab.profile.title)
                } // Nav
                .setUpTab(.profile)
            } // TabView
            
            Picker("", selection: $bounceDown) {
                Text("Bounces down")
                    .tag(true)
                
                Text("Bounces up")
                    .tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
            
            CustomTabBar()
        } // VStack
    }
    
    // MARK: - Custom tab bar
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 9) {
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                
                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .font(.title2)
                        .symbolEffect(bounceDown ? .bounce.down.byLayer : .bounce.up.byLayer, value: animatedTab.isAnimating)
                    
                Text(tab.title)
                    .font(.caption2)
                    .textScale(.secondary)
                } // VStack
                .frame(maxWidth: .infinity)
                .foregroundStyle(activeTab == tab ? Color.primary : Color.gray.opacity(0.8))
                .padding(.top, 16)
                .padding(.bottom, 10)
                .contentShape(.rect)
                /// it's possible use buttons
                .onTapGesture {
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                        activeTab = tab
                        animatedTab.isAnimating = true
                    }, completion: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            animatedTab.isAnimating = nil
                        }
                    })
                }
            } // Loop
        }// HStack
        .background(.bar)
    }
}

#Preview {
    HomeView()
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}
