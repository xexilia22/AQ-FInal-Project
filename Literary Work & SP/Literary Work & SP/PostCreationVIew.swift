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
    @State private var title: String = ""

    init(onCreatePost: @escaping (Post) -> Void) {
        self.onCreatePost = onCreatePost
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter title here", text: $title)
                    .padding()
                    
//                    .frame(width: 325, height: 50)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding()
//                    .border(Color.black.opacity(0.2), width: 1)
                Text("Enter content here")
                    .font(.headline)
                    .padding()
                
                TextEditor(text: $content)
                    .padding(.horizontal, 4)
                    .frame(minHeight: 50)
                    .overlay(Rectangle()
                        .frame(height: 1)
                        .padding(.top, 5), alignment: .bottom)
                    .foregroundColor(.primary)
                    .font(.body)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.bottom, 16)
                
                Spacer()

                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 150, height: 39)
                    .background(.red)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 1))

                    Spacer()

                    Button("Post") {
                        guard let author = userManager.currentUser else { return }
                        let newPost = Post(author: author, title: title, content: content, comments: [])
                        onCreatePost(newPost)
                        dismiss()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 150, height: 39)
                    .background(.blue)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1))
                }
                .padding()
            }
            .navigationTitle("Create Post")
        }
    }
    
    private func savePostToJSON(_ post: Post) {
        var posts = StorageManager.loadPosts()
        posts.append(post)
        StorageManager.savePosts(posts)
    }
}



