//
//  TakeJSON.swift
//  Reddit
//
//  Created by Andrea Caramagno on 10/04/21.
//

import Foundation

//Modello della Content View

class HomeViewModel: ObservableObject
{
    @Published var search: String = "australia" //Parola chiave per ricerca
    @Published var url: String = "https://www.reddit.com/r/australia/top.json" //URL dove inserire la parola chiave
    @Published var json : Welcome? //JSON ritornato dalla richiesta
    @Published var listOfInfo : [Post] = [] //Post nel subreddit
    
    
    func fetchData()
    {
        self.json = nil
        self.url = "https://www.reddit.com/r/\(search)/top.json"
        self.listOfInfo.removeAll() //Rimuovo ad ogni chiamata per evitare dati residui
        
        //Codice per prendere le informazioni nei json del subreddit cercato dall'utente
        if let url = URL(string: url)
        {
            URLSession.shared.dataTask(with: url)
            {
                data, response, error in
                
                    guard let response = response as? HTTPURLResponse else { return }
                
                    if response.statusCode == 200
                    {
                        if let data = data
                        {
                            DispatchQueue.main.async
                            {
                                do
                                {
                                    //Decoder tramite classi create da me
                                    self.json = try JSONDecoder().decode(Welcome.self, from: data)
                                    
                                    for index in 0..<(self.json?.data.children.count)!
                                    {
                                        self.listOfInfo.append((self.json?.data.children[index].data)!)
                                    }
                                }
                                catch let error
                                {
                                    print(error)
                                }
                            }
                        }
                    }
                
            }.resume()
        }
    }
}


