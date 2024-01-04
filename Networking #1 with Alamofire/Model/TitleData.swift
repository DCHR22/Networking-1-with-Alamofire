//
//  TitleData.swift
//  Networking #1 with Alamofire
//
//  Created by Camilo L-Shide on 02/01/24.
//

import Foundation

struct TitleData: Decodable{
    
    let kind : String
    
    let data : Main
    
}

struct Main : Decodable { //Since Data is a designated object of swift we changed the name of the struct for Main to avoid errors
    
    let after : String
    
    let children : [TitleData1]
    
   
}

public struct TitleData1: Decodable {
    
    let kind : String
    
    let data : Main1
    
}



struct Main1 : Decodable {
    
    let title : String
    let subreddit : String
}
