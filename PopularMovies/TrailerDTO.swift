//
//  TrailerDTO.swift
//  PopularMovies
//
//  Created by jets on 7/29/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import Foundation
import ObjectMapper

class TrailerAPIResponse: Mappable {
    
    var trailers: [TrailerDTO]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        trailers <- map["results"]
    }
}

public class TrailerDTO: NSObject, NSCoding, Mappable {
    
    var id : String?
    var name: String?
    var type: String?
    var key: String?
    
    public required init?(map: Map) {
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as! String?
        name = aDecoder.decodeObject(forKey: "name") as! String?
        type = aDecoder.decodeObject(forKey: "type") as! String?
        key = aDecoder.decodeObject(forKey: "key") as! String?
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(key, forKey: "key")
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
        key <- map["key"]
    }
}
