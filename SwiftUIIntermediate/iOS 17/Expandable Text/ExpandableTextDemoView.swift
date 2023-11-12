//
//  ExpandableTextDemoView.swift
//  SwiftUIIntermediate
//
//  Created by Juan Hernandez Pazos on 12/11/23.
//

import SwiftUI

struct ExpandableTextDemoView: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ExpandableView(thumbnail: ThumbnailView(content: {
                        VStack {
                            Text("Nadie puede definir el éxito por nosotros, solo nosotros podemos hacerlo.")
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                            
                            Text("Jeffrey A. Sonnnenfeld")
                                .foregroundStyle(.white)
                                .font(.system(size: 12))
                                
                        }
                        .padding()
                    }), expanded: ExpandedView(content: {
                        VStack {
                            Image(.imagen2)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .aspectRatio(contentMode: .fill)
                            Text("Nadie puede...")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                            
                            Text("Harvard Business Review (Feb 2007)")
                                .foregroundStyle(.white)
                                .font(.system(size: 12))
                                .padding(.bottom, 16)
                            
                            Text("Nadie puede definir el éxito por nosotros, solo nosotros podemos hacerlo. Nadie puede quitarnos la dignidad, a menos que nos rindamos. Nadie puede quitarnos la esperanza y el orgullo, a menos que renunciemos a ellos. Nadie puede robarnos la creatividad, la imaginación y nuestras habilidades, a menos que dejemos de pensar. Nadie puede evitar que nos recuperemos, a menos menos que renunciemos a ello.")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                                .padding(.bottom, 16)
                            
                            Text("Jeffrey A. Sonnnenfeld")
                                .foregroundStyle(.white)
                                .fontDesign(.serif)
                                .font(.system(size: 12))
                            
                            Spacer()
                        }
                        .padding()
                    }))
                }
                .padding()
            }
            .scrollIndicators(.never)
        }
    }
}

#Preview {
    ExpandableTextDemoView()
}
