//
//  LocationService.swift
//  MapsTest
//
//  Created by Teacher on 18.03.2023.
//

import Foundation
import CoreLocation

class LocationService {
    enum AuthorizationStatus {
        case needToRequest
        case granted
        case denied
    }

    private let manager: CLLocationManager

    init() {
        manager = CLLocationManager()
    }

    func checkAuthorization() -> AuthorizationStatus {
        switch manager.authorizationStatus {
            case .notDetermined:
                print("Not determined, need to ask for access")
                return .needToRequest
            case .authorizedAlways:
                print("We have full access")
                checkAccuracyAuthorization()
                return .granted
            case .authorizedWhenInUse:
                print("We have access when app is in use")
                checkAccuracyAuthorization()
                return .granted
            case .denied:
                print("Denied")
                return .denied
            case .restricted:
                print("Restricted")
                return .denied
            @unknown default:
                print("Unknown default: \(manager.authorizationStatus)")
                return .denied
        }
    }

    private func checkAccuracyAuthorization() {
        switch manager.accuracyAuthorization {
            case .fullAccuracy:
                print("We have full accuracy")
            case .reducedAccuracy:
                print("We have reduced accuracy")
                manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "default")
            @unknown default:
                print("We have unknown value: \(manager.accuracyAuthorization)")
        }
    }

    func requestLocationAccess() {
        manager.requestAlwaysAuthorization()
    }
}
