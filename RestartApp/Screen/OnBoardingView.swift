//
//  OnBoardingView.swift
//  RestartApp
//
//  Created by Yusril on 16/01/23.
//

import SwiftUI

struct OnBoardingView: View {
    //MARK: - Property
    
    @AppStorage("onboarding") var isonBoardingIsActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimate: Bool = false
    @State private var imageOffset: CGSize = CGSize(width: 0, height: 0) // or using .zero
    @State private var indicatorOffset: Double = 1.0
    @State private var textTitle: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack (spacing: 20){
                //MARK: Header
                
                Spacer()
                
                VStack(spacing: 0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                         It's not how much we give but
                        how much love put into giving.
                        """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }// header
                .opacity(isAnimate ? 1 : 0)
                .offset(y: isAnimate ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimate)
                
                //MARK: Center
                
                ZStack{
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimate ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimate)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width/20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOffset = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }
                                .onEnded{ _ in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOffset = 1
                                        textTitle = "Share."
                                    }
                                }
                        )//gesture
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }// center
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimate ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimate)
                        .opacity(indicatorOffset)
                    , alignment: .bottom
                )
                Spacer()
                
                //MARK: Bottom
                
                ZStack{
                    // part of custom button
                    
                    //1. background(static)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    //2. call to action (static)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    //3. capsule(dynamic state)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }
                    //4. circle (dragable)
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80{
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(Animation.easeOut(duration: 0.2)) {
                                        if buttonOffset > buttonWidth / 2{
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isonBoardingIsActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                         buttonOffset = 0
                                        }
                                    }
                                       
                                }
                        )//gesture
                        
                        Spacer()
                    }//hstack
                    
                }//footer
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimate ? 1 : 0)
                .offset(y: isAnimate ? 1 : 40)
                .animation(.easeOut(duration: 1), value: isAnimate)
            }//: VStack
        }//: ZStack
        .onAppear(perform: {
            isAnimate = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
