//
//  ViewController.swift
//  Player
//
//  Created by user on 6/6/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var music = ["Pentatonix - Can't Sleep Love", "Pentatonix_-_Cheerleader", "Erik Satie-Je Te Veux - Valse www.myfreemp3.click "]
    
    let cellReuseIdentifier = "cell"
    
    var player: AVAudioPlayer?
    
    var time = Timer()
    
    @IBAction func play(_ sender: Any) {
        player?.play()
    }
    
    @IBAction func stop(_ sender: Any) {
        if(player?.isPlaying)!{
            player?.stop()
        }
    }
    
    
    @IBOutlet weak var Slider: UISlider!
    
    
    @IBOutlet weak var VolSlide: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
        Slider.setThumbImage(UIImage(named:"thumb"), for: .normal)
        
        VolSlide.setThumbImage(UIImage(named:"thumb"), for: .normal)
       // _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateSlider), userInfo: nil, repeats: true)
        
        
       // Slider.maximumValue = Float((player?.duration)!)
        
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.music.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.music[indexPath.row]
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.highlightedTextColor = UIColor.black
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playSound(index: indexPath.row)
       
        
        print("You tapped cell number \(indexPath.row).")
    }
    
    
    
    
    func playSound(index: Int) {
        
        time.invalidate()
        
        
        
       
        
        
        guard let url = Bundle.main.url(forResource: music[index], withExtension: "mp3") else {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.play()
            
             Slider.maximumValue = Float((player.duration))
                 time = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.updateSlider), userInfo: nil, repeats: true)
            
        } catch let error {
            print(error.localizedDescription)
        }    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            music.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
    
    
    @IBAction func vol(_ sender: UISlider) {
        let selectedValue = Float(sender.value)
        player?.volume = selectedValue
    }
    
    
    
    @IBAction func ChangeAudioTime(_ sender: AnyObject) {
        player?.stop()
        player?.currentTime = TimeInterval(Float(Slider.value))
        player?.prepareToPlay()
        player?.play()
    }
    
    
    func updateSlider(){
        Slider.value = Float((player?.currentTime)!)
    }

    override func didReceiveMemoryWarning
        () {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

