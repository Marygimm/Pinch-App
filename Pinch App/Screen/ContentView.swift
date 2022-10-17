//
//  ContentView.swift
//  Pinch App
//
//  Created by Mary Moreira on 17/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    //MARK : - Properties
    
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    
    
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - PAGE IMAGE
                
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .scaleEffect(imageScale)
                
                //MARK: 1. Tap Gesture
                
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            withAnimation(.spring()) {
                                imageScale = 1
                            }
                        }
                    }
                
            } //: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimating = true
            }
            )
            
        } //: NavigationView
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
