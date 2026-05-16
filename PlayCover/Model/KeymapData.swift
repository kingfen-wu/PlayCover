//
//  Keymapping.swift
//  PlayCover
//
//  Created by Isaac Marovitz on 23/08/2022.
//

import Foundation

struct KeyModelTransform: Codable {
    var size: CGFloat
    var xCoord: CGFloat
    var yCoord: CGFloat
}

struct ButtonModel: Codable {
    var keyCode: Int
    var keyName: String
    var modifierKeyCode: Int?
    var modifierKeyName: String?
    var holdDuration: CGFloat?
    var transform: KeyModelTransform

    init(keyCode: Int,
         keyName: String,
         modifierKeyCode: Int? = nil,
         modifierKeyName: String? = nil,
         holdDuration: CGFloat? = nil,
         transform: KeyModelTransform) {
        self.keyCode = keyCode
        self.keyName = keyName.isEmpty ? KeyCodeNames.keyCodes[keyCode] ?? "Btn" : keyName
        self.modifierKeyCode = modifierKeyCode
        self.modifierKeyName = modifierKeyName
        self.holdDuration = holdDuration
        self.transform = transform
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(keyCode: try container.decode(Int.self, forKey: .keyCode),
                  keyName: try container.decodeIfPresent(String.self, forKey: .keyName) ?? "",
                  modifierKeyCode: try container.decodeIfPresent(Int.self, forKey: .modifierKeyCode),
                  modifierKeyName: try container.decodeIfPresent(String.self, forKey: .modifierKeyName),
                  holdDuration: try container.decodeIfPresent(CGFloat.self, forKey: .holdDuration),
                  transform: try container.decode(KeyModelTransform.self, forKey: .transform))
    }
}

enum JoystickMode: Int, Codable {
    case FIXED
    case FLOATING
}

struct JoystickModel: Codable {
    var upKeyCode: Int
    var rightKeyCode: Int
    var downKeyCode: Int
    var leftKeyCode: Int
    var keyName: String
    var transform: KeyModelTransform
    var mode: JoystickMode

    init(upKeyCode: Int,
         rightKeyCode: Int,
         downKeyCode: Int,
         leftKeyCode: Int,
         keyName: String,
         transform: KeyModelTransform,
         mode: JoystickMode) {
        self.upKeyCode = upKeyCode
        self.rightKeyCode = rightKeyCode
        self.downKeyCode = downKeyCode
        self.leftKeyCode = leftKeyCode
        self.keyName = keyName
        self.transform = transform
        self.mode = mode
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(upKeyCode: try container.decode(Int.self, forKey: .upKeyCode),
                  rightKeyCode: try container.decode(Int.self, forKey: .rightKeyCode),
                  downKeyCode: try container.decode(Int.self, forKey: .downKeyCode),
                  leftKeyCode: try container.decode(Int.self, forKey: .leftKeyCode),
                  keyName: try container.decodeIfPresent(String.self, forKey: .keyName) ?? "Keyboard",
                  transform: try container.decode(KeyModelTransform.self, forKey: .transform),
                  mode: try container.decodeIfPresent(JoystickMode.self, forKey: .mode) ?? .FIXED)
    }
}

struct MouseAreaModel: Codable {
    var keyName: String
    var transform: KeyModelTransform

    init(keyName: String, transform: KeyModelTransform) {
        self.keyName = keyName
        self.transform = transform
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(keyName: try container.decodeIfPresent(String.self, forKey: .keyName) ?? "Mouse",
                  transform: try container.decode(KeyModelTransform.self, forKey: .transform))
    }
}

struct SwipeModel: Codable {
    var keyCode: Int
    var keyName: String
    var modifierKeyCode: Int?
    var modifierKeyName: String?
    var holdDuration: CGFloat?
    var transform: KeyModelTransform
    var angle: CGFloat

    init(keyCode: Int,
         keyName: String,
         modifierKeyCode: Int? = nil,
         modifierKeyName: String? = nil,
         holdDuration: CGFloat? = nil,
         transform: KeyModelTransform,
         angle: CGFloat) {
        self.keyCode = keyCode
        self.keyName = keyName.isEmpty ? KeyCodeNames.keyCodes[keyCode] ?? "Btn" : keyName
        self.modifierKeyCode = modifierKeyCode
        self.modifierKeyName = modifierKeyName
        self.holdDuration = holdDuration
        self.transform = transform
        self.angle = angle
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(keyCode: try container.decode(Int.self, forKey: .keyCode),
                  keyName: try container.decodeIfPresent(String.self, forKey: .keyName) ?? "",
                  modifierKeyCode: try container.decodeIfPresent(Int.self, forKey: .modifierKeyCode),
                  modifierKeyName: try container.decodeIfPresent(String.self, forKey: .modifierKeyName),
                  holdDuration: try container.decodeIfPresent(CGFloat.self, forKey: .holdDuration),
                  transform: try container.decode(KeyModelTransform.self, forKey: .transform),
                  angle: try container.decodeIfPresent(CGFloat.self, forKey: .angle) ?? CGFloat.pi * 3 / 2)
    }
}

