//
//  AsyncImage.swift
//  Reddit
//
//  Created by Andrea Caramagno on 12/04/21.
//
import Combine
import UIKit
import SwiftUI
import Foundation

//Estensioni per permettere caricamento asincrono dell'immagine
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancel()
    }
    
    private var cancellable: AnyCancellable?

       func load() {
           cancellable = URLSession.shared.dataTaskPublisher(for: url)
               .map { UIImage(data: $0.data) }
               .replaceError(with: nil)
               .receive(on: DispatchQueue.main)
               .sink { [weak self] in self?.image = $0 }
       }
       
       func cancel() {
           cancellable?.cancel()
       }
}

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder

    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    @State var scale : CGFloat = 1
    @State var lastScaleValue : CGFloat = 1.0

    private var content: some View {
            Group {
                if loader.image != nil {
                    Image(uiImage: loader.image!)
                        .resizable()
                        .scaleEffect(self.lastScaleValue)
                        .aspectRatio(contentMode:.fit)
                        .gesture(MagnificationGesture().onChanged { val in
                                    let delta = val / self.lastScaleValue
                                    self.lastScaleValue = val

                        //... anything else e.g. clamping the newScale
                        }.onEnded { val in
                          // without this the next gesture will be broken
                          self.lastScaleValue = 1.0
                        })
                    
                } else {
                    placeholder
                }
            }
        }
}
