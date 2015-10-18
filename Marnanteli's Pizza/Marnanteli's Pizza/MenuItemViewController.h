//
//  MenuItemViewController.h
//  Marnanteli's Pizza
//
//  Created by Brian Hollingsworth on 3/1/15.
//  Copyright (c) 2015 Brian Hollingsworth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemViewController : UIViewController
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@property (nonatomic, weak) IBOutlet UITextView *menuDescription;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic) NSString *descriptionText;
@property (nonatomic) NSString *itemImage;
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;

- (void)setupView;

@end
