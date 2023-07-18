//
//  ViewController.swift
//  Price Bitcoin
//
//  Created by Jefferson Oliveira de Araujo on 29/09/21.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var priceBtc: UILabel!
    @IBOutlet weak var buttonUpdate: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editionButton()
        getDataApi()
    }
    
    @IBAction func updatePrice(_ sender: Any) {
        getDataApi()
    }
    
    func editionButton() {
        buttonUpdate.setTitle("Clique para atualizar", for: .normal)
        buttonUpdate.layer.cornerRadius = 10
        buttonUpdate.layer.shadowColor = UIColor.black.cgColor
        buttonUpdate.layer.shadowOpacity = 0.9
        buttonUpdate.layer.shadowOffset = CGSize.init(width: 3, height: 5)
    }
    
    func formatterPrice(price: NSNumber) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let priceFinal = nf.string(from: price) {
            return "R$ " + priceFinal
        }
        return "R$ 0,00"
    }
    
    func getDataApi() {
        
        buttonUpdate.setTitle("Atualizando...", for: .normal)
        loading.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            
            if let url = URL(string: "https://blockchain.info/ticker") {
                let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if error == nil {
                        if let dataReturn = data {
                            do {
                                if let objectJson = try JSONSerialization.jsonObject(with: dataReturn, options: []) as? [String: Any] {
                                    print(objectJson)
                                    if let brl = objectJson["BRL"] as? [String: Any] {
                                        print(brl)
                                        if let price = brl["buy"] as? Double {
                                            print(price)
                                            let priceFormatted = self.formatterPrice(price: NSNumber(value: price))
                                            
                                            DispatchQueue.main.async(execute: {
                                                self.priceBtc.text = priceFormatted
                                                self.buttonUpdate.setTitle("Clique para atualizar", for: .normal)
                                                self.loading.isHidden = true
                                            })
                                        }
                                    }
                                }
                            } catch {
                                print("Erro ao formatar o retorno.")
                            }
                        }
                    } else {
                        print("Erro ao fazer a consulta do preço.")
                    }
                }
                dataTask.resume()
            }
            
        }
    }
}
