//
//  LogInView.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/15/24.
//

import Foundation
import SwiftUI

struct LogInView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var isShowingRegister: Bool = false
    @State private var isShowingCommunity: Bool = false
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .bold()
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            
            Button("log in") {
                print(userManager.login(username: username, password: password))
                if userManager.login(username: username, password: password){
                    showError = false
                    isShowingCommunity = true
                    print("yes")
                } else {
                    showError = true
                }
            }
            .padding()
            .foregroundStyle(.white)
            .padding()
            .frame(width: 332, height: 39)
            .background(Color.blue)
            .cornerRadius(8.0)
            .alert(isPresented: $showError) {
                Alert(title: Text("Message"), message: Text("Invalid username or password"), dismissButton: .default(Text("OK")))
            }
            .sheet(isPresented: $isShowingCommunity) {
                CommunityView().environmentObject(userManager)
            }
            
            Button("register") {
                isShowingRegister = true
            }
            .padding()
            .foregroundStyle(.white)
            .padding()
            .frame(width: 332, height: 39)
            .background(Color.mint)
            .cornerRadius(8.0)
            .sheet(isPresented: $isShowingRegister) {
                RegisterView().environmentObject(userManager)
            }
        }
        .padding()
    }
}

func showError_print(error: Bool){
    print(error)
}


#Preview {
    LogInView()
}
