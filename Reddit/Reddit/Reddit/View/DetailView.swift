//
//  DetailView.swift
//  Reddit
//
//  Created by Andrea Caramagno on 13/04/21.
//

import SwiftUI

struct DetailView: View
{
    @Binding var selectedImage: Int
    @State var posts: [Post]
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            ScrollViewReader //Reader della scroll view per andare all'immagine selezionata in precedenza
            {
                reader in
                    ScrollView(.horizontal)
                    {
                        HStack
                        {
                            ForEach(0..<posts.count)
                            {
                                index in
                                    ImageDetailView(post: posts[index])
                                        .id(index) //ID per raggiungere ogni immagine
                            }
                            .frame(width: UIScreen.main.bounds.width - 20)
                        }
                        .padding()
                    }
                    .onAppear(perform: {
                        reader.scrollTo(selectedImage)
                    })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedImage: .constant(0), posts: [])
    }
}
