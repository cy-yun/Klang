//
//  SoundTests.swift
//  Tests
//

import AVFoundation
import XCTest
@testable import Klang

final class SoundTests: XCTestCase {

    private let url = URL(string: "file:///tmp/sound.mp3")!

    func testOverlayIsOffByDefault() {
        let sound = Sound(title: "Toy", symbol: "🪆", color: .red, url: url)

        XCTAssertFalse(sound.isOverlay)
    }

    func testOverlayIsPersisted() throws {
        let sound = Sound(title: "Toy", symbol: "🪆", color: .red, url: url, isOverlay: true)

        let decoded = try JSONDecoder().decode(Sound.self, from: JSONEncoder().encode(sound))

        XCTAssertEqual(decoded.id, sound.id)
        XCTAssertEqual(decoded.title, sound.title)
        XCTAssertEqual(decoded.symbol, sound.symbol)
        XCTAssertEqual(decoded.url, sound.url)
        XCTAssertTrue(decoded.isOverlay)
    }

    func testSoundsSavedWithoutOverlayStillDecode() throws {
        // Sounds persisted before the overlay option existed have no `isOverlay` key.
        let json = """
        {
            "id": "68397BC1-2866-4A27-A966-235BAFE73F44",
            "title": "Toy",
            "symbol": "🪆",
            "color": { "red": 1, "green": 0, "blue": 0 },
            "url": "file:///tmp/sound.mp3"
        }
        """

        let decoded = try JSONDecoder().decode(Sound.self, from: Data(json.utf8))

        XCTAssertEqual(decoded.id, UUID(uuidString: "68397BC1-2866-4A27-A966-235BAFE73F44")!)
        XCTAssertEqual(decoded.title, "Toy")
        XCTAssertEqual(decoded.symbol, "🪆")
        XCTAssertEqual(decoded.url, url)
        XCTAssertFalse(decoded.isOverlay)
    }

    func testSoundEntityCarriesOverlay() {
        let sound = Sound(title: "Toy", symbol: "🪆", color: .red, url: url, isOverlay: true)

        XCTAssertTrue(SoundEntity(sound: sound).isOverlay)
        XCTAssertFalse(SoundEntity(sound: sound.set(\.isOverlay, to: false)).isOverlay)
    }

    func testOverlaySoundsUseVoicePromptSession() {
        XCTAssertEqual(AudioPlayer.sessionMode(isOverlay: true), .voicePrompt)
        XCTAssertEqual(AudioPlayer.sessionOptions(isOverlay: true), [.duckOthers, .interruptSpokenAudioAndMixWithOthers])
    }

    func testRegularSoundsUseDefaultSession() {
        XCTAssertEqual(AudioPlayer.sessionMode(isOverlay: false), .default)
        XCTAssertEqual(AudioPlayer.sessionOptions(isOverlay: false), [])
    }
}
