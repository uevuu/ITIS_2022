//
//  ViewController.swift
//  MapsTest
//
//  Created by Teacher on 18.03.2023.
//

import MapKit
import UIKit

class ViewController: UIViewController {
    private var mapView: MKMapView!

    private let service: LocationService

    required init?(coder: NSCoder) {
        service = LocationService()
        super.init(coder: coder)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        service = LocationService()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MKMapView()
        view.addSubview(mapView)

//        let marker = MKMarkerAnnotationView(annotation: <#T##MKAnnotation?#>, reuseIdentifier: <#T##String?#>)
//        mapView.addOverlay(<#T##overlay: MKOverlay##MKOverlay#>)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        switch service.checkAuthorization() {
            case .granted:
                mapView.showsUserLocation = true
            case .denied:
                showLocationDeniedAlert()
                print("Location access is denied")
            case .needToRequest:
                service.requestLocationAccess()
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        mapView.frame = view.bounds
    }

    private func showLocationDeniedAlert() {
        let alert = UIAlertController(title: "Location access is denied", message: "Do you want to open preferences and enable location access?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open settings", style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

