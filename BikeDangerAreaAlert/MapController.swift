//
//  ViewController.swift
//  BikeDangerAreaAlert
//
//  Created by 심현석 on 2023/02/15.
//

import UIKit
import NMapsMap
import CoreLocation
import SnapKit
import UserNotifications

class MapController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var dataManager = DataManager.shared
    
    var markers = [NMFMarker]()
    
    private let mapView: NMFMapView = {
        let mapView = NMFMapView() // 지도 객체 생성
        mapView.positionMode = .direction // 현 위치 표시
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMap()
        setupCurrentlocation()
        addMarkers(mapView: mapView)
        setupPushNotification()
    }
    
    func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "지도"
    }
    
    func setupMap() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
        
        let locationButton = UIButton(frame: CGRect(x: 11, y: 675, width: 50, height: 50))
        locationButton.backgroundColor = UIColor.white
        locationButton.layer.cornerRadius = 25
        locationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        view.addSubview(locationButton)
        
        let locationOverlay = mapView.locationOverlay
        locationOverlay.circleRadius = 50
        locationOverlay.circleColor = .systemFill
        locationOverlay.hidden = true
    }
    
    @objc func locationButtonTapped() {
        guard let latitude = locationManager.location?.coordinate.latitude else { return }
        guard let longitude = locationManager.location?.coordinate.longitude else { return }
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)
    }
    
    func setupCurrentlocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 거리 정확도
        locationManager.requestWhenInUseAuthorization() // // 위치 허용받을 alert 알림
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치서비스 On")
            locationManager.startUpdatingLocation()
            
            //현 위치로 카메라 이동
            guard let latitude = locationManager.location?.coordinate.latitude else { return }
            guard let longitude = locationManager.location?.coordinate.longitude else { return }
            //let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.509519, lng: 127.068099))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
        } else {
            print("위치서비스 Off")
        }
    }
    
    func addMarkers(mapView: NMFMapView) {
        dataManager.Request {
            self.dataManager.dataList.forEach { item in
                guard let lat = Double(item.lat) else { return }
                guard let lng = Double(item.lng) else { return }
                let location = NMGLatLng(lat: lat, lng: lng)
                
                DispatchQueue.main.async {
                    let marker = NMFMarker()
                    marker.position = location
                    marker.height = 25
                    marker.width = 20
                    marker.iconImage = NMF_MARKER_IMAGE_RED
                    marker.mapView = mapView
                    
                    marker.touchHandler =  { (overlay: NMFOverlay) -> Bool in
                        let controller = InfoController()
                        controller.data = item
                        controller.modalPresentationStyle = .automatic
                        self.present(controller, animated: true)
                        return true
                    }
                    self.markers.append(marker)
                }
            }
        }
    }
    
    func setupPushNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("알림 권한 허용")
            } else {
                print("알림 권한 거부")
            }
        }
    }
}

extension MapController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        markers.forEach { maker in
            let markerLocation = CLLocation(latitude: maker.position.lat, longitude: maker.position.lng)
            let distance = currentLocation.distance(from: markerLocation)
            
            if distance <= 100 {
                // 알림 발생
                let content = UNMutableNotificationContent()
                content.title = "알림"
                content.body = "사고다발지역 100m 근방입니다."
                content.sound = UNNotificationSound.default
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
                
                let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                print("사고다발지역 200m 근방입니다.")
            }
        }
    }
}

