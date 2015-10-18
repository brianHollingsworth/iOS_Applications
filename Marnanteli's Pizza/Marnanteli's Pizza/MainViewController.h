//
//  MainViewController.h
//  Marnanteli's Pizza
//
//  Created by Brian Hollingsworth on 1/17/15.
//  Copyright (c) 2015 Brian Hollingsworth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (IBAction)callMarnantelis:(id)sender;

@end
