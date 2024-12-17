//
//  RootView.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/17/24.
//

import Foundation
import SwiftUI

struct RootView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        Group {
            if userManager.isLoggedIn {
                CommunityView()
                
            } else {
                LogInView()
            }
        }
        .onAppear {
            print("Usermanager: \(userManager.isLoggedIn)")
            print("Usermanager: \(String(describing: userManager.currentUser))")
        }
    }

}
