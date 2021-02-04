//
//  DataManagerProtocol.swift
//  Avito_page
//
//  Created by Марк Шнейдерман on 30.01.2021.
//

import Foundation

protocol DataManagerProtocol {
    /* парсер данных который строго берет данные из нашего JSON файла,
    таким образом оставляя только валидные Item в нашем collectionView
    */
    func parse()
    
    // метод который позволит достать данные из JSON файла во ViewController 
    func asyncGetCollectionView(completion:@escaping([Page])->Void)
    
}
