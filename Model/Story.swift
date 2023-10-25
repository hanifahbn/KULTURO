//
//  StoryModel.swift
//  MacroApp
//
//  Created by Irvan P. Saragi on 21/10/23.
//

import Foundation

struct NaratorStories : Identifiable{
    var id = UUID()
    var stories: String
}

struct DesaStories: Identifiable{
    var id = UUID()
    var stories: String
    var characterOne : String
    var characterTwo : String
}

struct BeliStories: Identifiable{
    var id = UUID()
    var stories: String
    var characterOne : String
    var characterTwo : String
    var inMissionOne : Bool
    
}

struct GudangStorie: Identifiable{
    var id = UUID()
    var stories: String
    var characterOne : String
    var characterTwo : String
    var transisiStories : Bool
}

struct BantuDesaStories: Identifiable{
    var id = UUID()
    var stories: String
    var characterOne : String
    var characterTwo : String
    var transisiStories : Bool
}

struct PasirStories: Identifiable{
    var id = UUID()
    var stories: String
    var characterOne : String
    var transisiStories : Bool
}

struct EndStories: Identifiable{
    var id = UUID()
    var stories: String
    var characterOne : String
    var transisiStories : Bool
}
