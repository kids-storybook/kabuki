//
//  StoryModel.swift
//  Storybook
//
//  Created by zy on 18/11/22.
//

import Foundation

enum StoryLabelColor: String {
    case green = "greenSingaLabel"
    case brown = "brownGajahLabel"
    case red = "redPandaLabel"
}

struct StoryModel {
    var challengeName: String?
    var title: String?
    var labels: [NSString?]?
    var labelColor: StoryLabelColor?
    var order: Int32?
    var background: String?
    var character: String?
    var characterAtlas: String?
    var characterXPosition: Double?
    var characterYPosition: Double?
    
    func feedingZooStories() -> [StoryModel] {
        let stories = [
            StoryModel(
                challengeName: "lion_challenge",
                title: "singaStoryTitle",
                labels: ["Lihatlah keluarga singa ini"],
                labelColor: StoryLabelColor.green,
                order: 0,
                background: "kandangSinga",
                character: "lions_1",
                characterAtlas: "LionStoryAnimation",
                characterXPosition: 0,
                characterYPosition: -80),
            StoryModel(
                challengeName: "lion_challenge",
                title: "singaStoryTitle",
                labels: ["Ada Bapak singa, Ibu singa, dan", "anak singa"],
                labelColor: StoryLabelColor.green,
                order: 1,
                background: "kandangSinga",
                character: "lions_1",
                characterAtlas: "LionStoryAnimation",
                characterXPosition: 0,
                characterYPosition: -80),
            StoryModel(
                challengeName: "lion_challenge_animate",
                title: "singaStoryTitle",
                labels: ["Ibu Singa memberikan anaknya", "berbagai bentuk mainan"],
                labelColor: StoryLabelColor.green,
                order: 0,
                background: "kandangSingaZoom",
                character: "lions_2",
                characterAtlas: "LionShapesAnimation",
                characterXPosition: -130,
                characterYPosition: -75),
            StoryModel(
                challengeName: "lion_challenge_animate_2",
                title: "singaStoryTitle",
                labels: ["Ada yang berbentuk persegi,", "segitiga, dan lingkaran"],
                labelColor: StoryLabelColor.green,
                order: 0,
                background: "kandangSingaZoom",
                character: "lions_2",
                characterAtlas: "LionShapesAnimation",
                characterXPosition: -130,
                characterYPosition: -75),
            StoryModel(
                challengeName: "lion_challenge_appreciation",
                title: "berhasilTitle",
                labels: ["appreciate"],
                labelColor: StoryLabelColor.green,
                order: 0,
                background: "kandangSinga",
                character: "lion_appreciation",
                characterAtlas: "LionAppreciationAnimation",
                characterXPosition: 30,
                characterYPosition: -100),
            
            
            StoryModel(
                challengeName: "elephant_challenge",
                title: "gajahStoryTitle",
                labels: ["Lihatlah sekelompok gajah ini"],
                labelColor: StoryLabelColor.brown,
                order: 0,
                background: "kandangGajah",
                character: "elephants_1",
                characterAtlas: "ElephantStoryAnimation",
                characterXPosition: 0,
                characterYPosition: 0),
            StoryModel(
                challengeName: "elephant_challenge",
                title: "gajahStoryTitle",
                labels: ["Mereka sedang diberi makan", "oleh penjaga kebun binatang "],
                labelColor: StoryLabelColor.brown,
                order: 1,
                background: "kandangGajah",
                character: "elephants_2",
                characterAtlas: "ElephantStoryAnimation",
                characterXPosition: 0,
                characterYPosition: 0),
            StoryModel(
                challengeName: "elephant_challenge_animate",
                title: "gajahStoryTitle",
                labels: ["Gajah adalah pemakan tumbuhan"],
                labelColor: StoryLabelColor.brown,
                order: 0,
                background: "kandangGajahZoom",
                character: "elephants_2",
                characterAtlas: "ElephantStoryAnimation",
                characterXPosition: 0,
                characterYPosition: 0),
            StoryModel(
                challengeName: "elephant_challenge_animate_2",
                title: "gajahStoryTitle",
                labels: ["Ada makanan yang berbentuk ", " persegi, segitiga dan lingkaran"],
                labelColor: StoryLabelColor.brown,
                order: 0,
                background: "kandangGajahZoom",
                character: "elephants_2",
                characterAtlas: "ElephantStoryAnimation",
                characterXPosition: 0,
                characterYPosition: 0),
            StoryModel(
                challengeName: "elephant_challenge_appreciation",
                title: "berhasilTitle",
                labels: ["appreciate"],
                labelColor: StoryLabelColor.brown,
                order: 0,
                background: "kandangGajahZoom",
                character: "elephant_appreciation",
                characterAtlas: "ElephantAppreciationAnimation",
                characterXPosition: -25,
                characterYPosition: -35),
            
            StoryModel(
                challengeName: "panda_challenge",
                title: "pandaStoryTitle",
                labels: ["Lihat ada anak-anak Panda", "yang menggemaskan"],
                labelColor: StoryLabelColor.red,
                order: 0,
                background: "kandangPanda",
                character: "elephants_1",
                characterAtlas: "PandaStartAnimation",
                characterXPosition: 115,
                characterYPosition: -90),
            StoryModel(
                challengeName: "panda_challenge",
                title: "pandaStoryTitle",
                labels: ["Mereka sedang bermain bersama"],
                labelColor: StoryLabelColor.red,
                order: 1,
                background: "kandangPanda",
                character: "elephants_2",
                characterAtlas: "PandaStartAnimation",
                characterXPosition: 115,
                characterYPosition: -90),
            StoryModel(
                challengeName: "panda_challenge_animate",
                title: "pandaStoryTitle",
                labels: ["Panda sangat senang bermain", "susun benda"],
                labelColor: StoryLabelColor.red,
                order: 0,
                background: "kandangPandaZoom",
                character: "elephants_2",
                characterAtlas: "PandaShapesAnimation",
                characterXPosition: -270,
                characterYPosition: -100),
            StoryModel(
                
                challengeName: "panda_challenge_animate_2",
                title: "pandaStoryTitle",
                labels: ["Ada benda berbentuk", " persegi, segitiga dan lingkaran"],
                labelColor: StoryLabelColor.red,
                order: 0,
                background: "kandangPandaZoom",
                character: "elephants_2",
                characterAtlas: "PandaShapesAnimation",
                characterXPosition: -270,
                characterYPosition: -100),
            StoryModel(
                challengeName: "panda_challenge_appreciation",
                title: "pandaStoryTitle",
                labels: ["appreciate"],
                labelColor: StoryLabelColor.red,
                order: 0,
                background: "kandangPandaZoom",
                character: "elephant_appreciation",
                characterAtlas: "PandaAppreciationAnimation",
                characterXPosition: -25,
                characterYPosition: -35)
            
        ]
        
        return stories
    }
}
