//
//  ReactiveViewController.swift
//  CombineDemo
//
//  Created by Daniel No on 7/13/21.
//

import UIKit
import Combine

class ReactiveViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    // Combine
    // Keep a single reference to the subscription so it's only cancelled when we are deallocated.
    private var usernameSubscription: AnyCancellable?
    private var passwordSubscription: AnyCancellable?
    private var validatedUserAndPasswordSubscription: AnyCancellable?

    // Another option: Store multiple subscriptions in a collection
    var subscriptions : Set<AnyCancellable> = []
    
    var usernameSubject : CurrentValueSubject<String,Never> = CurrentValueSubject("")
    var passwordSubject : CurrentValueSubject<String,Never> = CurrentValueSubject("")
    


    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        self.createPipeline()
    }
    
    func createPipeline(){
        usernameSubject
        .sink { completion in
            print(completion)
        } receiveValue: { username in
            print("username : \(username)")
        }.store(in: &subscriptions)

        validatedUserAndPasswordSubscription = Publishers.CombineLatest(usernameSubject, passwordSubject).map { user,pass in
            return user.count > 5 && pass.count > 5
        }.eraseToAnyPublisher().sink(receiveValue: { isValid in
            print("username and password are valid :\(isValid)")
            self.submitButton.isEnabled = isValid
        })
        
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else{
            return
        }
        if textField == usernameTextField{
            usernameSubject.send(text)
        }else if textField == passwordTextField{
            passwordSubject.send(text)
        }
    }
    @IBAction func signupBtnPressed(_ sender: Any) {
        print("Signing up with username : \(usernameSubject.value)")
        print("Signing up with password : \(passwordSubject.value)")
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
