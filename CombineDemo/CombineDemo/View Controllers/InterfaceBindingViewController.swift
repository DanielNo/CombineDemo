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
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        timerInCombine()
    }
    
    func timerInCombine(){
        self.timerSub = Timer.publish(every: 1.0, on: RunLoop.current, in: .default).autoconnect().throttle(for: 1.0, scheduler: RunLoop.main, latest: true)
            .sink { [unowned self] timerOutput in
                self.timerLabel.text = "\(timerOutput)"
            }
    }
    

}
