//
//  Theme.swift
//  Storybook
//
//  Created by zy on 18/11/22.
//

import Foundation

struct ThemeModel {
    var background: String?
    var mapBackground: String?
    var label: String?
    var name: String?
    var startButton: String?
    var isActive: Bool?
    var challenges: [ChallengeModel?]?

    func feedingThemes() -> [ThemeModel] {
        let themes = [
            ThemeModel(background: "mini zoo theme", mapBackground: "zoo_background", name: "zoo", isActive: true, challenges: ChallengeModel().feedingZooChallenges()),
            ThemeModel(background: "locked theme", mapBackground: "zoo_background", name: "forest", isActive: false, challenges: []),
            ThemeModel(background: "locked theme", mapBackground: "zoo_background", name: "garden", isActive: false, challenges: [])
        ]

        return themes
    }
}
