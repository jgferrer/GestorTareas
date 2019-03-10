//
//  IconsViewController.swift
//  GestorTareas
//
//  Created by Jose Gabriel Ferrer on 10/03/2019.
//  Copyright © 2019 Jose Gabriel Ferrer. All rights reserved.
//

import UIKit

class IconsViewController: UICollectionViewController {

    var iconList: [[String: String]] = [[String: String]]()
    var headerTitleString: String?
    var selectedTask: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconList.append(["icon": "icon-work", "title": "Trabajo"])
        iconList.append(["icon": "icon-sport", "title": "Deporte"])
        iconList.append(["icon": "icon-leisure", "title": "Ocio"])
        iconList.append(["icon": "icon-home", "title": "Casa"])
        iconList.append(["icon": "icon-buy", "title": "Compras"])
        iconList.append(["icon": "icon-travel", "title": "Viajes"])
        iconList.append(["icon": "icon-family", "title": "Familia"])
        iconList.append(["icon": "icon-couple", "title": "Pareja"])
        iconList.append(["icon": "icon-friends", "title": "Amigos"])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath)
        let icon = iconList[indexPath.row]
        if let cell = cell as? IconCell {
            if let icon = icon["icon"]{
                cell.icon.image = UIImage(named: icon)
            }
            if let title = icon["title"]{
                cell.title.text = title
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderIdentifier", for: indexPath) as! HeaderView
        
        headerView.taskName.text = headerTitleString
        
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let icon = iconList[indexPath.row]
        if let selectedTask = selectedTask {
            TaskManager.sharedInstance.tasks[selectedTask]["icon"] = icon["icon"]
            navigationController?.popViewController(animated: true)
        }
    }
    
}
