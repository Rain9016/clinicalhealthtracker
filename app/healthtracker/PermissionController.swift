//
//  PermissionsController.swift
//  healthtracker
//
//  Created by untitled on 5/2/17.
//
//

import UIKit
import CoreLocation
import HealthKit
import CoreMotion
import UserNotifications

class PermissionController: UIViewController {
    var pages = [PermissionPage]()
    var heading = ""
    var content = ""
    var unicodeEscaped = ""
    var permission_requested = false
    
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
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.init(r: 204, g: 0, b: 0), for: .normal)
        button.setTitle("Allow", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(r: 204, g: 0, b: 0).cgColor
        button.layer.cornerRadius = 4
        
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    func handleButton() {
        if (!permission_requested) {
            switch self.heading {
            case "Location Services":
                guard CLLocationManager.locationServicesEnabled() else {
                    sendAlert(title: "Error", message: "In order to use this app, Location Services must be enabled. Please to go Settings > Privacy > Location Services and enable Location Services")
                    return
                }
            
                _ = LocationManager.sharedInstance
            case "HealthKit":
                _ = HealthKitManager.sharedInstance
            case "Motion & Fitness":
                _ = PedometerManager.sharedInstance
                
                button.backgroundColor = UIColor.init(r: 204, g: 0, b: 0)
                button.setTitleColor(UIColor.white, for: .normal)
                button.setTitle("Finish", for: .normal)
                button.layer.borderWidth = 0
                
                permission_requested = true
                return
            case "Notifications":
                if #available(iOS 10.0, *) {
                    let center = UNUserNotificationCenter.current()
                    center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                    }
                } else {
                    let settings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
                    UIApplication.shared.registerUserNotificationSettings(settings)
                }
            default:
                return
            }
            
            button.backgroundColor = UIColor.init(r: 204, g: 0, b: 0)
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitle("Next", for: .normal)
            button.layer.borderWidth = 0
            
            permission_requested = true
        } else {
            self.pages.remove(at: 0)
                
            if (pages.count > 0) {
                let controller = PermissionController()
                controller.pages = self.pages
                controller.heading = (pages.first?.heading)!
                controller.content = (pages.first?.content)!
                controller.unicodeEscaped = (pages.first?.unicodeEscaped)!
                    
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                UserDefaults.standard.set(true, forKey: "permissions_requested")
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.init(r: 204, g: 0, b: 0)
        
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
        button.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 22).isActive = true
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
        case "Notifications":
            imageView.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: 70).isActive = true //notifications
        default:
            break
        }
    }
}
