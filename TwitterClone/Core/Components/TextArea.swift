//
//  TextArea.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 18.01.23.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    
    init (_ placeholder: String, text: Binding<String>)
    {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    var body: some View {
        ZStack(alignment: .top)
        {
            TextField(placeholder, text: $text)
                .padding(4)
        }
        .font(.body)
        
    }
}

struct TextArea_Previews: PreviewProvider {
    static var previews: some View{
        TextArea("some", text: .constant("OKAY HERE WE GO"))
    }
}

