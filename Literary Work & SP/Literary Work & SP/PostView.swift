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
    @State private var likedPostIDs: Set<UUID> = Set()

    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            //Post title
            Text(post.title)
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding()
            
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
                    toggleLike(for: post)
                }) {
                    HStack {
                        Image(systemName: isLiked(post: post) ? "heart.fill" : "heart")
                            .foregroundColor(isLiked(post: post) ? .red : .gray)
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
//                            print("post after adding comment: \(post)")
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
            posts[index] = post
            StorageManager.savePosts(posts)
        }
    }
    
    private func savePostToJSON(_ post: Post) {
        var posts = StorageManager.loadPosts()
        posts.append(post)
        StorageManager.savePosts(posts)
    }
    
    private func toggleLike(for post: Post) {
        var likedPostIDs = getLikedPostIDs()
    
        if isLiked(post: post) {
            self.post.likes -= 1
            self.post.isliked = false
            likedPostIDs.remove(post.id)
        } else {
            self.post.likes += 1
            self.post.isliked = true
            likedPostIDs.insert(post.id)
            
        }
        
        saveLikedPostIDs(postIDs: likedPostIDs)

        updatePostInJSON()
        
        print("likedPostIDs: \(likedPostIDs)")
    }
    
    private func getLikedPostIDs() -> Set<UUID> {
        guard let loggedinUser = userManager.currentUser else {
            return Set()
        }
        
        if let likePostIDsArray = UserDefaults.standard.array(forKey: "likedPostIDs_\(loggedinUser)") as? [String] {
            return Set(likePostIDsArray.compactMap {UUID(uuidString: $0) })
        }
        return Set()
    }

    private func saveLikedPostIDs(postIDs: Set<UUID>) {
        guard let loggedinUser = userManager.currentUser else {
            return
        }
        let likedPostIDsArray = postIDs.map {$0.uuidString}

        UserDefaults.standard.set(likedPostIDsArray, forKey: "likedPostIDs_\(loggedinUser)")
    }
    
    func isLiked(post: Post) -> Bool {
        let likedPostIDs = getLikedPostIDs()

        return likedPostIDs.contains(post.id)
    }
    

}



