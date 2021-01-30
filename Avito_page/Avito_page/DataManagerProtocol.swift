//
//  DataManagerProtocol.swift
//  Avito_page
//
//  Created by Марк Шнейдерман on 30.01.2021.
//

import Foundation

protocol DataManagerProtocol {
    func asyncGetCollectionView(completion:@escaping([Page])->Void )
}
