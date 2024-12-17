//
//  ProfileView.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/16/24.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @Binding var posts: [Post]
    @State private var username = UserDefaults.standard.string(forKey: "currentUser") ?? "Unknown User"
    @State private var likedPostIDs: Set<UUID> = Set(UserDefaults.standard.array(forKey: "likedPostIDs") as? [UUID] ?? [])
    @State private var profileImage: String = "person.circle"
    @State private var likedPosts: [Post] = []
    @State private var myPosts: [Post] = []
    @State private var isNavigatingToPost: Bool = false
    @State private var selectedPost: Post?
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: profileImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .padding()
                    
                    Text(username)
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .padding()
                
                Divider()
                
                // Liked Post Section
                VStack(alignment: .leading) {
                    Text("Liked Posts")
                        .font(.headline)
                        .padding(.top)
                    List($likedPosts) { $post in
                        NavigationLink(destination: PostView(post: $post)) {
                            VStack(alignment: .leading) {
                                Text(post.title)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 2)
                                HStack {
                                    Text("Author: \(post.author)")
                                    font(.subheadline)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text(post.creationTime, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Text(post.content)
                                    .font(.body)
                                    .padding(.vertical, 4)
                                
                            }
                            
                        }
                        
                        
                    }.listStyle(.inset)
                    
                    
                    Divider()
                        .padding(.vertical)
                    
                    VStack(alignment: .leading) {
                        Text("My Posts")
                            .font(.headline)
                            .padding(.top)

                        List($myPosts, id: \.id) { $post in
                            NavigationLink(destination: EditPostView(post: $myPosts[myPosts.firstIndex(where: {$0.id == post.id})!])) {
                                VStack(alignment: .leading) {
                                    Text(post.title)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                        .padding(.bottom, 2)
                                    
                                    Text(post.content)
                                        .font(.body)
                                        .padding(.vertical, 4)
                                }
                                
                            }
                            
                                                                    
                        }
                        .listStyle(.inset)

                    }
                    
                }
                .navigationTitle("Profile")
                .onAppear {
                    myPosts = loadMyPosts()
                    likedPosts = loadLikedPosts()
                }
                .padding()
                
            }
            
        }
    }

    
    func deletePost(post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts.remove(at: index)
            StorageManager.savePosts(posts)
        }
    }
    
    func getLikedPostIDs() -> Set<UUID> {
        let key = "likedPostIDs_\(username)"
        if let likedPostIDsArray = UserDefaults.standard.array(forKey: key) as? [String] {
            return Set(likedPostIDsArray.compactMap { UUID(uuidString: $0) })
        }
        return Set()
    }
    
    func loadLikedPosts() -> [Post] {
        let likedPostIDs = getLikedPostIDs()
        let allPosts = StorageManager.loadPosts()
        return allPosts.filter { likedPostIDs.contains($0.id) }
    }
    
    func loadMyPosts() -> [Post] {
        let allPosts = StorageManager.loadPosts()
         return allPosts.filter { $0.author == username }
    }
    
}



