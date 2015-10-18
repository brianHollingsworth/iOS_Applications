//
//  PizzaMenuViewController.h
//  Marnanteli's Pizza
//
//  Created by Brian Hollingsworth on 1/28/15.
//  Copyright (c) 2015 Brian Hollingsworth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PizzaMenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;

@end
