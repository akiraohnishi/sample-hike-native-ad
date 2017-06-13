//
//  ViewController.swift
//  sample-hike-native-ad
//
//  Created by Akira Ohnishi on 2017/06/13.
//  Copyright © 2017年 Akira Ohnishi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    lazy var tableView: UITableView = {
        return UITableView(frame: .zero, style: .plain)
    }()

    let contents = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    let adSpotId = "OTA2OjMy"
    let adCount:UInt = 2
    let positions = [1,4]
    let instreamAdLoader = ADVSInstreamAdLoader.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)

        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self

        // Load HIKE advertisements
        instreamAdLoader.delegate = self
        instreamAdLoader.advSbind(to: tableView, adSpotId: adSpotId)

        instreamAdLoader.advSloadAd(adCount, positions: positions)
//        instreamAdLoader.advSloadAd()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")

        cell.textLabel?.text = contents[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension ViewController: ADVSInstreamAdLoaderDelegate {
    func advSinstreamAdLoaderDidStartLoadingAd(_ instreamAdLoader: ADVSInstreamAdLoader!) {
        NSLog("ADVSinstreamAdLoaderDidStartLoadingAd")
    }

    func advSinstreamAdLoaderDidFinishLoadingAd(_ instreamAdLoader: ADVSInstreamAdLoader!) {
        NSLog("ADVSinstreamAdLoaderDidFinishLoadingAd")
    }

    func advSinstreamAdLoaderDidFinishLoadingAdImage(_ adIndexPath: IndexPath!) {
        NSLog("ADVSinstreamAdLoaderDidFinishLoadingAdImage:row=%d:section=%d", adIndexPath.row, adIndexPath.section)
    }

    func advSinstreamAdLoaderDidFinishSendingAdClick() {
        NSLog("ADVSinstreamAdLoaderDidFinishSendingAdClick")
    }

    @objc(ADVSinstreamAdLoader:didFailToLoadAdWithError:)
    func advSinstreamAdLoader(_ instreamAdLoader: ADVSInstreamAdLoader!, didFailToLoadAdWithError error: Error!) {
        NSLog("ADVSinstreamAdLoader:didFailToLoadAdWithError:%@", error as NSError)
    }

    @objc(ADVSinstreamAdLoader:didFailToLoadAdImageWithError:)
    func advSinstreamAdLoader(_ adIndexPath: IndexPath!, didFailToLoadAdImageWithError error: Error!) {
        NSLog("ADVSinstreamAdLoader:didFailToLoadAdImageWithError:%@", error as NSError)
    }
}

extension ViewController: ADVSExceptionDelegate {
    func advSexceptionOccured(_ error: Error!) {
        NSLog("advSexceptionOccured:%@", error as NSError)
    }
}
