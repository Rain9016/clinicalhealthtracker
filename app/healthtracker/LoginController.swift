//
//  LoginController.swift
//  healthtracker
//
//  Created by untitled on 1/2/17.
//
//

import UIKit

class LoginController: UIViewController {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Unique ID"
        textField.font = textField.font?.withSize(14)
        textField.textAlignment = .center
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        /* http://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield */
        //textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
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
        let imageName = "app-icon"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "healthapp"
        label.font = UIFont(name: "Lobster 1.4", size: 40)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        
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
        let request: URLRequest = {
            let urlString = "http://cht.dev/web-service/authenticate.php"
            let url = URL(string: urlString)
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            
            let postParameters = "unique_id=" + textField.text!;
            
            request.httpBody = postParameters.data(using: String.Encoding.utf8)
            return request
        }()
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                print("error", error.debugDescription)
                return
            }
            
            /* https://developer.apple.com/swift/blog/?id=37 */
            do {
                let data = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                let err = data["error"] as! Bool
                
                if err {
                    DispatchQueue.main.async {
                        self.sendAlert(title: "Error", message: data["message"] as! String)
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(self.textField.text, forKey: "unique_id")
                        self.dismiss(animated: false, completion: nil)
                    }
                }
            } catch {
                print("error", error.localizedDescription)
                return
            }
        })
        
        task.resume()
    }
    
    func handleButton() {
        if textField.text == "" {
            sendAlert(title: "Error", message: "Please enter your unique ID")
        } else {
            UserDefaults.standard.set(self.textField.text, forKey: "unique_id") //DELETE!
            self.dismiss(animated: false, completion: nil) //DELETE!
            //authenticate()
        }
    }
}
