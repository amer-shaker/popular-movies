//
//  ReviewDTO.swift
//  PopularMovies
//
//  Created by jets on 8/7/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import Foundation
import ObjectMapper

class ReviewAPIResponse: Mappable {
    
    var reviews: [ReviewDTO]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        reviews <- map["results"]
    }
}

public class ReviewDTO: NSObject, NSCoding, Mappable {
    
    var id : String?
    var author: String?
    var content: String?

    required public init?(map: Map) {
        
    }
    
    public required init?(coder aDecoder: NSCoder){
        id = aDecoder.decodeObject(forKey: "id") as! String?
        author = aDecoder.decodeObject(forKey: "author") as! String?
        content = aDecoder.decodeObject(forKey: "content") as! String?
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(id, forKey: "id")
        aCoder.encode(id, forKey: "author")
        aCoder.encode(id, forKey: "content")
    }
    
    
    public func mapping(map: Map) {
        id <- map["id"]
        author <- map["author"]
        content <- map["content"]
    }
}
