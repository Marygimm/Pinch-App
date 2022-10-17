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
    @State private var imageOffSet: CGSize = .zero
    
    
    //MARK: - Function
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffSet = .zero
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.clear
                //MARK: - PAGE IMAGE
                
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .offset(x: imageOffSet.width, y: imageOffSet.height)
                    .scaleEffect(imageScale)
                
                //MARK: 1. Tap Gesture
                
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            resetImageState()
                        }
                    }
                
                //MARK: - 2. Drag Gesture
                    .gesture(DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                imageOffSet = value.translation
                            }
                        }
                        .onEnded({ _ in
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        })
                    )
                
                // MARK: - Magnification
                    .gesture(MagnificationGesture()
                        .onChanged({ value in
                            withAnimation(.linear(duration: 1)) {
                                if imageScale >= 1 && imageScale <= 5 {
                                    imageScale = 5
                                } else if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        })
                            .onEnded { _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                
            } //: ZStack
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimating = true
            }
            )
            //MARK: - Info panel
            .overlay(InfoPanelView(scale: imageScale, offset: imageOffSet)
                .padding(.horizontal)
                .padding(.top, 30), alignment: .top)
            
            //MARK: - Controls
            .overlay(
                Group {
                    HStack {
                        //Scale down
                        
                        Button {
                            withAnimation(.spring()) {
                                if imageScale > 1 {
                                    imageScale -= 1
                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        //Reset
                        
                        Button { resetImageState() } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        //Scale up
                        
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                    
                                    if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30), alignment: .bottom)
            
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
