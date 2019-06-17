//
//  LocationModel.swift
//  DatabasePractice2
//
//  Created by yilin luo on 6/17/19.
//  Copyright © 2019 yilin luo. All rights reserved.
//

import Foundation

class LocationModel: NSObject {
    //Properties
    var name: String?
    var address: String?
    var latitude: String?
    var longitude: String?
    
    //empty constructor
    override init(){
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    init(name: String, address: String, latitude: String, longitude: String){
        
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    //prints object's current state
    override var description: String {
        return "Name: \(name), Address: \(address), Latitude: \(latitude), Longitude: \(longitude) "
    }
}
