//
//  MapViewController.h
//  Marnanteli's Pizza
//
//  Created by Brian Hollingsworth on 1/17/15.
//  Copyright (c) 2015 Brian Hollingsworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate,UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
//@property (weak, nonatomic) IBOutlet UISwitch *deliveryRangeSwitch;
//- (IBAction)showDeliveryRange:(id)sender;

@property (nonatomic) UINavigationItem *navItem;

@end
