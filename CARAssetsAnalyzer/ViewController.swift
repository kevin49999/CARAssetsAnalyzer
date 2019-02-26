//
//  ViewController.swift
//  CARAssetsAnalyzer
//
//  Created by Kevin Johnson on 2/20/19.
//  Copyright © 2019 Kevin Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let byteCountFormatter: ByteCountFormatter = ByteCountFormatter()
    private var assetInfo: [AssetInfo] = [AssetInfo]()

    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAssets()
    }
    
    // MARK: - Load Assets
    
    func loadAssets() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let assetsFileURL = Bundle.main.resourceURL?.appendingPathComponent("assets.json") else {
                assertionFailure("Missing assets.json file 👻")
                return
            }
            
            do {
                let assetsData = try Data(contentsOf: assetsFileURL)
                let jsonObject = try JSONSerialization.jsonObject(with: assetsData)
                guard let jsonObjects: [JSON] = jsonObject as? [JSON] else {
                    assertionFailure("Could not cast jsonObject to [JSON] 👻")
                    return
                }

                self.assetInfo = jsonObjects.compactMap { AssetInfo(json: $0) }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                assertionFailure("Error serializing json: \(error.localizedDescription) 👻")
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func tapActionBarButtonItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let bySizeTitle = NSLocalizedString("Filter by Size", comment: "")
        let bySizeAction = UIAlertAction(title: bySizeTitle, style: .default, handler: { _ in
            self.assetInfo.sort(by: { $0.bytes > $1.bytes })
            self.tableView.reloadData()
        })
        alertController.addAction(bySizeAction)
        
        let bySizeReversedTitle = NSLocalizedString("Filter by Size - Reversed", comment: "")
        let bySizeReversedAction = UIAlertAction(title: bySizeReversedTitle, style: .destructive, handler: { _ in
            self.assetInfo.sort(by: { $0.bytes < $1.bytes })
            self.tableView.reloadData()
        })
        alertController.addAction(bySizeReversedAction)
        
        let byNameTitle = NSLocalizedString("Filter by Name", comment: "")
        let byNameAction = UIAlertAction(title: byNameTitle, style: .default, handler: { _ in
            self.assetInfo.sort(by: { $0.imageName < $1.imageName })
            self.tableView.reloadData()
        })
        alertController.addAction(byNameAction)
        
        let byNameReversedTitle = NSLocalizedString("Filter by Name - Reversed", comment: "")
        let byNameReversedAction = UIAlertAction(title: byNameReversedTitle, style: .destructive, handler: { _ in
            self.assetInfo.sort(by: { $0.imageName > $1.imageName })
            self.tableView.reloadData()
        })
        alertController.addAction(byNameReversedAction)
        
        let cancelTitle = NSLocalizedString("Cancel", comment: "")
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assetInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AssetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AssetTableViewCell") as! AssetTableViewCell
        let info = assetInfo[indexPath.row]
        let imageName = info.imageName
        let sizeString = byteCountFormatter.string(fromByteCount: info.bytes)
        let viewModel = AssetTableViewCell.ViewModel(imageName: imageName,
                                                     sizeString: sizeString)
        cell.configure(viewModel: viewModel)
        
        return cell
    }
}
