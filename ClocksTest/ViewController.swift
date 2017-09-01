//
//  ViewController.swift
//  ClocksTest
//
//  Created by Marc van Deuren on 31/08/2017.
//  Copyright © 2017 Blackened. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var startButton: UIButton!
    
    var lowering = false
    var started = false
    
    @IBAction func startClocks(_ sender: Any) {
        if(!started){
            startButton.setTitle("Stop", for: UIControlState.normal)
            let scene = SCNScene(named: "art.scnassets/clockScene/clockScene.scn")!
            sceneView.scene = scene
            lowering = true
        }
        else{
            startButton.setTitle("Start", for: UIControlState.normal)
            sceneView.scene = SCNScene()
            lowering = false
        }
        started = !started
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let hitTestResult = self.sceneView.hitTest(touches.first!.preciseLocation(in: self.sceneView))
        
        let hitNode = hitTestResult.first?.node
        if let node = hitNode {
            node.scale.x += 1
            node.scale.y += 1
            node.scale.z += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        // sceneView.showsStatistics = true
        //sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        // Create a new scene
        
        
//        scene.rootNode.childNodes.forEach { (node: SCNNode) in
//            node.look(at: sceneView.session.currentFrame?.camera.)
//        }
        
        // Set the scene to the view
        
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
            sceneView.scene.rootNode.childNodes
                .filter({ (node : SCNNode) -> Bool in
                    if let name = node.name {
                        return name.contains("Clock")
                    }
                    return false
                    })
                .forEach(update)
    }
    
    func update(clock: SCNNode){
        if(self.lowering){
            clock.position.y -= 0.01
            if(clock.position.y < 0){
                print("stopped by \(String(describing: clock.name))")
                self.lowering = false
            }
        }
        clock.eulerAngles.y += 0.01
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
