//
//  File.swift
//  Reddit
//
//  Created by Andrea Caramagno on 12/04/21.
//

import Foundation
import Combine

//Modello della post card view
class PostCardModel: ObservableObject
{
    @Published var title: String = ""
    @Published var author: String = ""
    @Published var thumbnail: String = ""
    
    init(_ post: Post)
    {
        self.title = post.title
        self.author = post.author
        self.thumbnail = post.thumbnail
    }
}
