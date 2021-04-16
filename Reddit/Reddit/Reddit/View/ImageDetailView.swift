//
//  ImageDetailView.swift
//  Reddit
//
//  Created by Andrea Caramagno on 13/04/21.
//

import SwiftUI

struct ImageDetailView: View
{
    @Environment(\.colorScheme) var colorScheme
    @State var post: Post
    @State var isPresentedBigImage: Bool = false
    @State var imageSelected: String = ""
    @Namespace var hero
    var body: some View
    {
        ZStack
        {
            if isPresentedBigImage
            {
                //Immagine a tutto schermo
                VStack
                {
                    HStack
                    {
                        Button(action: {withAnimation(.spring()){isPresentedBigImage.toggle()}})
                        {
                            Image(systemName: "xmark")
                                .foregroundColor(Color(.systemBackground))
                                .padding()
                                .background(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5))
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    AsyncImage(url: URL(string: post.thumbnail) ?? URL(string: "https://www.ilcittadinoonline.it/wp-content/uploads/2019/09/reddit-alien-red-st-e1568284246812.jpg")! , placeholder: {
                                    HStack
                                    {
                                        Spacer()
                                        
                                        VStack(alignment: .center, spacing: 20)
                                        {
                                            Spacer()
                                            
                                            Image(systemName: "tray")
                                                .font(.system(size: 48, weight: .semibold))
                                                .foregroundColor(.secondary)
                                            
                                            Text("Empty")
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            
                                            Spacer()
                                        }
                                        
                                        Spacer()
                                    }
                        }
                    )
                    .cornerRadius(10)
                    .matchedGeometryEffect(id: "image", in: hero)
                    
                    Spacer()
                }
            }
            else
            {
                //Immagine con informazioni contenenti nel JSON
                VStack(alignment: .leading)
                {
                    AsyncImage(url: URL(string: post.thumbnail) ?? URL(string: "https://www.ilcittadinoonline.it/wp-content/uploads/2019/09/reddit-alien-red-st-e1568284246812.jpg")! , placeholder: {
                            HStack
                            {
                                            Spacer()
                                            
                                            VStack(alignment: .center, spacing: 20)
                                            {
                                                Spacer()
                                                
                                                Image(systemName: "tray")
                                                    .font(.system(size: 48, weight: .semibold))
                                                    .foregroundColor(.secondary)
                                                
                                                Text("Empty")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.secondary)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                        }
                        }
                    )
                    .cornerRadius(10)
                    .onTapGesture
                    {
                        withAnimation(.spring())
                        {
                            isPresentedBigImage.toggle()
                        }
                    }
                    .matchedGeometryEffect(id: "image", in: hero)
                    
                    VStack(alignment: .leading, spacing: 10)
                    {
                        Text(post.author)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                        
                        ScrollView(.vertical)
                        {
                            Text(post.title)
                                .font(.title)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack
                    {
                        HStack
                        {
                            Text("\(post.ups)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            
                            Image(systemName: "arrow.up")
                                .foregroundColor(.blue)
                                .font(.system(size: 24, weight: .bold))
                        }
                        
                        Spacer()
                        
                        HStack
                        {
                            Text("\(post.num_comments)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            
                            Image(systemName: "bubble.right.fill")
                                .foregroundColor(.secondary)
                                .font(.system(size: 24, weight: .bold))
                        }
                    
                    }
                    .padding()
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(20)
            }
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(post: .init(title: "Test", author: "Andrea", thumbnail: "https://www.ilcittadinoonline.it/wp-content/uploads/2019/09/reddit-alien-red-st-e1568284246812.jpg", ups: 12, num_comments: 345))
    }
}
