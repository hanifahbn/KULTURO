//
//  NavigationViewModel.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 26/10/23.
//


import Foundation
import SwiftUI

enum Destination {
    case ingame
    case narator
    case desaStories
    case beliStories
    case missionOne
    case gudangStories
    case cameraGame
    case bantuDesa
    case dragGame
    case pasirStories
    case ayakPasirGame
    case endStories
}

class Router: ObservableObject {
    @Published var path : [Destination] = []
    
    func popToRoot(){
        path.removeLast(path.count)
    }
    
    func popToPage(page: Destination){
        if let index = path.firstIndex(of: page){
            path.removeLast(path.count - (index + 1))
        } else {
            print("Value not found in the array")
        }
    }
}

class ViewFactory {
    @ViewBuilder
    static func viewForDestination(_ destination: Destination) -> some View {
        switch destination {
        case.ingame:
            InGameView()
        case.narator:
            StoryNaratorView(viewModel: StoryViewModel())
        case.desaStories:
            DesaStoriesView(viewModel: StoryViewModel())
        case.beliStories:
            BeliStoriesView(viewModel: StoryViewModel(), matchManager: MatchManager())
        case.missionOne:
            MissionOneView()
        case.gudangStories:
            GudangStoriesView(viewModel: StoryViewModel())
        case.cameraGame:
            CameraView()
        case.bantuDesa:
            BantuDesaView(viewModel: StoryViewModel())
        case.dragGame:
            DragDropView()
        case.pasirStories:
            PasirStoriesView(viewModel: StoryViewModel())
        case.ayakPasirGame:
            AyakPasirView()
        case.endStories:
            EndStoriesView(viewModel: StoryViewModel())
        }
    }
}
