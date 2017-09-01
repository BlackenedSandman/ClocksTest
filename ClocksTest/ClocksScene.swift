//
//  ClocksScene.swift
//  ClocksTest
//
//  Created by Marc van Deuren on 31/08/2017.
//  Copyright © 2017 Blackened. All rights reserved.
//

import Foundation
import SceneKit


class ClocksScene{
    
    public var scene : SCNScene
    final var clocks : [SCNNode]
    var shouldLowerClocks = false
    
    init() {
        self.scene = SCNScene(named: "art.scnassets/clockScene/clockScene.scn")!
        self.clocks = scene.rootNode.childNodes.filter({ (node : SCNNode) -> Bool in
            if let name = node.name {
                return name.contains("Clock")
            }
            return false
        })
    }
    
    func update(){
        if(shouldLowerClocks){
            self.lowerClocks()
        }
        self.rotateClocks()
    }
    
    func lowerClocks(){
        self.clocks.forEach { (clock : SCNNode) in
            clock.position.y -= 0.01
            if(clock.position.y < 0){
                self.shouldLowerClocks = false
            }
        }
    }
    
    func rotateClocks(){
        self.clocks.forEach { (clock : SCNNode) in
            clock.eulerAngles.y += 0.01
        }
    }
}
