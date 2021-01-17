//
//  ViewController.swift
//  Avito_page
//
//  Created by Марк Шнейдерман on 15.01.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonExitOutlet: UIButton!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var labelMenu: UILabel!
   
    // данные которые мы передаем в alert
    var alert_title : String?
    var alet_message : String?
    // структура [list]
    var dataSource = [Page]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        buttonExitOutlet.setImage(#imageLiteral(resourceName: "CloseIconTemplate"), for: .normal)
        buttonOutlet.layer.cornerRadius = 3
        load()
    }
  

  //MARK: - Кнопка Выбрать
    @IBAction func buttonAction(_ sender: Any) {
        if alert_title == nil {
            alert_title = "Выберите одну из ячеек"
        }
        if alet_message == nil{
            alet_message = ""
        }
        let alertController = UIAlertController(title:alert_title, message: alet_message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - UICollectionView
    // метод возвращает количество Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    // метод который работает 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item =  collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        let new = dataSource[indexPath.row]
        item.configure(with: new)
        
        return item
    }

    // метод срабатывает когда ячейка выбрана
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let argument = dataSource[indexPath.row]
        guard let item = collectionView.cellForItem(at: indexPath) as CustomCollectionViewCell else {return}
        alert_title = argument.title
        alet_message = argument.description
        item.checkImageView.image = #imageLiteral(resourceName: "checkmark")
    }
    // метод срабатывает когда ячейка не выбрана
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        item.checkImageView.image = .none
    }
    
    
  //MARK: - JSON PARSER
    func load(){
        let url = Bundle.main.url(forResource: "result", withExtension: "json")
        guard let jsonData = url else{return}
        guard let data = try? Data(contentsOf: jsonData) else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else{return}
        if let dictionary = json as? [String:Any]{
            if let result = dictionary["result"] as? [String:Any]{
                if let title = result["title"] as? String{
                    labelMenu.text = title
                    labelMenu.isHighlighted = true
                }
                if let buttonText =  result["selectedActionTitle"] as? String{
                    // текст : "Выбрать"
                    buttonOutlet.setTitle(buttonText, for: .normal)
                }
                if let list = result["list"] as? [[String:Any]]{
                    
                    for array in list {
                        guard let myId = array["id"] as? String else {return}
                        guard let myTitle = array["title"] as? String else {return}
                        guard let myDescription  = array["description"] as? String else {return}
                        guard let myPrice  = array["price"] as? String else {return}
                        guard let select  = array["isSelected"] as? Bool else {return}
                        guard let icon = array["icon"] as? [String:Any] else {return}
                        guard let myImageURl = icon["52x52"] as? String else {return}
                        dataSource.append(Page(id: myId, title: myTitle, description: myDescription, imageUrl: myImageURl, price: myPrice, isSelected: select))
                    }
                }
            }
        }
    }
}

