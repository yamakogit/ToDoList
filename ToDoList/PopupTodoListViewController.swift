//
//  PopupTodoListViewController.swift
//  ToDoList
//
//  Created by K_Xcode on 2021/08/15.
//

import UIKit

class PopupTodoListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    //警告アラート準備
    var alertController: UIAlertController!
    
    //警告アラート
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    
    var searchTitle :String = ""
    var tagSearch : String = ""
    
    var saveData: UserDefaults = UserDefaults.standard
    var saveFilterSituation: UserDefaults = UserDefaults.standard
    var saveFilterArray: UserDefaults = UserDefaults.standard
    
    var todoData: [[String: Any]] = []
    
    
    var forTitleFilter: [[String: Any]] = []
    var forTagFilter: [[String: Any]] = []
    
    override func viewWillAppear(_ animated: Bool) {
        //        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func titleSearchButton() {
        
        let alertTitle = "タイトルを検索"
        let alertMessage = "検索したいタイトルを\n以下に入力してください。"
        let alert = UIAlertController (title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let addDefaultmMessageAction = UIAlertAction(title: "設定", style: .default, handler: { [self](action:UIAlertAction!) -> Void in
            if let search = alert.textFields?[0].text{
                self.searchTitle = search
                print("成功",self.searchTitle)
            }
            let data = self.saveData.array(forKey: "aTodo") as? [[String: Any]] ?? []
            self.todoData = data
            print("これ",self.todoData)
            
            for i in 0...self.todoData.count - 1 {
                
                let todocontent = self.todoData[i]
                let title:String = todocontent["Todotitle"] as! String  //Titleの値を取り出している
                print(title)
                if title == self.searchTitle {
                    
                    forTitleFilter = []
                    forTitleFilter.append(todocontent)
                    print("ここ！！",self.forTitleFilter)
                } else {
                    print("一致しないよ")
                }
            }
            
            self.saveFilterSituation.set(1,forKey: "filterSituation")
            
            self.saveFilterArray.set(forTitleFilter,forKey: "filterArray")
            
            let toDoListVC = storyboard?.instantiateInitialViewController() as? TodoListViewController
            toDoListVC?.tableView.reloadData()    //ここにも書いてみましたが、reloadできませんでした。
            
        })
        
        alert.addAction(addDefaultmMessageAction)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        alert.addTextField(configurationHandler: {(textfield:UITextField!) -> Void in
            textfield.placeholder = "タイトルを入力..."
            textfield.keyboardType = .default
        })
        self.present(alert, animated: true, completion: nil)
        
        
        
//
//        let data = saveData.array(forKey: "aTodo") as? [[String: Any]] ?? []
//        todoData = data
//        print("これ",todoData)
//
//
//        for i in 0...todoData.count - 1 {
//
//            let todocontent = todoData[i]
//            let title:String = todocontent["Todotitle"] as! String  //Titleの値を取り出している
//            print(title)
//            if title == self.searchTitle {
//                forTitleFilter.append(todocontent)
//                print("ここ！！",forTitleFilter)
//            } else {
//                print("一致しないよ")
//            }
//
            
            
            //            filter機能
            //            if time.filter{$0.containString.nowtime} == true {
            //                forFilter.append(todocontent)
            //                print(forFilter)
            //            } else {
            //            }
        
        
        
    }
    
    @IBAction func tagSearchButton() {
        
    }
    
    @IBAction func dateSearchButton() {
        
    }
    
    @IBAction func close1popup() {
            alert(title: "検索結果",message: "検索結果をセルに表示しました")
        dismiss(animated: false, completion: nil)
        let toDoListVC = storyboard?.instantiateInitialViewController() as? TodoListViewController
        toDoListVC?.tableView.reloadData()    //ここに書いてもらいましたが、reloadできませんでした。
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
