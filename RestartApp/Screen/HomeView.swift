//
//  HomeView.swift
//  RestartApp
//
//  Created by Yusril on 16/01/23.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: -Property
    
    @AppStorage("onboarding") var isOnboardingActive = false
    @State private var isAnimate: Bool = false
    
    //MARK: -Body
    var body: some View {
        VStack(spacing: 20){
            //MARK: Header
            
            Spacer()
            
            ZStack{
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimate ? 35 : -35)
                    .animation(
                        Animation
                            .easeOut(duration: 4)
                            .repeatForever()
                        , value: isAnimate
                    )
            }
            
            //MARK: Center
            
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            //MARK: Footer
            Spacer()
            
            Button(action: {
                withAnimation {
                    playSound(sound: "success", type: "m4a")
                    isOnboardingActive = true
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }//button
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .opacity(isAnimate ? 1 : 0)
            .offset(y: isAnimate ? 1 : 40)
            .animation(.easeOut(duration: 0.3), value: isAnimate)
        }// vstack
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                isAnimate = true
            })
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
