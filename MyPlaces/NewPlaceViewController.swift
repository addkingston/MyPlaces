//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by MacBook on 03.04.2022.
//

import UIKit


class NewPlaceViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
            
    }

}
// MARK: Text field delegate
 
extension NewPlaceViewController: UITextViewDelegate {
    
    // Close keyboard tapping "Done"
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

