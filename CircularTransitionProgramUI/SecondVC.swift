//
//  SecondVC.swift
//  CircularTransitionProgramUI
//
//  Created by James Rochabrun on 3/17/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    
    lazy var button: UIButton = {
        let b = UIButton()
        b.backgroundColor = .white
        b.layer.cornerRadius = 25
        b.layer.masksToBounds = true
        b.setTitle("X", for: .normal)
        b.setTitleColor(#colorLiteral(red: 1, green: 0.3864146769, blue: 0.4975627065, alpha: 1), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1, green: 0.3864146769, blue: 0.4975627065, alpha: 1)
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }
    
    func dismissView() {
        dismiss(animated: true)
    }

}
