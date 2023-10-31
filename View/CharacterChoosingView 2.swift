//
//  CharacterChoosingView.swift
//  MacroApp
//
//  Created by Hanifah BN on 24/10/23.
//

import SwiftUI

struct CharacterChoosingView: View {
    @EnvironmentObject var matchManager : MatchManager
    
    var body: some View {
        NavigationView {
            List(matchManager.characters) { character in
               Button(action: {
                   matchManager.chooseCharacter(character)
               }) {
                   HStack {
                       Image(character.headImage)
                           .resizable()
                           .frame(width: 60, height: 60)
                           .cornerRadius(30)
                       VStack(alignment: .leading) {
                           Text(character.name)
                               .font(.headline)
                           Text(character.origin)
                               .font(.subheadline)
                       }
                   }
               }
               .disabled(character.isChosen)
           }
           .navigationBarTitle("Choose a Character")
        }
        }
}

struct CharacterDetail: View {
    let character: Character

    var body: some View {
        VStack {
            Image(character.headImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(character.name)
                .font(.title)
            Text("Origin: \(character.origin)")
                .font(.subheadline)
        }
        .padding()
    }
}

#Preview {
    CharacterChoosingView()
        .environmentObject(MatchManager())
}
