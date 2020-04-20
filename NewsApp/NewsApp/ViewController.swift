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
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "header")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: view.bounds.height/4).isActive = true
        return headerView
    }

       override var titlesInSwitcher: [String] {
           return ["yahoo", "abema", "AP通信", "映画ナタリー", "Jスポ", "Buzz"]
       }

       override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index {
            case 0:
                return Page1ViewController()
            case 1:
                return Page2ViewController()
            case 2:
                return Page3ViewController()
            case 3:
                return Page4ViewController()
            case 4:
                return Page5ViewController()
            case 5:
                return Page6ViewController()
            
        default:
            return Page1ViewController()
            
        }
    }
}

