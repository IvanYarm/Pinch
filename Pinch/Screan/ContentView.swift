//
//  ContentView.swift
//  Pinch
//
//  Created by Ivan Yarmoliuk on 5/4/24.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Property
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOfset: CGSize = .zero
    
    //MARK: -Function
    func resetWithAnimation() {
        return withAnimation(.spring) {
            imageScale = 1
            imageOfset = .zero
        }
    }
    //MARK: -Content
    
    var body: some View {
        
        
        NavigationView {
            ZStack {
                //MARK: - Page Image
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOfset.width, y: imageOfset.height)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .scaleEffect(self.imageScale)
                //MARK: - 1. Tap gesture
                    .onTapGesture(count: 2, perform: {
                        if self.imageScale == 1 {
                            withAnimation(.linear) {
                                self.imageScale = 5
                            }
                        } else {
                            resetWithAnimation()
                        }
                    })
                    .gesture(DragGesture()
                        .onChanged({ value in
                            withAnimation(.linear) {
                                imageOfset = value.translation
                            }
                        })
                            .onEnded({ _ in
                                if self.imageScale <= 1 {
                                    resetWithAnimation()
                                    
                                }
                            })
                    )
                
            }//: Zstack
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
        }//: Navigation
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
