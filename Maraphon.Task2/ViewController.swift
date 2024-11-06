//
//  ViewController.swift
//  Maraphon.Task2
//
//  Created by Roman Shukailo on 04.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    struct Constants {
        static let topMargin: CGFloat = 10
        static let buttonHeight: CGFloat = 44
    }
    
    enum ButtonState {
        case blue
        case gray
    }
    
    lazy var firstButton : UIButton = {
        let b = UIButton(type: .custom)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("First Button", for: .normal)
        b.setTitleColor(.white, for: [.normal,.highlighted,.selected])
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 10
        let image = UIImage(systemName: "arrow.right.circle.fill")?.withRenderingMode(.alwaysTemplate)
        b.tintColor = .white
        b.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        b.contentEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        b.semanticContentAttribute = .forceRightToLeft
        b.setImage(image, for: .normal)
        b.setImage(image, for: .selected)
        b.setImage(image, for: .highlighted)
        b.tag = 1
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchDown)
        b.addTarget(self, action: #selector(buttonReleased(_:)), for: [.touchUpInside,.touchUpOutside])
        return b
    }()
    
    lazy var secondButton : UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Second Medium Button", for: .normal)
        b.setTitleColor(.white, for: [.normal,.highlighted,.selected])
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 10
        let image = UIImage(systemName: "arrow.right.circle.fill")?.withRenderingMode(.alwaysTemplate)
        b.tintColor = .white
        b.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        b.contentEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        b.semanticContentAttribute = .forceRightToLeft
        b.setImage(image, for: .normal)
        b.setImage(image, for: .selected)
        b.setImage(image, for: .highlighted)
        b.tag = 2
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchDown)
        b.addTarget(self, action: #selector(buttonReleased(_:)), for: [.touchUpInside,.touchUpOutside])
        return b
    }()
    
    lazy var thirdButton : UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Third", for: .normal)
        b.setTitleColor(.white, for: [.normal,.highlighted,.selected])
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 10
        let image = UIImage(systemName: "arrow.right.circle.fill")?.withRenderingMode(.alwaysTemplate)
        b.tintColor = .white
        b.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        b.contentEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        b.semanticContentAttribute = .forceRightToLeft
        b.setImage(image, for: .normal)
        b.setImage(image, for: .selected)
        b.setImage(image, for: .highlighted)
        b.tag = 3
        b.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchDown)
        b.addTarget(self, action: #selector(buttonReleased(_:)), for: [.touchUpInside,.touchUpOutside])
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(firstButton)
        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: Constants.topMargin),
            firstButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        view.addSubview(secondButton)
        NSLayoutConstraint.activate([
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor,constant: Constants.topMargin),
            secondButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        view.addSubview(thirdButton)
        NSLayoutConstraint.activate([
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor,constant: Constants.topMargin),
            thirdButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
    @objc func buttonPressed(_ target: UIButton) {
           UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
               target.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
           })
       }
       
       @objc func buttonReleased(_ target: UIButton) {
           UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
               target.transform = CGAffineTransform.identity
           })
           
           if target.tag == 3 {
               changeStateButtons(with: .gray)
               showModalVC()
           }
       }
    
    private func showModalVC() {
        let modalVC = ModalViewController()
        modalVC.modalPresentationStyle = .formSheet
        modalVC.view.backgroundColor = .white
        modalVC.presentationController?.delegate = self
        present(modalVC, animated: true)
    }
    
    private func changeStateButtons(with newState : ButtonState) {
        let buttons = [firstButton,secondButton,thirdButton]
        switch newState {
        case .blue :
            for button in buttons {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
                button.imageView?.tintColor = .white
            }
        case .gray :
            for button in buttons {
                button.backgroundColor = .systemGray2
                button.setTitleColor(.systemGray3, for: .normal)
                button.tintColor = .systemGray3
            }
        }
    }
}

extension ViewController : UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            changeStateButtons(with: .blue)
        }
    }
}


class ModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


