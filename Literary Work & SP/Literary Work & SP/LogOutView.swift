//
//  LogOutView.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/15/24.
//

import Foundation
import SwiftUI

struct LogOutView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var isShowingLoginPage: Bool = false

    var body: some View {
        VStack {
            Text("Logged in as \(userManager.currentUser ?? "Unknown")")
                .font(.headline)
                .padding()

            Button("Logout") {
                isShowingLoginPage = true
                userManager.logout()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $isShowingLoginPage) {
                LogInView()
                    .environmentObject(userManager)
            }
        }
    }
}
