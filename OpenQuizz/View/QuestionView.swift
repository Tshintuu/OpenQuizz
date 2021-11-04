//
//  QuestionView.swift
//  OpenQuizz
//
//  Created by Developer on 02/11/2021.
//

import UIKit

class QuestionView: UIView {

    @IBOutlet private var label: UILabel!
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var categoryLabel: UILabel!
    
    enum Style {
        case correct, incorrect, standard
    }
    
    var style: Style = .standard {
        didSet {
            setStyle(style)
        }
    }
    var title = "" {
        didSet {
            label.text = title
        }
    }
    var category = "" {
        didSet {
            categoryLabel.text = category
        }
    }
    
    private func setStyle(_ style: Style) {
        switch style {
        case .correct:
            backgroundColor = UIColor(red: 200/255.0, green: 236/255.0, blue: 160/255.0, alpha: 1)
            icon.image = UIImage(named: "Icon Correct")
            icon.isHidden = false
        case .incorrect:
            backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            icon.image = UIImage(named: "Icon Error")
            icon.isHidden = false
        case .standard:
            backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            icon.isHidden = true
        }
    }
    
    

}
