//
//  PermissionsController.swift
//  healthtracker
//
//  Created by untitled on 5/2/17.
//
//

import UIKit

class PermissionController: UIViewController {
    var pages = [PermissionPage]()
    var heading = ""
    var content = ""
    var unicodeEscaped = ""
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 204, g: 0, b: 0)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Allow", for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    func handleButton() {
        switch self.heading {
        case "Location Services":
            print("location services")
            _ = LocationManager.sharedInstance
        case "HealthKit":
            print("healthkit")
        case "Motion & Fitness":
            print("motion & fitness")
        default:
            print("default")
        }
        
        self.pages.remove(at: 0)
        
        if (pages.count > 0) {
            let controller = PermissionController()
            controller.pages = self.pages
            controller.heading = (pages.first?.heading)!
            controller.content = (pages.first?.content)!
            controller.unicodeEscaped = (pages.first?.unicodeEscaped)!
            
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            UserDefaults.standard.set(true, forKey: "permissions_set")
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        headingLabel.text = heading
        contentLabel.text = content
        
        view.addSubview(headingLabel)
        view.addSubview(contentLabel)
        view.addSubview(button)
        
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headingLabel.bottomAnchor.constraint(equalTo: contentLabel.topAnchor, constant: -20).isActive = true
        headingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        contentLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let label = UILabel()
        label.font = UIFont.init(name: "Ionicons", size: 500)
        label.textColor = UIColor(r: 204, g: 0, b: 0)
        label.alpha = 0.05
        label.text = unicodeEscaped
        let labelSize: CGSize = label.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        label.frame = CGRect(x: 0, y: 0, width: labelSize.width, height: labelSize.height)
        let image = UIImage.imageWithLabel(label: label)
        let imageView = UIImageView(image: image)
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        switch self.heading {
        case "Location Services":
            imageView.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 75).isActive = true //location services
        case "HealthKit":
            imageView.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 80).isActive = true //healtkit
        case "Motion & Fitness":
            imageView.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 50).isActive = true //motion & fitness
        default:
            break
        }
    }
}
