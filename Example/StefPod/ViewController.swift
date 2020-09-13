//
//  ViewController.swift
//  StefPod
//
//  Created by AndyStef on 09/11/2020.
//  Copyright (c) 2020 AndyStef. All rights reserved.
//

import UIKit
import StefPod

class ViewController: UIViewController {

    let motion = MotionService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        motion.delegate = self
        motion.startGyroscopeTracking()
        motion.startAccelerometerTracking()
    }
}

extension ViewController: MotionServiceDelegate {
    func didReceive(_ gyroscopeMeasure: GyroscopeMeasure) {
        print("Gyro \(gyroscopeMeasure.y)")
    }
    
    func didReceive(_ acceleratorMeasure: AccelerometerMeasure) {
        print("Acc \(acceleratorMeasure.x)")
    }
}
