//
//  ViewController.swift
//  CircularTransitionProgramUI
//
//  Created by James Rochabrun on 3/17/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    let transition: CircularTransition = CircularTransition()

    lazy var button: UIButton = {
        let b = UIButton()
        b.setTitle("M", for: .normal)
        b.backgroundColor = #colorLiteral(red: 1, green: 0.3864146769, blue: 0.4975627065, alpha: 1)
        b.layer.cornerRadius = 25
        b.layer.masksToBounds = true
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(setTheDelegate), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }
    
    func setTheDelegate() {
        let secondVC = SecondVC()
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        present(secondVC, animated: true)
    }
}

extension MainVC: UIViewControllerTransitioningDelegate  {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .present
        transition.startingPoint = button.center
        transition.circleColor = button.backgroundColor!
        return transition
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = button.center
        transition.circleColor = button.backgroundColor!
        return transition
    }

}

