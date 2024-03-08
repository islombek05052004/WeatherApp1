//
//  CollectionViewCell.swift
//  MVC-N
//
//  Created by Abdurazzoqov Islombek on 15/09/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageIcon: UIImageView! {
        didSet {
            imageIcon.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var data: UILabel!
    
    @IBOutlet weak var temp: UILabel!
    
    func setUpData(list: WeatherFiveDays ){
        
        imageIcon.image = UIImage(named: list.SystemIconNameString)
        data.text = list.time
        temp.text = list.temperatureString
    }
}
