//
//  ToolsBrain.swift
//  MacroApp
//
//  Created by Auliya Michelle Adhana on 26/10/23.
//

import Foundation

struct ToolBrain {

    var tools = [
        Tool(i: "Jam Analog", o: "analog clock"),
        Tool(i: "Sapu", o: "broom"),
        Tool(i: "Ember", o: "bucket, pail"),
        Tool(i: "Keset", o: "doormat, welcome mat")
    ]

    func getRandomTool(_ tool : Tool?) -> Tool {
        var randomTool: Tool? = nil

        repeat {
            let shuffledTools = tools.shuffled()
            randomTool = shuffledTools[0]
        } while randomTool == tool

        return randomTool ?? tools[0]
   }


}

