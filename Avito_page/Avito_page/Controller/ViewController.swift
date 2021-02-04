//
//  ViewController.swift
//  Avito_page
//
//  Created by Марк Шнейдерман on 15.01.2021.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonExitOutlet: UIButton!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var labelMenu: UILabel!
   
    var alert_title : String?
    var alert_message : String?
    var dataSource = [Page]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        configure()
    }
  
    //достаем данные из Datamanager
    func load(){
        DataManager.sharedData.asyncGetCollectionView { [weak self]dataSource in
            self?.dataSource = dataSource
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    // задаем настройки нашей странице
    func configure (){
        collectionView.delegate = self
        collectionView.dataSource = self
        buttonExitOutlet.setImage(#imageLiteral(resourceName: "CloseIconTemplate"), for: .normal)
        // достаем название нашей кнопки
        let button = UserDefaults.standard.string(forKey: UserDefaultsKeys.buttonKey)
        buttonOutlet.layer.cornerRadius = 3
        buttonOutlet.setTitle(button, for: .normal)
        //достаем название нашего лейбла
        let label =  UserDefaults.standard.string(forKey: UserDefaultsKeys.labelKey)
        labelMenu.text = label
        labelMenu.isHighlighted = true
    }
    

  //MARK: - Кнопка Выбрать
    @IBAction func buttonAction(_ sender: Any) {
        // случай когда ничего не выбрано
        if alert_title == nil || alert_message == nil{
            alert_title = "Выберите одну из ячеек"
            alert_message = ""
        }
        let alertController = UIAlertController(title:alert_title, message:alert_message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
        
    }

    
}

  //MARK: -UICollectionView

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    // метод возвращает количество Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item =  collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        let new = dataSource[indexPath.row]
        item.configure(with: new)
        
        return item
    }

    // метод срабатывает когда ячейка выбрана
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let argument = dataSource[indexPath.row]
    let item = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        alert_title = argument.title
        alert_message = argument.description
        
        item.checkImageView.image = #imageLiteral(resourceName: "checkmark")
    }
    // метод срабатывает когда ячейка не выбрана
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        item.checkImageView.image = .none
    }
}

