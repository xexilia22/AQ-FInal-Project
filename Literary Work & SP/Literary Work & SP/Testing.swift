//
//  Testing.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/16/24.
//

import Foundation

import SwiftUI

struct Testing: PreviewProvider {
    static var previews: some View {
        LogInView()
            .environmentObject(UserManager())
            .onAppear() {
                let posts = [Post(author: "ALice", content: "this is Alice's Peom", likes: 10, isliked: false, comments: [])]
                StorageManager.savePosts(posts)
            }
        
    }
}
