//
//  LoginViewController.swift
//  WeatherApp-CSA
//
//  Created by Ирина Семячкина on 13.07.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet private weak var scrollView: UIScrollView?
    
    @IBOutlet private weak var backgroundImage: UIImageView? {
        didSet {
            backgroundImage?.image = UIImage(named: "backgroundImage")
            backgroundImage?.contentMode = .scaleAspectFill
        }
    }

    @IBOutlet private weak var appNameImage: UIImageView? {
        didSet {
            appNameImage?.image = UIImage(named: "appNameImage")
        }
    }
    
    @IBOutlet private weak var emailTextField: UITextField? {
        didSet {
            emailTextField?.placeholder = "test@test.com"
        }
    }
    
    @IBOutlet private weak var passwordTextField: UITextField? {
        didSet {
            passwordTextField?.placeholder = "•••••••••••"
        }
    }
    
    @IBOutlet private weak var loginButton: UIButton? {
        didSet {
            loginButton?.setTitle("login", for: .normal)
            loginButton?.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 23)
            loginButton?.setTitleColor(.white, for: .normal)
            loginButton?.titleLabel?.textAlignment = .center
            loginButton?.titleLabel?.shadowOffset = CGSize(width: 0, height: 2)
            loginButton?.setTitleShadowColor(UIColor.gray, for: .normal)
            
            loginButton?.backgroundColor = UIColor(red: 190 / 255, green: 152 / 255, blue: 115 / 255, alpha: 1)
            loginButton?.layer.cornerRadius = 10
            loginButton?.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            loginButton?.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            loginButton?.layer.shadowOpacity = 1.0
            loginButton?.layer.shadowRadius = 0.0
            loginButton?.layer.masksToBounds = false
        }
    }
    
    @IBOutlet private weak var registrationButton: UIButton? {
        didSet {
            registrationButton?.setTitle("registration", for: .normal)
            registrationButton?.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
            registrationButton?.setTitleColor(.white, for: .normal)
            registrationButton?.titleLabel?.textAlignment = .center
        }
    }

    
    private var listener: AuthStateDidChangeListenerHandle!
    
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        self.listener = Auth.auth().addStateDidChangeListener({ (_, user) in
            if user != nil {
                self.performSegue(withIdentifier: "toCitiesList", sender: nil)
                self.emailTextField?.text = nil
                self.passwordTextField?.text = nil
            }
        })
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
         self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(listener)
    }

    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addNotifications()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        
        self.addNotifications()
    }
    
    deinit {
        self.removeNotifications()
    }
    
    
    // MARK: - Notifications
    
    private func addNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWasShow(notification: Notification) {
        
        guard let userInfo = notification.userInfo as NSDictionary? else {
            return
        }
        
        guard let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        
        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: keyboardHeight,
                                         right: 0.0)
        
        self.scrollView?.contentInset = contentInsets
        self.scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        
        let contentInsets = UIEdgeInsets.zero
        
        self.scrollView?.contentInset = contentInsets
        self.scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    
    // MARK: - Actions
    
    @IBAction func loginButtonAction() {
        
        guard let email = self.emailTextField?.text,
            let password = self.passwordTextField?.text,
            email.count > 0, password.count > 0 else {
                
                self.showErrorAlert(title: "Error", message: "Login/password is not entered")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error, user == nil {
                self.showErrorAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func registrationButtonAction() {
        
        let alert = UIAlertController(title: "Register", message: "Plese, fill the form", preferredStyle: .alert)
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        alert.addTextField { textPassword in
            textPassword.placeholder = "Enter your password"
            textPassword.isSecureTextEntry = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let emailField = alert.textFields?[0],
                let passwordField = alert.textFields?[1],
                let email = emailField.text,
                let password = passwordField.text else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                if let error = error {
                    self.showErrorAlert(title: "Error", message: error.localizedDescription)
                } else {
                    Auth.auth().signIn(withEmail: email, password: password)
                }
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    private func showErrorAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func logOutAction(segue: UIStoryboardSegue) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch(let error) {
            print(error)
        }
    }
    
    @IBAction func closeKeyboardAction() {
        self.view.endEditing(true)
    }
}
