//
//  PostModel.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/15/24.
//

import Foundation

struct Post: Identifiable, Codable, Hashable {
    let id: UUID
    var author: String
    var content: String
    var likes: Int
    var isliked: Bool
    var comments: [Comment]
    var creationTime: Date
    
    init(author: String, content: String, likes: Int = 0, isliked: Bool = false, comments: [Comment], CreationTime: Date = Date()) {
        self.id = UUID()
        self.author = author
        self.content = content
        self.likes = likes
        self.isliked = isliked
        self.creationTime = CreationTime
        self.comments = comments
    }
}
