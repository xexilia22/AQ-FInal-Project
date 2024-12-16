//
//  PostCreationVIew.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/15/24.
//

import Foundation
import SwiftUI

struct PostCreationView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    var onCreatePost: (Post) -> Void

    @State private var content: String = ""

    init(onCreatePost: @escaping (Post) -> Void) {
        self.onCreatePost = onCreatePost
    }

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $content)
                    .padding()
                    .cornerRadius(8)
                    .frame(width: 325, height: 300)
                    .border(Color.gray, width: 1)
                
                Spacer()

                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.red)

                    Spacer()

                    Button("Post") {
                        guard let author = userManager.currentUser else { return }
                        let newPost = Post(author: author, content: content, comments: [])
                        onCreatePost(newPost)
//                        savePostToJSON(newPost)
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
                .padding()
            }
            .navigationTitle("Create Post")
        }
    }
    
    private func savePostToJSON(_ post: Post) {
        var posts = StorageManager.loadPosts()
        print("posts: \(posts)")
        posts.append(post)
        print("posts: \(posts)")
        StorageManager.savePosts(posts)
    }
}

