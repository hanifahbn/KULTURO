//
//  ToolsBrain.swift
//  MacroApp
//
//  Created by Auliya Michelle Adhana on 26/10/23.
//

import Foundation

struct ToolBrain {

    var tools = [
        Tool(i: "Broom", o: "broom"),
        Tool(i: "Bucket", o: "bucket, pail"),
        Tool(i: "Clock", o: "analog clock"),
        Tool(i: "Dustbin", o: "ashcan, trash can, garbage can, wastebin, ash bin, ash-bin, ashbin, dustbin, trash barrel, trash bin"),
        Tool(i: "Doormat", o: "doormat, welcome mat")
    ]

    func getRandomTool(_ tool : Tool) -> Tool {
        var randomTool: Tool = getFirstTool()

        repeat {
            let shuffledTools = tools.shuffled()
            randomTool = shuffledTools[0]
        } while randomTool == tool

        return randomTool
   }

    func getFirstTool() -> Tool {
        return tools[0]
    }


}

