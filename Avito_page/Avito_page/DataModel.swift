//
//  Item.swift
//  Avito_page
//
//  Created by Марк Шнейдерман on 15.01.2021.
//

import Foundation


struct Page {
    
    let id : String
    let title : String
    let description: String
    let imageUrl: String
    let price:String
    let isSelected:Bool
    
    public init(id: String, title: String,description: String,imageUrl:String,price: String,isSelected:Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.price = price
        self.isSelected = isSelected
    }
}
