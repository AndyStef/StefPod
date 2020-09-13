//
//  MotionService.swift
//  StefPod
//
//  Created by Andy Stef on 11.09.2020.
//

import CoreMotion
 
public protocol MotionServiceDelegate: class {
    func didReceive(_ acceleratorMeasure: AccelerometerMeasure)
    func didReceive(_ gyroscopeMeasure: GyroscopeMeasure)
}


public class MotionService {
    
    struct Constants {
        static let accelerometerUpdateInterval: TimeInterval = 1.0 / 100.0
        static let gyroscopeUpdateInterval: TimeInterval = 1.0 / 100.0
    }
    
    public init() {}
    
    public weak var delegate: MotionServiceDelegate?
    
    private let manager = CMMotionManager()
    private var accelerometerTimer: Timer?
    private var gyroscopeTimer: Timer?
    
    public func startAccelerometerTracking() {
        guard manager.isAccelerometerAvailable else {
            return
        }
        
        manager.accelerometerUpdateInterval = Constants.accelerometerUpdateInterval
        manager.startAccelerometerUpdates()
        
        accelerometerTimer = Timer(fire: Date(), interval: Constants.accelerometerUpdateInterval, repeats: true, block: { _ in
            guard let data = self.manager.accelerometerData else {
                return
            }
            
            self.delegate?.didReceive(AccelerometerMeasure(x: data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z))
        })
        
        RunLoop.current.add(accelerometerTimer!, forMode: .default)
    }
    
    public func startGyroscopeTracking() {
        guard manager.isGyroAvailable else {
            return
        }
        
        manager.gyroUpdateInterval = Constants.gyroscopeUpdateInterval
        manager.startGyroUpdates()
        
        gyroscopeTimer = Timer(fire: Date(), interval: Constants.gyroscopeUpdateInterval, repeats: true, block: { _ in
            guard let data = self.manager.gyroData else {
                return
            }
            
            self.delegate?.didReceive(GyroscopeMeasure(x: data.rotationRate.x, y: data.rotationRate.y, z: data.rotationRate.z))
        })
        
        RunLoop.current.add(gyroscopeTimer!, forMode: .default)
    }
}
