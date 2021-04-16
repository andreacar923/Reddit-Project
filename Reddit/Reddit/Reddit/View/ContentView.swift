//
//  ContentView.swift
//  Reddit
//
//  Created by Andrea Caramagno on 10/04/21.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var datas: HomeViewModel = .init()
    @State var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    @State var searchedSubReddit: String = "australia"
    @State var selectedPost: Int = 0
    @State var isDetailed: Bool = false
    var body: some View
    {
        NavigationView
        {
            VStack(alignment: .center, spacing: 15)
            {
                SearchBar(text: $datas.search)
                
                if datas.listOfInfo.count == 0
                {
                    VStack(alignment: .center, spacing: 30)
                    {
                        Spacer()
                        
                        Image(systemName: "tray")
                            .font(.system(size: 48, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        Text("Empty subreddit")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                    }
                }
                else
                {
                    ScrollView(.vertical)
                    {
                        LazyVGrid(columns: columns, spacing: 10) //Griglia
                        {
                            ForEach(0..<datas.listOfInfo.count, id:\.self)
                            {
                                index in
                                PostCardView(cardModel: PostCardModel(datas.listOfInfo[index]))
                                    .onTapGesture
                                    {
                                        withAnimation(.easeInOut)
                                        {
                                            selectedPost = index
                                            isDetailed.toggle()
                                        }
                                    }
                            }
                            .id(UUID())
                        }
                    }
                }
                
                NavigationLink(
                    destination: DetailView(selectedImage: $selectedPost, posts: datas.listOfInfo),
                    isActive: $isDetailed)
                {
                    EmptyView()
                }
            }
            .onChange(of: datas.search, perform: { value in
                datas.url = "https://www.reddit.com/r/\(value)/top.json"
                datas.fetchData()
            })
            .onAppear(perform: datas.fetchData)
            .padding()
            
            .navigationBarTitle("Home", displayMode: .large)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
