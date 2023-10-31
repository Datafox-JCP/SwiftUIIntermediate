//
//  TransparentBlurView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 18/09/23.
//

import SwiftUI

struct TransparentBlurView: View {
    
    // MARK: Properties
    @State private var activePic = "gato2"
    @State private var blurType: BlurType = .freeStyle
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    TransparentBlur(removeFilters: true)
                        .frame(height: 100 + safeArea.top)
                        .visualEffect { view, proxy in
                            view
                                .offset(y: (proxy.bounds(of: .scrollView)?.minY ?? 0))
                        }
                        /// Placing above all the views
                        .zIndex(1000)
                    VStack(alignment: .leading, spacing: 10) {
                        GeometryReader {
                            let size = $0.size
                            
                            Image(activePic)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(.rect(cornerRadius: 35))
                        } // GeoReader
                        .frame(height: 500)
                        
                        Text("Blur Type")
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(.top, 16)
                        
                        Picker("", selection: $blurType) {
                            ForEach(BlurType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                                    .tag(type)
                            } // Loop
                        } // Picker
                        .pickerStyle(.segmented)
                    } // VStack
                    .padding(16)
                } // VStack
            } // Scroll
            .scrollIndicators(.hidden)
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    TransparentBlurView()
        .preferredColorScheme(.dark)
}

struct TransparentBlur: UIViewRepresentable {
   
    var removeFilters = false
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Remove the background color
        DispatchQueue.main.async {
            if let backgroundLayer = uiView.layer.sublayers?.first {
//                print(backgroundLayer)
                backgroundLayer.filters?.removeAll(where: { filter in
                    String(describing: filter) != "gaussianBlur"
                })
            }
        }
    }
    
}

#Preview {
    TransparentBlur()
}

/// Blur State
enum BlurType: String, CaseIterable {
    case clipped = "Clipped"
    case freeStyle = "Free Style"
}
