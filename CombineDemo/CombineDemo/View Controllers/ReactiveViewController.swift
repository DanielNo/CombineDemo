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
    
    @Published var usernameText : String = ""
    @Published var passwordText : String = ""
    
    @IBOutlet weak var submitButton: UIButton!
    // Keep a reference to the subscription so it's
    // only cancelled when we are deallocated.
    private var usernameSubscription: AnyCancellable?
    private var passwordSubscription: AnyCancellable?

    var subscriptions : Set<AnyCancellable> = []
    
    var usernameSubject : CurrentValueSubject<String,Never> = CurrentValueSubject("")
    var passwordSubject : CurrentValueSubject<String,Never> = CurrentValueSubject("")

//    var validPasswordSubject : CurrentValueSubject<Bool,Never> = CurrentValueSubject(false)
//    var validUsernameSubject : CurrentValueSubject<Bool,Never> = CurrentValueSubject(false)

    
    private var stream: AnyCancellable?


    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        self.createPipeline()
    }
    
    func createPipeline(){
        self.usernameSubscription = usernameSubject.filter({ str in
            return str.count > 5
        })
        .sink { completion in
            print(completion)
        } receiveValue: { username in
            print("username : \(username)")
        }
        
        let valid = usernameSubject.map { return $0        }.sink { completion in
            print(completion)
        } receiveValue: { isValid in
            print("is valid username : \(isValid)")
        }

        stream = Publishers.CombineLatest(usernameSubject, passwordSubject).map { a,b in
            return a.count > 5 && b.count > 5
        }.eraseToAnyPublisher().sink(receiveValue: { isValid in
            print("username and password are valid :\(isValid)")
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
        print("username : \(usernameSubject.value)")
        print("password : \(passwordSubject.value)")

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
