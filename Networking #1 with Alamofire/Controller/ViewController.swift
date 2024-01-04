//
//  ViewController.swift
//  Networking #1 with Alamofire
//
//  Created by Camilo L-Shide on 02/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var selectTopic: UIButton!
    
    @IBOutlet var topicsCollection: [UIButton]! // This time a collection of outlets is needed since we are changing all of those in conjunction.
    

    @IBAction func selectTopicPressed(_ sender: UIButton) {
        
        topicsCollection.forEach { btn in
            UIView.animate(withDuration: 0.7) {
                btn.isHidden = !btn.isHidden // Remember this one set the value to the oposite boolean.
                btn.alpha = btn.alpha == 0 ? 1 : 0 // This is read as "if btn.alpha is equal to 0, then assign it the value of 1, if not assign it the value of 0.
                btn.layoutIfNeeded()
            }
        }
        
    }
    
    @IBAction func mexicoPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "SelectionToTitle" , sender: "mexico") // We simply choose mexico as the sender since it is way easier. We know for a fact that by pressing this button we are selecting the topic.
    }
    
    @IBAction func videogamesPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "SelectionToTitle" , sender: "videogames") // Same thing with this one.
        
    }
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        selectTopic.layer.cornerRadius = selectTopic.frame.height / 2 // This help to make the pretty select title button a little rounded.
        
        topicsCollection.forEach { btn in
            btn.layer.cornerRadius = btn.frame.height / 2
            btn.isHidden = true
            btn.alpha = 0
        }
        
    }
    
    
    //This prepare is super important since it is how we will modify the "titleSelection" property in the TitleViewController.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectionToTitle" {
            let controller = segue.destination as? TitleViewController
            controller?.titleSelection = sender as! String // This line is literally telling the compiler to get the property of the controller TitleViewController to be equal as the sender SENT AS A PARAMETER in the performSegueMethod.
        }
    }


}

