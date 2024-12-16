//
//  PostView.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/15/24.
//

import Foundation
import SwiftUI

struct PostView: View {
    @Binding var post: Post
    @EnvironmentObject var userManager: UserManager
    @State private var newComment: String = ""
    @State private var posts: [Post] = StorageManager.loadPosts()
    @FocusState private var isCommentFieldFocused: Bool
    

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Post header: Author and creation time
            HStack {
                Text("Author: \(post.author)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(post.creationTime, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            // Post content
            Text(post.content)
                .font(.body)
                .padding(.horizontal)

            Spacer()
            
            // Like and Comment buttons
            HStack {
                Button(action: {
                    post.likes += 1
                    updatePostInJSON()
                }) {
                    HStack {
                        Image(systemName: post.likes > 0 ? "heart.fill" : "heart")
                            .foregroundColor(post.likes > 0 ? .red : .gray)
                        Text("\(post.likes)")
                            .font(.caption)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    isCommentFieldFocused = true
                }) {
                    HStack {
                        Image(systemName: "bubble.left")
                            .foregroundColor(.blue)
                        Text("\(post.comments.count)")
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()

            // Comments section
            Text("Comments")
                .font(.headline)
                .padding(.horizontal)

            List {
                ForEach(post.comments, id: \.id) { comment in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(comment.author)
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            Text(comment.creationTime, style: .time)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Text(comment.content)
                            .font(.body)
                            .padding(.vertical, 4)
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(PlainListStyle())

            // Add a new comment
            if userManager.isLoggedIn {
                HStack {
                    TextField("Write a comment...", text: $newComment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($isCommentFieldFocused)

                    // add a comment
                    Button("Post") {
                        if let author = userManager.currentUser, !newComment.isEmpty {
                            let comment = Comment(author: author, content: newComment, creationTime: Date())
                            post.comments.append(comment)
                            print("post after adding comment: \(post)")
                            updatePostInJSON()
                            newComment = ""
                            isCommentFieldFocused = false
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            } else {
                Text("Log in to comment.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func updatePostInJSON() {
        if let index = posts.firstIndex(where: {
            $0.id == post.id
        }) {
            print("index: \(index)")
            posts[index] = post
            StorageManager.savePosts(posts)
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



