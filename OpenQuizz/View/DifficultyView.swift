//
//  DifficultyView.swift
//  OpenQuizz
//
//  Created by Developer on 04/11/2021.
//

import UIKit

class DifficultyView: UIView {

    @IBOutlet private var label: UILabel!
    @IBOutlet private var easyLevel: UIView!
    @IBOutlet private var mediumLevel: UIView!
    @IBOutlet private var hardLevel: UIView!
    
    enum Style {
        case easy, medium, hard, unknown
    }
    
    var style: Style = .unknown {
        didSet {
            setStyle(style)
        }
    }
    
    func setStyle(_ style: Style) {
        switch style {
        case .easy:
            easyLevel.backgroundColor = UIColor(red: 90/255, green: 190/255, blue: 30/255, alpha: 1)
            mediumLevel.backgroundColor = UIColor(red: 90/255, green: 190/255, blue: 30/255, alpha: 0.5)
            hardLevel.backgroundColor = UIColor(red: 90/255, green: 190/255, blue: 30/255, alpha: 0.5)
            label.text = "Easy"
            label.textColor = UIColor(red: 90/255, green: 190/255, blue: 30/255, alpha: 1)
        case .medium:
            easyLevel.backgroundColor = UIColor(red: 211/255, green: 121/255, blue: 0/255, alpha: 1)
            mediumLevel.backgroundColor = UIColor(red: 211/255, green: 121/255, blue: 0/255, alpha: 1)
            hardLevel.backgroundColor = UIColor(red: 211/255, green: 121/255, blue: 0/255, alpha: 0.5)
            label.text = "Medium"
            label.textColor = UIColor(red: 211/255, green: 121/255, blue: 0/255, alpha: 1)
        case .hard:
            easyLevel.backgroundColor = UIColor(red: 251/255, green: 0/255, blue: 13/255, alpha: 1)
            mediumLevel.backgroundColor = UIColor(red: 251/255, green: 0/255, blue: 13/255, alpha: 1)
            hardLevel.backgroundColor = UIColor(red: 251/255, green: 0/255, blue: 13/255, alpha: 1)
            label.text = "Hard"
            label.textColor = UIColor(red: 251/255, green: 0/255, blue: 13/255, alpha: 1)
        case .unknown:
            easyLevel.backgroundColor = #colorLiteral(red: 0.7498463988, green: 0.7682407498, blue: 0.7903252244, alpha: 1)
            mediumLevel.backgroundColor = #colorLiteral(red: 0.7498463988, green: 0.7682407498, blue: 0.7903252244, alpha: 1)
            hardLevel.backgroundColor = #colorLiteral(red: 0.7498463988, green: 0.7682407498, blue: 0.7903252244, alpha: 1)
            label.text = "Difficulty unknown"
            label.textColor = #colorLiteral(red: 0.7498463988, green: 0.7682407498, blue: 0.7903252244, alpha: 1)
        }
    }

}
