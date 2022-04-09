//
//  CustomTableViewCell.swift
//  MyPlaces
//
//  Created by MacBook on 03.04.2022.
//

import UIKit
import Cosmos

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var imageOfPlace: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var cosmosView: CosmosView!
    func didSet() {
        cosmosView.settings.updateOnTouch = false
    }
    
    
}
