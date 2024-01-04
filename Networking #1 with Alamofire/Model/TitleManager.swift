//
//  TitleManager.swift
//  Networking #1 with Alamofire
//
//  Created by Camilo L-Shide on 02/01/24.
//

import Foundation
import Alamofire

//This service delegate does help to transport the decoded data to the TitleViewController from the parseJSON method on this class

public protocol ServiceDelegate {
    func onSuccess(data: [TitleData1]) // This two functions will be implemented on the TitleViewController class
    func onError(error: String) // This one will show an alert
}

struct TitleManager {
    
    var titleSelection = "" // This pr0perty is indeed filled by the
    var delegate : ServiceDelegate?
    
    let titleURL = "https://reddit.com/r/"
    
    mutating func fetchTitle (titleSelection: String, delegate : ServiceDelegate) {
        
        let urlString = "\(titleURL)\(titleSelection)/.json"
        self.titleSelection = titleSelection
        self.delegate = delegate
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString : String) {
        
        AF.request(urlString).responseDecodable(of: TitleData.self, queue: .main, decoder: JSONDecoder()){ response in
            // Effectively this line of code makes the job of making the call and decode the Data by using the jSON Decoder.
            
            switch response.result { // We do this to handle both the success and failure cases.
                
            case .success(let titleData):  //This is the success one
                
                self.delegate?.onSuccess(data: titleData.data.children) //With the delegate we do send the chlidren array to the TitleViewController so we can get get a hold of its data property and the most important info, the title. We choosed to pass the chlidren or TitleData1 object because, since that is an array, we can easily get a hold of every element of it with the tableview datasource methods, that way we avoid having to store all of the tiltes in another array and pass it to the TitleViewController (the less code the better) and we can make it dinamic and avoid bugs or crashes in case that the number of objects on the array increases at some point. 
                
            case .failure(let error):
                
                let error = error.localizedDescription
                
                self.delegate?.onError(error: error) // On this two lines we basically convert the error from Error type to string so it can be used.
            }
            
            
        }
        
        // MARK: - Just take a look at the beast of code we simplified with alamofire
        
       /* func performRequest(urlString : String){
            // 1-.Create a URL
            if let url = URL(string: urlString){
                // 2-. Create a URLSession
                let session = URLSession(configuration: .default)
                // 3-. Give a task to the session
                let task = session.dataTask(with: url) { data, response, error in
                    if error != nil{
                        print(error!)
                    }
                    if let safeData = data {
                        /*let dataString = String(data: safeData, encoding: .utf8)
                        print(dataString!) */
                        self.parseJSON(titleData: safeData)
                    }
                }
                // 4-. Start the task
                task.resume()
            }
            
        } */
        
        //TWO FUNCTIONS IN TOTAL INSTEAD OF A SINGLE ONE
        
       /* func parseJSON(titleData : Data){
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(TitleData.self, from: titleData)
                
                self.delegate?.onSuccess(data: decodedData.data.children) // In this line, what we strive to pass to the TitleViewController is the JSON children array because that is indeed the array that contains all of the Data1 objects that contain the title inside them. By pasing this chlidren array we won't have to use an array to get a hold of every title since the indexPath.row property from the cellForRowAt method will help us to populate each cell by diving into the children object property until we get to the title.
            } catch{
                print(error.localizedDescription)
                
                self.delegate?.onError(error: error.localizedDescription) // We do sent an explanation of the error that could be used to show an alert
                
            }
            
        } */
    }
}
