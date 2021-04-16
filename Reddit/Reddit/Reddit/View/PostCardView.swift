//
//  PostCardView.swift
//  Reddit
//
//  Created by Andrea Caramagno on 12/04/21.
//

import SwiftUI

struct PostCardView: View
{
    @ObservedObject var cardModel: PostCardModel
    var body: some View
    {
        VStack(alignment: .leading)
        {
            
                AsyncImage(url: URL(string: cardModel.thumbnail) ?? URL(string: "https://www.ilcittadinoonline.it/wp-content/uploads/2019/09/reddit-alien-red-st-e1568284246812.jpg")! , placeholder: {
                    //Se il post è vuoto
                    HStack
                    {
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 20)
                        {
                            Spacer()
                            
                            Image(systemName: "tray")
                                .font(.system(size: 36, weight: .semibold))
                                .foregroundColor(.secondary)
                            
                            Text("Empty")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                })
                
            
            VStack(alignment: .leading, spacing: 5)
            {
                Text(cardModel.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(3)
                    
                Text(cardModel.author)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
            }
            .padding(10)
                
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20)
    }
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        PostCardView(cardModel: .init(Post(title: "Test", author: "Andrea Caramagno", thumbnail: "self", ups: 12, num_comments: 234)))
    }
}
