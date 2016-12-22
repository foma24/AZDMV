//
//  EntryTableViewController.swift
//  DMV
//
//  Created by Apollo Zhu on 12/21/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }

    private func subSectionAtIndexPath(_ indexPath: IndexPath) -> Manual.SubSection {
        return manual.subsections[indexPath.section][indexPath.row]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return manual.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manual.subsections[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return manual.sections[section]
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.font = UIFont(name: "icomoon", size: headerView.textLabel!.font.pointSize)
            headerView.textLabel?.adjustsFontSizeToFitWidth = true
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sub = subSectionAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: sub.hasQuiz ? Identifier.NormalReusableTableViewCell : Identifier.NoQuizReusableTableViewCell, for: indexPath)
        cell.textLabel?.text = sub.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if subSectionAtIndexPath(indexPath).hasQuiz {
            performSegue(withIdentifier: Identifier.ShowQuestionListSegue, sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.ShowQuestionListSegue,
            let vc = segue.terminus as? QuestionListViewController {
            vc.setup(tableView.indexPathForSelectedRow!)
        }
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }

}