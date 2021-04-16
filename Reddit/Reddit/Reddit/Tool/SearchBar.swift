//
//  SearchBar.swift
//  Reddit
//
//  Created by Andrea Caramagno on 13/04/21.
//

import Foundation
import Combine
import SwiftUI

struct SearchBar: View
{
    @Binding var text: String
    @State private var isEditing = false

    var body: some View
    {
        HStack
        {
            TextField("Search by name...", text: $text)
                .padding(7)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .onTapGesture
                {
                    self.isEditing = true
                }

            if isEditing
            {
                Button(action: {
                    self.isEditing = false
                    self.text = ""

                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
            Spacer()
        }
    }
}
