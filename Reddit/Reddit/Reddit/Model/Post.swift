//
//  Subreddit.swift
//  Reddit
//
//  Created by Andrea Caramagno on 11/04/21.
//

import Foundation

struct Post: Codable
{
    var title: String
    var author: String
    var thumbnail: String
    var ups: Int
    var num_comments: Int
    
    enum CodingKeys: String, CodingKey
    {
        case title = "title"
        case author = "author"
        case thumbnail = "thumbnail"
        case ups = "ups"
        case num_comments = "num_comments"
    }
}



// MARK: - Welcome
struct Welcome: Codable {
    var kind: String
    var data: WelcomeData
}

// MARK: - WelcomeData
struct WelcomeData: Codable {
    var modhash: String
    var dist: Int
    var children: [Child]
   
    enum CodingKeys: String, CodingKey
    {
        case modhash = "modhash"
        case dist = "dist"
        case children = "children"
    }
}

// MARK: - Child
struct Child: Codable {
    let kind: String
    let data: Post
}
