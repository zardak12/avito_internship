//
//  DataManager.swift
//  Avito_page
//
//  Created by Марк Шнейдерман on 28.01.2021.
//

import Foundation
import UIKit

// ключи для хранение наших данных настроек
enum UserDefaultsKeys{
    static let labelKey = "labelKey" // ключ для лейбла
    static let buttonKey = "buttonKey" // ключ для кнопки
}

class DataManager : DataManagerProtocol {
    static let sharedData = DataManager()
    var userDefaults = UserDefaults.standard
    private var myData = [Page]()
    private init(){
        parse()
    }
    
    
    //парсер для json файла
    func parse(){
            let url = Bundle.main.url(forResource: "result", withExtension: "json")
            guard let jsonData = url else{return}
            guard let data = try? Data(contentsOf: jsonData) else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else{return}
            if let dictionary = json as? [String:Any]{
                if let result = dictionary["result"] as? [String:Any]{
                    if let list = result["list"] as? [[String:Any]]{
                        if let title = result["title"] as? String{
                            // сохраняем название нашего лейбла
                            userDefaults.setValue(title, forKey: UserDefaultsKeys.labelKey) // сохраняем имя лэйбла
                        if let buttonText =  result["selectedActionTitle"] as? String{
                            // сохраняем название нашей кнопки 
                            userDefaults.setValue(buttonText, forKey: UserDefaultsKeys.buttonKey) // сохранем имя кнопки
                        for array in list {
                            guard let myId = array["id"] as? String else {return}
                            guard let myTitle = array["title"] as? String else {return}
                            guard let myDescription  = array["description"] as? String else {return}
                            guard let myPrice  = array["price"] as? String else {return}
                            guard let select  = array["isSelected"] as? Bool else {return}
                            guard let icon = array["icon"] as? [String:Any] else {return}
                            guard let myImageURl = icon["52x52"] as? String else {return}
                            myData.append(Page(id: myId, title: myTitle, description: myDescription, imageUrl: myImageURl, price: myPrice, isSelected: select))
                                }
                            }
                        }
                    }
                }
            
            }
    }
    
    // блок который позовлит достать информацию в нужном нам контроллере 
    func asyncGetCollectionView(completion:@escaping([Page])->Void ){
        let operationQueue = OperationQueue()
        DispatchQueue.global(qos: .userInteractive).async {
           let operation = BlockOperation { [weak self] in
            
             guard let dataSource = self?.myData else { return }
             completion(dataSource)
            }
            operationQueue.addOperation(operation)
          }

        }
        
}
