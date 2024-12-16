//
//  StorageManager.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/16/24.
//

import Foundation

struct StorageManager {
    static func loadPosts() -> [Post] {
        let fileURL = getDocumentsDirectory().appendingPathComponent("posts.json")

        guard let data = try? Data(contentsOf: fileURL) else {
            print("No posts found, returning an empty list.")
            return []
        }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([Post].self, from: data)
        } catch {
            print("Error decoding posts: \(error)")
            return []
        }
    }

    static func savePosts(_ posts: [Post]) {
        let fileURL = getDocumentsDirectory().appendingPathComponent("posts.json")
        print(fileURL)

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(posts)
            try data.write(to: fileURL)
        } catch {
            print("Error saving posts: \(error)")
        }
    }
    
    
    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

}
