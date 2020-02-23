//
//  ContentTypeSelectionViewController.swift
//  KeyboardPreview
//
//  Created by Filip Němeček on 23/02/2020.
//  Copyright © 2020 Filip Němeček. All rights reserved.
//

import UIKit

typealias TextContentType = (type: UITextContentType, name: String)

class ContentTypeSelectionViewController: UITableViewController {
    
    
    
    var didSelectContentType: ((TextContentType?) -> Void)?
    
    var previousContentType: TextContentType?
    
    private let nameContentTypes: [TextContentType] = [
        (.name, "Name"),
        (.namePrefix, "Name Prefix"),
        (.givenName, "Given Name"),
        (.middleName, "Middle Name"),
        (.familyName, "Family Name"),
        (.nameSuffix, "Name Suffix"),
        (.nickname, "Nickname")
    ]
    
    private let workContentTypes: [TextContentType] = [
        (.jobTitle, "Job Title"),
        (.organizationName, "Organization Name")
    ]
    
    private let addressContentTypes: [TextContentType] = [
        (.location, "Location"),
        (.fullStreetAddress, "Full Street Address"),
        (.streetAddressLine1, "Street Address Line 1"),
        (.streetAddressLine2, "Street Address Line 2"),
        (.addressCity, "City"),
        (.addressState, "State"),
        (.addressCityAndState, "City and State"),
        (.sublocality, "Sublocality"),
        (.countryName, "Country Name"),
        (.postalCode, "Postal Code")
    ]
    
    lazy var sections = [
        Section(contentTypes: nil),
        Section(contentTypes: nameContentTypes)
    ]
    
    private let contentTypes: [UITextContentType] = [
    
    
    .jobTitle,
    .organizationName,
    
    
    
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].contentTypes?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let section = sections[indexPath.section]
        
        cell.accessoryType = .none
        
        if let types = section.contentTypes {
            let type = types[indexPath.row]
            cell.textLabel?.text = type.name
            if type.type == previousContentType?.type {
                cell.accessoryType = .checkmark
            }
        } else {
            cell.textLabel?.text = "Unspecified"
            if previousContentType == nil {
                cell.accessoryType = .checkmark
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        let section = sections[indexPath.section]
        didSelectContentType?(section.contentTypes?[indexPath.row])
        
        dismiss(animated: true, completion: nil)
    }
    
    struct Section {
        let contentTypes: [TextContentType]?
    }

}
