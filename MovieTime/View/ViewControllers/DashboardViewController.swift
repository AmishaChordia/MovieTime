//
//  DashboardViewController.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController {
        
    @IBOutlet weak var searchView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        searchView?.layer.cornerRadius = BaseViewController.SearchBarConstants.searchBarHeight/2
        searchView?.layer.borderWidth = BaseViewController.SearchBarConstants.searchBarBorderWidth
        searchView?.layer.borderColor = UIColor.searchBarBorder().cgColor
    }
    
    @IBAction func didTapSearchBar(_ sender: UIButton) {
        print("search tapped")
    }
}

