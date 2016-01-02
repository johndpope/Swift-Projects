//
//  ComicTableViewCell.swift
//  Comic Viewer2
//
//  Created by Mohan Dhar on 9/25/15.
//  Copyright © 2015 Mohan Dhar. All rights reserved.
//

import UIKit

class ComicTableViewCell: UITableViewCell {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var comicTitle: UILabel!
    @IBOutlet var comicImage: UIImageView!
    @IBOutlet var footer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
