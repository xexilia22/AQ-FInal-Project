//
//  RegisterView.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/15/24.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var isLoginPage: Bool = false
    
    
    var body: some View {
           VStack {
               Text("Register")
                   .font(.largeTitle)
                   .bold()

               TextField("Username", text: $username)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding()

               SecureField("Password", text: $password)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding()

               SecureField("Confirm Password", text: $confirmPassword)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding()


               Button("Register") {
                   if username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                       errorMessage = "All fields are required."
                       showError = true
                       return
                   }

                   if password != confirmPassword {
                       errorMessage = "Passwords do not match."
                       showError = true
                       isLoginPage = false
                       return
                   }

                   if userManager.register(username: username, password: password) {
                       isLoginPage = true
                       isLoginPage = false
                       dismiss()
                   } else {
                       errorMessage = "Username already exists."
                       isLoginPage = false
                       showError = true
                   }
               }
               .padding()
               .foregroundStyle(.white)
               .padding()
               .frame(width: 332, height: 39)
               .background(Color.mint)
               .cornerRadius(8.0)
               .alert(isPresented: $showError) {
                   Alert(title: Text("Message"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
               }
               .sheet(isPresented: $isLoginPage) {
                   LogInView()
               }
               
               Button("Cancel") {
                   isLoginPage = true
               }
               .foregroundStyle(.white)
               .padding()
               .frame(width: 332, height: 39)
               .background(Color.blue)
               .cornerRadius(8.0)
               .sheet(isPresented: $isLoginPage) {
                   LogInView()
               }
               
               
           }
           .padding()
       }
   }

#Preview {
    RegisterView()
}
