//
//  Home.swift
//  TinderUI
//
//  Created by Kleyton Santos on 14/01/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            // Top Nav bar
            Button {
                
            } label: {
                Image("menu")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(Text("Discover").font(.title.bold()))
            .foregroundColor(colorScheme == .dark ? .white: .black)
            .padding()
             
            //Users Stack
            ZStack {
                
                if let users = homeData.displaying_users {
                    
                    if users.isEmpty {
                        Text("Come back later we can find more matches for you!")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        
                        // Displayng Cards...
                        ForEach(users.reversed()) { user in
                            // Card View
                            StackCardView(user: user)
                                .environmentObject(homeData)
                        }
                    }
                    
                } else {
                    ProgressView()
                }
            }
            .padding(.top, 30)
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            //Actions Buttons
            HStack(spacing: 15) {
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color("Gray"))
                        .clipShape(Circle())
                }
                
                Button {
                    doSwipe()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color("Blue"))
                        .clipShape(Circle())
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color.yellow)
                        .clipShape(Circle())
                }
                
                Button {
                    doSwipe(rightSwipe: true)
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color("Pink"))
                        .clipShape(Circle())
                }
                
            }
            .padding(.bottom)
            .disabled(isFinishedUsers())
            .opacity(isFinishedUsers() ? 0.6 : 1)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    private func isFinishedUsers() -> Bool {
        homeData.displaying_users?.isEmpty ?? false
    }
    
    // Removing cards when doing swipe...
    func doSwipe(rightSwipe: Bool = false) {
        
        guard let first = homeData.displaying_users?.first else {
            return
        }
        
        //Using notification to post and receiving in Stack Cards...
        
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil,
        userInfo: [
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
