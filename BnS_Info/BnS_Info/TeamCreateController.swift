//
//  TeamCreateController.swift
//  BnS_Info
//
//  Created by 표영권 on 2017. 5. 11..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

class TeamCreateController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var leader: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    //11, 21, 22, 23
    var pickerData = ["밤의 바람평야","검은 마천루","서자의 안식처", "소용돌이 사원"]
    
    @IBAction func BackToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row] as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerData[row])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
