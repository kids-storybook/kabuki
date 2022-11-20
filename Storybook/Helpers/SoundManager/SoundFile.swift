//
//  SoundFile.swift
//  Storybook
//
//  Created by zy on 20/11/22.
//

import Foundation

public protocol SoundFile {
    var filename: String { get }
    var type: String { get }
}

public struct Music: SoundFile {
    public var filename: String
    public var type: String
}

public struct Effect: SoundFile {
    public var filename: String
    public var type: String
}
