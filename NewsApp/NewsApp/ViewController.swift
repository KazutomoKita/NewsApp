//
//  ViewController.swift
//  NewsApp
//
//  Created by Kazutomo Kita on 2020/04/20.
//  Copyright © 2020 Kazutomo Kita. All rights reserved.
//

import UIKit
import SegementSlide

class ViewController: SegementSlideViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
        scrollToSlide(at: 0, animated: true)
    }

    override var headerView: UIView? {
        let headerView = UIView()
        //let headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: view.bounds.height/4).isActive = true
        return headerView
    }

       override var titlesInSwitcher: [String] {
           return ["Swift", "Ruby", "Kotlin", "Kotlin", "Kotlin", "Kotlin"]
       }

       override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index {
            case 0:
                return Page1ViewController()
            case 1:
                return Page1ViewController()
            case 2:
                return Page1ViewController()
            case 3:
                return Page1ViewController()
            case 4:
                return Page1ViewController()
            case 5:
                return Page1ViewController()
            
        default:
            return Page1ViewController()
            
        }
    }
}

