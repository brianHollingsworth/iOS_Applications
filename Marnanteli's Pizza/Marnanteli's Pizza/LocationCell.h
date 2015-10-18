//
//  LocationCell.h
//  Marnanteli's Pizza
//
//  Created by Brian Hollingsworth on 1/18/15.
//  Copyright (c) 2015 Brian Hollingsworth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
