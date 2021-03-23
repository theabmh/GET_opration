//
//  ViewController.swift
//  Get_trial_3_Pragati
//
//  Created by iroid on 23/03/21.
//  Copyright © 2021 iroid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var Pimg: UIImageView!
    
    @IBOutlet var Pid: UITextField!
    
    @IBOutlet var DisTxt: UITextField!
    
    @IBOutlet var Pname: UITextField!
    
    @IBOutlet var BaridTXT: UITextField!
    
    @IBOutlet var oldPricetxt: UITextField!
    
    
    @IBOutlet var newpricetxt: UITextField!
    
    
    var Prname = String()
    var prid = String()
    var newPrice = String()
    var oldPrice = ""
    var Discount = ""
    var ProDuctID = ""
    
    var getData = NSMutableData()
    var Jsondata = NSDictionary()
    var jsonDataArray = NSArray()
    var jsonDataArrayDict = NSDictionary()
    
    override func viewWillAppear(_ animated: Bool) {
        let JsonUrl = URL(string:"http://iroidtechnologies.in/Pragati_hub/Pragati_Api/mobile")
        let request = URLRequest(url: JsonUrl!)
        
      let Task = URLSession.shared.dataTask(with: request){(data,request,error)in
        if let mydata = data {
            
            print("Mydata>>>>",mydata)
        
            do{
             
                self.getData.append(mydata)
                
                self.Jsondata = try JSONSerialization.jsonObject(with: self.getData as Data, options: []) as! NSDictionary
                print("Jsondata>>>",self.Jsondata)
                self.jsonDataArray = self.Jsondata["data"] as! NSArray
                self.jsonDataArrayDict = self.jsonDataArray[0] as! NSDictionary
                do{
                    DispatchQueue.main.async {
                        
                        self.prid = String(describing:self.jsonDataArrayDict["pid"]!)
                        self.Prname = String(describing:self.jsonDataArrayDict["productname"]!)
                        self.Discount = String(describing:self.jsonDataArrayDict["discount"]!)
                        self.newPrice = String(describing:self.jsonDataArrayDict["newprice"]!)
                        self.oldPrice = String(describing:self.jsonDataArrayDict["oldprice"]!)
                        self.ProDuctID = String(describing:self.jsonDataArrayDict["productid"]!)
                        let imageUrl = URL(string:String(describing:self.jsonDataArrayDict["image1"]!))
                        let dataimg  = try? Data(contentsOf:imageUrl!)
                        
                        self.Pid.text = self.prid
                        self.Pname.text = self.Prname
                        self.BaridTXT.text = self.ProDuctID
                        self.newpricetxt.text=self.newPrice
                        self.oldPricetxt.text=self.oldPrice
                        self.DisTxt.text=self.Discount
                        self.Pimg.image = UIImage(data:dataimg!)
                        
                    }
                    
                }
                
            }
            catch{
                print(error.localizedDescription)
            }
            
            }
        }
        Task.resume()
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }



}

