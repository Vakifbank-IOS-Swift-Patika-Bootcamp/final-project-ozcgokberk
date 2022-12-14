//
//  LanguageViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 13.12.2022.
//

import UIKit
import L10n_swift

class LanguageViewController: UIViewController {

    let languages: [LanguageEnum] = [.TR, .EN]
    @IBOutlet weak var languagesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        // Do any additional setup after loading the view.
    }

    private func viewSetup() {
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
        languagesTableView.register(UINib(nibName: "LanguageTableViewCell", bundle: nil), forCellReuseIdentifier: "LanguageTableViewCell")
        languagesTableView.separatorColor = .white
    }
    private func setLanguage(selectedLang: LanguageEnum) {
        L10n.shared.language = selectedLang.rawValue.lowercased()
        NotificationCenter.default.post(name: .RefreshTableView, object: nil)
    }
}
extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell") as? LanguageTableViewCell else { return UITableViewCell()}
        let selectedLang = languages[indexPath.row]
        cell.languageLabel.text = selectedLang.description
        cell.languageImg.image = selectedLang.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setLanguage(selectedLang: languages[indexPath.row])
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
