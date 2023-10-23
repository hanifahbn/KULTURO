//
//  StoryModel.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 21/10/23.
//

import Foundation

struct NaratorStoriesModel : Identifiable{
    var id = UUID()
    var stories: String
}

struct DesaStoriesModel: Identifiable{
    var id = UUID()
    var stories: String
    var characterOne : String
    var characterTwo : String
}

struct BeliStoriesModel: Identifiable{
    var id = UUID()
    var stories: String
    var characterOne : String
    var characterTwo : String
    var inMissionOne : Bool
    
}
