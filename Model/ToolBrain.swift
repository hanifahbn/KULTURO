//
//  ToolsBrain.swift
//  MacroApp
//
//  Created by Auliya Michelle Adhana on 26/10/23.
//

import Foundation

struct ToolBrain {

    let tools = [
        Tool(i: "Broom", o: "notebook, notebook computer"),
        Tool(i: "Bucket", o: "bucket, pail"),
//        Tool(i: "clock", o: "analog clock"),
//        Tool(i: "dustbin", o: "ashcan, trash can, garbage can, wastebin, ash bin, ash-bin, ashbin, dustbin, trash barrel, trash bin"),
//        Tool(i: "doormat", o: "doormat, welcome mat")
    ]

    func getRandomTool() -> Tool {
        let result = tools.randomElement()!

       return result
   }

    func getFirstTool() -> Tool {
        return tools[0]
    }


}

