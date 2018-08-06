//
//  ViewController.swift
//  triangleLoader
//
//  Created by Pavel Kozlov on 06/08/2018.
//  Copyright © 2018 Pavel Kozlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var container: TriangleLoader!
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func playAction(_ sender: UIButton) {
        if container.isAnimating {
            playButton.setTitle("Start", for: .normal)
            container.stopAnimating()
        } else {
            playButton.setTitle("Stop", for: .normal)
            container.startAnimating()
        }
    }
}

