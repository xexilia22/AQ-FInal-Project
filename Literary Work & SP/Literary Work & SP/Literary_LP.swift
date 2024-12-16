//___FILEHEADER___

import SwiftUI

@main
struct Literary_LP: App {
    @StateObject private var userManager = UserManager()
    var body: some Scene {
        WindowGroup {
            if userManager.isLoggedIn {
                CommunityView()
                    .environmentObject(userManager)
                    .onAppear {
                        userManager.loadFromDefaults()
                    }
            } else {
                LogInView()
            }
        }
    }
}


