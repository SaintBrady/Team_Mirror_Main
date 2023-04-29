//
//  ViewController.swift
//  Team_Mirror
//
//  Created by Brayden M Dyke on 4/28/23.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func rosterView() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "roster_vc") as! RosterViewController
        present(vc, animated: true)
    }
    @IBAction func scheduleView() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "schedule_vc") as! ScheduleViewController
        present(vc, animated: true)
    }
    @IBAction func socialsView() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "socials_vc") as! SocialsViewController
        present(vc, animated: true)
    }
    @IBAction func buttonAction() {
        let speaker = Speaker()
        speaker.playSound()
    }
}

