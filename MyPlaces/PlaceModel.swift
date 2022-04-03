//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by MacBook on 03.04.2022.
//

import Foundation

struct Place {
    
    var name: String
    var location: String
    var type: String
    var image: String
    
     static let restaurantNames = ["Mama Roma", "Pio Nero", "На парах", "Счастье", "Hitch", "Паруса", "Летучий голландец", "Rustaveli", "КИДО", "Bali", "Royal Beach", "Villa Zималето", "Sunday Ginza", "Чайка", "Lighthouse"]
    
    static func getPlaces() -> [Place] {
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "St-Petersburg", type: "Restaurant", image: place))
        }
        
        return places
    }
}