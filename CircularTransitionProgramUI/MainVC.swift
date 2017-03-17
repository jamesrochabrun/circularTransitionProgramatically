//
//  ViewController.swift
//  CircularTransitionProgramUI
//
//  Created by James Rochabrun on 3/17/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

struct Colors {
    static let mainColor = #colorLiteral(red: 0.9294117647, green: 0.2431372549, blue: 0.6470588235, alpha: 1)
    static let subColor = #colorLiteral(red: 0.9960784314, green: 0.7803921569, blue: 0.4235294118, alpha: 1)
    static let textcolor = UIColor.white
}

import UIKit

class MainVC: UIViewController {
    
    let transition: CircularTransition = CircularTransition()

    lazy var button: UIButton = {
        let b = UIButton()
        b.setTitle("M", for: .normal)
        b.backgroundColor = Colors.mainColor
        b.setTitleColor(Colors.textcolor, for: .normal)
        b.layer.cornerRadius = 35
        b.layer.masksToBounds = true
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(setTheDelegate), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.subColor
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
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

