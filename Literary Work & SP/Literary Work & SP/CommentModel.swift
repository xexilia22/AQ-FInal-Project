//
//  CommentModel.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/15/24.
//

import Foundation

struct Comment: Identifiable, Codable, Hashable {
    let id: UUID
    var author: String
    var content: String
    var creationTime: Date
    
    init(author: String, content: String, creationTime: Date) {
        self.id = UUID()
        self.author = author
        self.content = content
        self.creationTime = creationTime
    }
}


