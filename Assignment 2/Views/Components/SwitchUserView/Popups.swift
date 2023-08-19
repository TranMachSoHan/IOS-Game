//
//  Popups.swift
//  Assignment 2
//
//  Created by macOS on 19/08/2023.
//

import SwiftUI

struct SignInUpView: View {
    @State var popUpTypeString: String = "Sign Up"
    @Binding var name: String
    @Binding var pass: String
    var error: String = ""
    var onClose: () -> ()

    var body: some View {
        VStack(spacing: 12) {
            Text(popUpTypeString)
                .foregroundColor(.black)
                .font(.system(size: 24))
                .padding(.top, 12)
            
            if (popUpTypeString == "Sign Up"){
                TextField("Name",
                          text: $name,
                          prompt: Text("Name").foregroundColor(.blue))
                    .limitInputLength(value: $name, length: 10)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    }
                    .padding(.horizontal)
            }
            else {
                HStack{
                    Text("Player Name: ")
                    Text("\(self.name)")
                    Spacer()
                }
                .padding(10)
                .padding(.horizontal)
            }
            
            
            TextField("Password",
                      text: $pass,
                      prompt: Text("Password").foregroundColor(.blue))
                .limitInputLength(value: $pass, length: 6)
                .keyboardType(.decimalPad)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
            
            if (error != ""){
                Text(error)
                    .foregroundColor(.red)
            }
            
            Button("Confirm") {
                onClose()
            }
            .buttonStyle(.plain)
            .font(.system(size: 18, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal, 10)
            .foregroundColor(.white)
            .background(Color.brown)
            .cornerRadius(12)
        }
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
        .background(Color.white.cornerRadius(20))
    }
}

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
