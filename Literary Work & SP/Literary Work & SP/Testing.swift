//
//  Testing.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/16/24.
//

import Foundation

import SwiftUI

struct Testing: PreviewProvider {
    @StateObject private var userManager = UserManager()

    static var previews: some View {
        RootView()
            .environmentObject(UserManager())
//        if userManager.isLoggedIn {
//            CommunityView()
////                    .environmentObject(userManager)
////                    .onAppear {
////                        userManager.loadFromDefaults()
////                    }
//        } else {
//            LogInView()
//                .environmentObject(userManager)
//                .onAppear {
//                    userManager.loadFromDefaults()
//                }
//        }
//        
    }
}


