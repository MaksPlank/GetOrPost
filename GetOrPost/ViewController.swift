//
//  ViewController.swift
//  GetOrPost
//
//  Created by Maks Plank on 25.09.2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var getOutlet: UIButton!
    @IBOutlet weak var postOutlet: UIButton!
    let link = "https://jsonplaceholder.typicode.com/posts"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOutlet.layer.cornerRadius = 20
        getOutlet.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        postOutlet.layer.cornerRadius = 20
        postOutlet.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }

    // MARK: - to GET -
    // Отправляет запрос и получает JSON-файл
    func requestURL(WithURL urlString: String) {
        guard let url = URL(string: urlString) else { return } // URL?
        
        
        let session = URLSession.shared // синглтон
        session.dataTask(with: url) { (data, response, error) in
              guard let response = response else { return }
                    print("GET Response ♥️ \(response)") // см консоль (JSON) & Status Code: 200
                
              guard let data = data else { return }
                    print("DATA 🟣 \(data)")
                 do {
                 let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("JSON 🔆 \(json)")
                 } catch {
                    print("ERROR ❗️ \(error)")
                    }
              }.resume() // sending post request
        }

            
    
    // MARK: - GET Request -
    // Получение данных :
    @IBAction func getRequest(_ sender: UIButton) {
        requestURL(WithURL: link)
        }
    
    

    
    
    // MARK: - POST Request -
    // отправление данных
    @IBAction func postRequest(_ sender: UIButton) {
        let parameters = ["name" : "Natalia", "msg" : "Hello"] // для отправки
        guard let url = URL(string: link) else { return }
        
        var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response else { return }
                print("POST Response ♥️ \(response)")
            guard let data = data else { return }
                print("DATA 🟣 \(data)")
            do {
               let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON 🔆 \(json)")
            } catch {
                print("ERROR ❗️ \(error)")
                }
            
            }.resume()
        
        }
    
    
}




