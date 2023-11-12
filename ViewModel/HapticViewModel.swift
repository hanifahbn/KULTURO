//
//  HapticViewModel.swift
//  MacroApp
//
//  Created by Auliya Michelle Adhana on 09/11/23.
//

import CoreHaptics
import SwiftUI

class HapticViewModel: ObservableObject {

    private var engine: CHHapticEngine?
    var notificationGenerator = UINotificationFeedbackGenerator()

    init() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Error starting haptic engine: \(error)")
        }
    }

    func simpleSuccess() {
        notificationGenerator.notificationOccurred(.success)
    }

    func simpleError() {
        notificationGenerator.notificationOccurred(.error)
    }


    func complexSuccess() {
        guard let engine = engine else { return }

        var events = [CHHapticEvent]()

        for i in stride(from: 0, to: 1, by: 0.1){
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        // Long buzz biar deg deg an
        let surpriseIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
        let surpriseSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        let surpriseEvent = CHHapticEvent(eventType: .hapticContinuous, parameters: [surpriseIntensity, surpriseSharpness], relativeTime: 0, duration: 1.0)
        events.append(surpriseEvent)


        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Error playing haptic pattern: \(error)")
        }
    }



    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        do{
            engine = try CHHapticEngine()
            try engine?.start()
        } catch{
            print("Error creating haptic engine: \(error)")
        }
    }

}

