//
//  AccelerometerMeasure.swift
//  StefPod
//
//  Created by Andy Stef on 11.09.2020.
//

import Foundation
 
public class AccelerometerMeasure {
    public var x: Double = 0
    var y: Double = 0
    var z: Double = 0
    
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
}
