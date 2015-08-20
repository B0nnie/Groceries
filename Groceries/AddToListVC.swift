//
//  AddToListVC.swift
//  Groceries
//
//  Created by Ebony Nyenya on 8/18/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit

protocol addItemsToMainList{
    
    func sendArrayData(array: [String])
}

class AddToListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var enterItemFld: UITextField!
    
    var itemsArray = [String]()
    
    var delegate : addItemsToMainList?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterItemFld.becomeFirstResponder()
        
        enterItemFld.delegate = self
        
        self.addDoneButtonOnKeyboard()
        
        var tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func addToShortList(sender: AnyObject) {
        
        addToList()
        
    }
    
    func addToList() {
        
        itemsArray.append(enterItemFld.text)
        
        enterItemFld.text = ""
        
        tableView.reloadData()
        
    }
    
    
    @IBAction func addToLongList(sender: AnyObject) {
        
        delegate?.sendArrayData(itemsArray)
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return itemsArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = itemsArray[indexPath.row]
        
        return cell
    }
    
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            itemsArray.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    //return button on keyboard to have same functionality as add button next to textfield
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        addToList()
        view.endEditing(true)
        enterItemFld.becomeFirstResponder()
        return false
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
        
        var items = NSMutableArray()
        items.addObject(flexSpace)
        items.addObject(done)
        
        doneToolbar.items = items as [AnyObject]
        doneToolbar.sizeToFit()
        
        enterItemFld.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction()
    {
        self.enterItemFld.resignFirstResponder()
        
    }
    
    func dismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
