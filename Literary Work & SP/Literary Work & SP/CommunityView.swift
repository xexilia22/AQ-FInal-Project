//
//  CommunityView.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/15/24.
//

import Foundation
import SwiftUI

struct CommunityView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var posts: [Post] = StorageManager.loadPosts()
    @State private var isShowingCreatePost = false
    @State private var isShowingLogin = false
    @State private var istesting = true

    var body: some View {
        if userManager.isLoggedIn {
//        if istesting {
            NavigationStack {
                List($posts) { $post in
                    NavigationLink(destination: PostView(post: $post)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Author: \(post.author)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(post.creationTime, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Text(post.content)
                                .font(.body)
                                .padding(.vertical, 4)

                            HStack {
                                Spacer()
                                Button(action: {
                                    post.likes += 1
                                }) {
                                    HStack {
                                        Image(systemName: post.likes > 0 ? "heart.fill" : "heart")
                                            .foregroundColor(post.likes > 0 ? .red : .gray)
                                        Text("\(post.likes)")
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .navigationTitle("Community")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Logout") {
                            userManager.logout()
                        }
                        .sheet(isPresented: $isShowingLogin) {
                            LogInView()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isShowingCreatePost = true
                        }) {
                            Image(systemName: "plus")
                                .font(.title2)
                        }
                    }
                }
                .sheet(isPresented: $isShowingCreatePost) {
                    PostCreationView {newPost in
                        posts.append(newPost)
                        StorageManager.savePosts(posts)
                    }
                }
            }
        } else {
            LogInView()
        }
    }
    
}

