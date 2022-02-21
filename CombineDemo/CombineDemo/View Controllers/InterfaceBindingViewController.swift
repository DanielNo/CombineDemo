//
//  InterfaceBindingViewController.swift
//  CombineDemo
//
//  Created by Daniel No on 7/13/21.
//

import UIKit
import Combine

class InterfaceBindingViewController: UIViewController {

    var timerSub : AnyCancellable?
    var valueSubject : CurrentValueSubject<Int, Never>?
    var subs : Set<AnyCancellable> = Set()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        timerInCombine()
        combineSubject()
    }
    
    func timerInCombine(){
        self.timerSub = Timer.publish(every: 1.0, on: RunLoop.current, in: .default).autoconnect().throttle(for: 0.0, scheduler: RunLoop.current, latest: true)
            .sink { [unowned self] timerOutput in
                self.timerLabel.text = "\(timerOutput)"
            }
    }
    
    func combineSubject(){
        valueSubject = CurrentValueSubject(0)
        valueSubject?.throttle(for: 0.1, scheduler: RunLoop.main, latest: true).sink(receiveValue: { num in
            self.subjectLabel.text = "value : \(num)"
        }).store(in: &subs)
        
    }
    
    func combinePassthroughSubject(){
        let pass = PassthroughSubject<String,Never>().sink { str in
            
        }
    }
    
    @IBAction func decrement(_ sender: Any) {
        valueSubject?.send(valueSubject!.value - 1)
    }
    
    @IBAction func increment(_ sender: Any) {
        valueSubject?.send(valueSubject!.value + 1)

    }
}
