//
//  LandingViewController.swift
//  Basic-Video-Chat
//
//  Created by Serhii Syrotynin on 8/8/17.
//  Copyright © 2017 tokbox. All rights reserved.
//

import UIKit
import OpenTok

class LandingViewController: UIViewController {

    @IBOutlet weak var streamButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var streamView: DesignableView!
    @IBOutlet weak var playView: DesignableView!
    
    lazy var session: OTSession = {
        return OTSession(apiKey: ServiceManager.shared.apiKey!, sessionId: ServiceManager.shared.sessionId!, delegate: self)!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        streamButton.isEnabled = false
        connectButton.isEnabled = false
        
        // Do any additional setup after loading the view.
        ServiceManager.shared.startSession {
            print("COMPLETED")
            self.streamButton.isEnabled = true
            self.connectButton.isEnabled = true
        }
    }
    
    /**
     * Asynchronously begins the session connect process. Some time later, we will
     * expect a delegate method to call us back with the results of this action.
     */
    fileprivate func doConnect() {
        var error: OTError?
        defer {
            processError(error)
        }
        
        session.connect(withToken: kToken, error: &error)
    }
    
    fileprivate func processError(_ error: OTError?) {
        if let err = error {
            DispatchQueue.main.async {
                let controller = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(controller, animated: true, completion: nil)
            }
        }
    }

    // MARK: Actions
    @IBAction func streamClicked(_ sender: Any) {
        
    }
    
    @IBAction func connectClicked(_ sender: Any) {
        
    }
}

// MARK: - OTSession delegate callbacks
extension LandingViewController: OTSessionDelegate {
    func sessionDidConnect(_ session: OTSession) {
        print("Session connected")
        //        doPublish()
    }
    
    func sessionDidDisconnect(_ session: OTSession) {
        print("Session disconnected")
    }
    
    func session(_ session: OTSession, streamCreated stream: OTStream) {
        print("Session streamCreated: \(stream.streamId)")
//        if subscriber == nil && !subscribeToSelf {
//            doSubscribe(stream)
//        }
    }
    
    func session(_ session: OTSession, streamDestroyed stream: OTStream) {
        print("Session streamDestroyed: \(stream.streamId)")
//        if let subStream = subscriber?.stream, subStream.streamId == stream.streamId {
//            cleanupSubscriber()
//        }
    }
    
    func session(_ session: OTSession, didFailWithError error: OTError) {
        print("session Failed to connect: \(error.localizedDescription)")
    }

}
