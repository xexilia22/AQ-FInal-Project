//
//  ContentView.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/15/24.
//
import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject private var userManager = UserManager()
    var body: some Scene {
        VStack{
            LogInView()
                            .environmentObject(userManager)
        }
            
        
    }
}

#Preview {
    ContentView()
}
