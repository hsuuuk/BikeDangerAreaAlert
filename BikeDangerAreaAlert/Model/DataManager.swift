//
//  DataManager.swift
//  BikeDangerAreaAlert
//
//  Created by 심현석 on 2023/02/15.
//

import Foundation

//struct Coordinate {
//    var lat: Double
//    var lng: Double
//}

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    var dataList = [Item]()
    var locationList = [(Double, Double)]()
    
    func Request(completion: (() -> Void)?) {
        let url = "https://apis.data.go.kr/B552061/frequentzoneBicycle/getRestFrequentzoneBicycle?ServiceKey=W20dZ%2FzPRBLwO%2BOF9sBZ2CR9mMv6v6jiGm5dLqsyGBo%2BUA8My0qhvu%2BKDUVx4C0FUrERFo2IdDq75ECcQW%2Bdfw%3D%3D&searchYearCd=2021&siDo=&guGun=&numOfRows=10000&pageNo=1&type=JSON"
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(JSONData.self, from: data)
                self.dataList = data.items.item
                //self.switchStringToDouble(data: data.items.item)
                completion?()
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func switchStringToDouble(data: [Item]) {
        data.forEach { item in
            guard let lat = Double(item.lat) else { return }
            guard let lng = Double(item.lng) else { return }
            self.locationList.append((lat, lng))
        }
    }
}

