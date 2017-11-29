//
//  LoginController.swift
//  healthtracker
//
//  Created by untitled on 1/2/17.
//
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Unique ID"
        textField.font = textField.font?.withSize(14)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        /* http://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield */
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.init(r: 204, g: 0, b: 0)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let container: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        return container
    }()
    
    let imageView: UIImageView = {
        let imageName = "Icon"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "healthtracker"
        label.font = UIFont(name: "Lobster 1.4", size: 40)
        label.textAlignment = .center
        return label
    }()
    
    let activityIndicator = ActivityIndicator.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.textField.delegate = self
        
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        
        view.addSubview(container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -10).isActive = true
        
        container.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        container.addSubview(label)
        
        let labelSize: CGSize = label.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: labelSize.width + 6).isActive = true
        label.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: -3).isActive = true
        label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        container.heightAnchor.constraint(equalToConstant: 60).isActive = true
        container.widthAnchor.constraint(equalToConstant: 60 + labelSize.width + 3).isActive = true
    }
    
    func authenticate() {
        self.activityIndicator.showActivityIndicator(uiView: self.view)
        
        let environment = Environment.shared
        
        //let urlString = environment.production.url + "authenticate.php"
        let urlString = environment.development.url + "authenticate.php"
        
        guard let url = URL(string: urlString) else {
            print("Could not generate URL from urlString")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let uniqueId = textField.text else {
            print("uniqueId is nil")
            return
        }
        
        let parameters = ["uniqueId": uniqueId]
        
        guard let json = try? JSONEncoder().encode(parameters) else {
            print("parameters could not be encoded as JSON")
            return
        }
        request.httpBody = json
        
        let session = URLSession.shared
        
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.activityIndicator.hideActivityIndicator(uiView: self.view)
                    self.sendAlert(title: "Error", message: error.localizedDescription)
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                if (statusCode != 200) {
                    DispatchQueue.main.async {
                        self.activityIndicator.hideActivityIndicator(uiView: self.view)
                        self.sendAlert(title: "Error", message: "Status Code: \(statusCode)")
                    }
                    return;
                }
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.activityIndicator.hideActivityIndicator(uiView: self.view)
                    self.sendAlert(title: "Error", message: "Could not retrieve a response from the API")
                }
                return;
            }
            
            /* https://developer.apple.com/swift/blog/?id=37 */
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                
                if (apiResponse.error) {
                    DispatchQueue.main.async {
                        self.activityIndicator.hideActivityIndicator(uiView: self.view)
                        self.sendAlert(title: "Error", message: apiResponse.message)
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.activityIndicator.hideActivityIndicator(uiView: self.view)
                        UserDefaults.standard.set(self.textField.text, forKey: "uniqueId")
                        self.dismiss(animated: false, completion: nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.activityIndicator.hideActivityIndicator(uiView: self.view)
                    self.sendAlert(title: "Error", message: "Could not decode JSON response")
                }
                return;
            }
        }).resume()
    }
    
    @objc func handleButton() {
        if textField.text == "" {
            sendAlert(title: "Error", message: "Please enter your unique ID")
        } else {
            authenticate()
        }
    }
    ////////////////////////
    //                    //
    //  DISMISS KEYBOARD  //
    //                    //
    ////////////////////////
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
}
