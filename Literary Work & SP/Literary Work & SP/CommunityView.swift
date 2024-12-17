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
    @State private var isNavigatingToProfile = false
    @State private var likedPostIDs: Set<UUID> = Set(UserDefaults.standard.array(forKey: "likedPostIDs") as? [UUID] ?? [])

    var body: some View {
        if userManager.isLoggedIn {
            NavigationStack {
                List($posts) { $post in
                    NavigationLink(destination: PostView(post: $post)) {
                        VStack(alignment: .leading) {
                            //Post title
                            Text(post.title)
                                .font(.title3)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 2)
                            
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
//                                Spacer()
//                                Button(action: {
//                                    post.likes += 1
//                                }) {
//                                    HStack {
//                                        Image(systemName: post.likes > 0 ? "heart.fill" : "heart")
//                                            .foregroundColor(post.likes > 0 ? .red : .gray)
//                                        Text("\(post.likes)")
//                                            .font(.caption)
//                                    }
//                                }
                                Image(systemName: post.isliked ? "heart.fill" : "heart")
                                    .foregroundColor(post.isliked ? .red : .gray)
                                Text("\(post.likes)")
                                    .font(.caption)
                                
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(.inset)
                
                //Bottom Navigation Buttons
                HStack {
                    
                    NavigationLink(destination: CommunityView()) {
                        Image(systemName: "house.fill")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    NavigationLink(destination: ProfileView(posts: $posts)) {
                        Image(systemName: "person.fill")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }

                }
                
                .padding()
                .background(Color.gray.opacity(0.2))

                .navigationTitle("Community")
                .onAppear {
                    posts = StorageManager.loadPosts()
                }
                
                
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
    
    private func toggleLike(post: Binding<Post>) {
        if likedPostIDs.contains(post.wrappedValue.id) {
            post.likes.wrappedValue -= 1
            likedPostIDs.remove(post.wrappedValue.id)
        } else {
            post.likes.wrappedValue += 1
            likedPostIDs.insert(post.wrappedValue.id)
        }
        saveLikedPostIDs()
        StorageManager.savePosts(posts)
    }

    private func saveLikedPostIDs() {
        UserDefaults.standard.set(Array(likedPostIDs), forKey: "likedPostIDs")
    }
    

    
}

