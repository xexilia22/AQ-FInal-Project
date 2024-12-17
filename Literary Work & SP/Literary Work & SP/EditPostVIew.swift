//
//  EditPostView.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/16/24.
//

import Foundation
import SwiftUI

struct EditPostView: View {
    @Binding var post: Post // binding to the selected post
    @Environment(\.dismiss) var dismiss
    @State private var updatedContent: String
    @State private var textHeight: CGFloat = 100
    
    init(post: Binding<Post>) {
        _post = post
        _updatedContent = State(initialValue: post.wrappedValue.content)
    }
    
    var body: some View {
        VStack {

            TextEditor(text: $updatedContent)
                .frame(minHeight: 50, maxHeight: .infinity)
//                .overlay(Rectangle()
//                    .frame(height: 1)
//                    .padding(.top, 5), alignment: .bottom)
                .padding(.horizontal, 4)
                .foregroundColor(.primary)
                .font(.body)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
//                .padding(.bottom, 16)
                .onChange(of: post.content) { _ in
                    textHeight = max(100, CGFloat(post.content.split(whereSeparator: \.isNewline).count) * 30)
                }
            
            Button("Save") {
                post.content = updatedContent
                print("post_content: \(post.content)")
                print("post: \(post)")
                updatePostContent(postID: post.id, newContent: updatedContent)
                dismiss()
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Edit Post")
    }
    
    private func printtest(content: String) {
        print("post_content: \(post.content)")
        print("post: \(post)")
    }
    
    private func savePostToJSON(_ post: Post) {
        var posts = StorageManager.loadPosts()
        posts.append(post)
        print("updated: \(updatedContent)")
        print("post: \(post)")
        print("posts after edition: \(posts)")
        StorageManager.savePosts(posts)
    }
    
    
    private func updatePostContent(postID: UUID, newContent: String) {
        var posts = StorageManager.loadPosts()
        if let index = posts.firstIndex(where: {$0.id == postID}) {
            posts[index].content = newContent
            StorageManager.savePosts(posts)
        }
    }
}
