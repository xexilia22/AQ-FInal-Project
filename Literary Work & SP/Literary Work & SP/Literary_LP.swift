//___FILEHEADER___

import SwiftUI

@main
struct Literary_LP: App {
    @StateObject var userManager = UserManager()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(userManager)
        }
    }
}


