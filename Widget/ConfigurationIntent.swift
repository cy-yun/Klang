//
//  AppIntent.swift
//  SoundWidget
//
//  Created by Leo Mehlig on 07.06.23.
//

import WidgetKit
import AppIntents
import Defaults

struct SoundsWidgetConfigIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Soundboard Widget Configration"
    static var description = IntentDescription("This is used to configure the widget.")

    @Parameter(title: "Sounds",
               description: "Pick the sounds for this widgets. If there is not enough room for all sounds, only the first will be displayed.",
               default: [])
    var sounds: [SoundEntity]

    @Parameter(title: "Full Blast Mode",
               description: "If enabled, the sound will set to full volumn before playing the sound. To protect your ears, this only happens when no headphones/speakers are connected (hopefully).",
               default: false)
    var isFullBlast: Bool

    @Parameter(title: "Overlay",
               description: "If enabled, sounds play on top of other audio instead of interrupting it. Music is turned down and podcasts are paused while a sound plays.",
               default: false)
    var isOverlay: Bool

    init(sounds: [SoundEntity] = SoundEntity.default, isFullBlast: Bool, isOverlay: Bool) {
        self.sounds = sounds
        self.isFullBlast = isFullBlast
        self.isOverlay = isOverlay
    }

    init() { 
        self.init(isFullBlast: false, isOverlay: false)
    }
}

struct BoardWidgetConfigIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Soundboard Widget Configration"
    static var description = IntentDescription("This is used to configure the widget.")

    @Parameter(title: "Board")
    var board: BoardEntity?

    @Parameter(title: "Full Blast Mode",
               description: "If enabled, the sound will set to full volumn before playing the sound. To protect your ears, this only happens when no headphones/speakers are connected (hopefully).",
               default: false)
    var isFullBlast: Bool

    @Parameter(title: "Overlay",
               description: "If enabled, sounds play on top of other audio instead of interrupting it. Music is turned down and podcasts are paused while a sound plays.",
               default: false)
    var isOverlay: Bool

    init(board: BoardEntity? = .default, isFullBlast: Bool, isOverlay: Bool) {
        self.board = board
        self.isFullBlast = isFullBlast
        self.isOverlay = isOverlay
    }

    init() { 
        self.init(isFullBlast: false, isOverlay: false)
    }
}

@available(iOS 18, *)
struct SingleSoundWidgetConfigIntent: ControlConfigurationIntent {
    static var title: LocalizedStringResource = "Soundboard Widget Configration"
    static var description = IntentDescription("This is used to configure the widget.")

    @Parameter(title: "Sound",
               description: "Pick the sound for this control.")
    var sound: SoundEntity?

    @Parameter(title: "Full Blast Mode",
               description: "If enabled, the sound will set to full volumn before playing the sound. To protect your ears, this only happens when no headphones/speakers are connected (hopefully).",
               default: false)
    var isFullBlast: Bool

    @Parameter(title: "Overlay",
               description: "If enabled, sounds play on top of other audio instead of interrupting it. Music is turned down and podcasts are paused while a sound plays.",
               default: false)
    var isOverlay: Bool

    init(sound: SoundEntity? = SoundEntity.default.first, isFullBlast: Bool, isOverlay: Bool) {
        self.sound = sound
        self.isFullBlast = isFullBlast
        self.isOverlay = isOverlay
    }

    init() {
        self.init(isFullBlast: false, isOverlay: false)
    }
}