struct RadialSelectorSlotModel: Codable {
    var angle: CGFloat
    var target: KeyModelTransform
    var title: String?
    var enabled: Bool

    init(angle: CGFloat, target: KeyModelTransform, title: String? = nil, enabled: Bool = true) {
        self.angle = angle
        self.target = target
        self.title = title
        self.enabled = enabled
    }
}

struct RadialSelectorModel: Codable {
    var keyCode: Int
    var keyName: String
    var modifierKeyCode: Int?
    var modifierKeyName: String?
    var holdDuration: CGFloat?
    var transform: KeyModelTransform
    var activationThreshold: CGFloat?
    var slots: [RadialSelectorSlotModel]

    init(keyCode: Int,
         keyName: String,
         modifierKeyCode: Int? = nil,
         modifierKeyName: String? = nil,
         holdDuration: CGFloat? = nil,
         transform: KeyModelTransform,
         activationThreshold: CGFloat? = nil,
         slots: [RadialSelectorSlotModel]) {
        self.keyCode = keyCode
        self.keyName = keyName
        self.modifierKeyCode = modifierKeyCode
        self.modifierKeyName = modifierKeyName
        self.holdDuration = holdDuration
        self.transform = transform
        self.activationThreshold = activationThreshold
        self.slots = slots
    }
}

struct Keymap: Codable {
    var buttonModels: [ButtonModel] = []
    var draggableButtonModels: [ButtonModel] = []
    var joystickModel: [JoystickModel] = []
    var mouseAreaModel: [MouseAreaModel] = []
    var swipeModels: [SwipeModel] = []
    var radialSelectorModels: [RadialSelectorModel] = []
    var hudOpacity: CGFloat?
    var bundleIdentifier: String
    var version = "2.0.0"

    init(buttonModels: [ButtonModel] = [],
         draggableButtonModels: [ButtonModel] = [],
         joystickModel: [JoystickModel] = [],
         mouseAreaModel: [MouseAreaModel] = [],
         swipeModels: [SwipeModel] = [],
         radialSelectorModels: [RadialSelectorModel] = [],
         hudOpacity: CGFloat? = nil,
         bundleIdentifier: String,
         version: String = "2.0.0") {
        self.buttonModels = buttonModels
        self.draggableButtonModels = draggableButtonModels
        self.joystickModel = joystickModel
        self.mouseAreaModel = mouseAreaModel
        self.swipeModels = swipeModels
        self.radialSelectorModels = radialSelectorModels
        self.hudOpacity = hudOpacity
        self.bundleIdentifier = bundleIdentifier
        self.version = version
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            buttonModels: try container.decodeIfPresent([ButtonModel].self, forKey: .buttonModels) ?? [],
            draggableButtonModels: try container.decodeIfPresent([ButtonModel].self, forKey: .draggableButtonModels) ?? [],
            joystickModel: try container.decodeIfPresent([JoystickModel].self, forKey: .joystickModel) ?? [],
            mouseAreaModel: try container.decodeIfPresent([MouseAreaModel].self, forKey: .mouseAreaModel) ?? [],
            swipeModels: try container.decodeIfPresent([SwipeModel].self, forKey: .swipeModels) ?? [],
            radialSelectorModels: try container.decodeIfPresent([RadialSelectorModel].self, forKey: .radialSelectorModels) ?? [],
            hudOpacity: try container.decodeIfPresent(CGFloat.self, forKey: .hudOpacity),
            bundleIdentifier: try container.decode(String.self, forKey: .bundleIdentifier),
            version: try container.decodeIfPresent(String.self, forKey: .version) ?? "2.0.0"
        )
    }
}

struct KeymapConfig: Codable {
    var defaultKm: URL
    var keymapOrder: [URL]

    init(defaultKm: URL, keymapOrder: [URL]) {
        self.defaultKm = defaultKm
        self.keymapOrder = keymapOrder
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(defaultKm: try container.decode(URL.self, forKey: .defaultKm),
                  keymapOrder: try container.decodeIfPresent([URL].self, forKey: .keymapOrder) ?? [])
    }
}
