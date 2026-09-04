//
//  Intent.swift
//  WidgetSoundboard
//
//  Created by Leo Mehlig on 07.06.23.
//

import AppIntents
import AVFoundation
import AudioToolbox
import WidgetKit
import MediaPlayer
import SwiftUI
import Defaults

struct SoundIntent: AudioPlaybackIntent {
    static var title: LocalizedStringResource = "Play Sound"
    
    static var description = IntentDescription("Plays a sound")
    
    @Parameter(title: "Sound")
    var sound: SoundEntity?

    @Parameter(title: "Full Blast Mode")
    var isFullBlast: Bool

    @Parameter(title: "Overlay",
               description: "If enabled, the sound plays on top of other audio instead of interrupting it. Music is turned down and podcasts are paused while it plays.",
               default: false)
    var isOverlay: Bool
    
    init(sound: SoundEntity?, isFullBlast: Bool, isOverlay: Bool) {
        self.sound = sound
        self.isFullBlast = isFullBlast
        self.isOverlay = isOverlay
    }
    
    init() {
    }
    
    func perform() async throws -> some IntentResult {
        return try await IntentRunner.perform(intent: self)
    }
}
