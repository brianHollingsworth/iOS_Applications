//
//  MapViewController.m
//  Marnanteli's Pizza
//
//  Created by Brian Hollingsworth on 1/17/15.
//  Copyright (c) 2015 Brian Hollingsworth. All rights reserved.
//

#import "MapViewController.h"
#import "SWRevealViewController.h"
#import "Location.h"
#import "LocationCell.h"

#define METERS_PER_MILE 1609.344

@interface MapViewController ()

@end

@implementation MapViewController {
    NSMutableArray *name;
    NSMutableArray *address;
    NSMutableArray *longitude;
    NSMutableArray *latitude;
    NSInteger selectedLocation;
    double selectedLongitude;
    double selectedLatitude;
    NSString *selectedName;
}

//@synthesize deliveryRangeSwitch;

//---------------------------------------------------------------------------------
#pragma mark - Initialize View Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

//-------------------------------------------------------------------------
#pragma mark - Sort Location by Names -

- (NSArray *)sortedKeysForDictionary:(NSDictionary *)dict {
    NSArray *keys = [dict allKeys];
    NSMutableArray *anArray = [NSMutableArray arrayWithArray:keys];
    keys = [anArray sortedArrayUsingSelector:@selector(localizedCompare:)];
    return keys;
}

//--------------------------------------------------------------------------
#pragma mark - Map Delegate -

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifier = @"Location";
    if ([annotation isKindOfClass:[Location class]]) {
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotation == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            
            annotationView.image = [UIImage imageNamed:@"sartell_loc.png"];
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

//---------------------------------------------------------------------------
#pragma mark - Table Delegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[latitude objectAtIndex:indexPath.row] doubleValue];
    zoomLocation.longitude = [[longitude objectAtIndex:indexPath.row] doubleValue];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE,  0.5*METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    selectedLatitude = [[latitude objectAtIndex:indexPath.row] doubleValue];
    selectedLongitude = [[longitude objectAtIndex:indexPath.row] doubleValue];
    selectedName = [name objectAtIndex:indexPath.row];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return name.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"LocationCell";
    
    LocationCell *cell = (LocationCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.nameLabel.text = [name objectAtIndex:indexPath.row];
    cell.addressLabel.text = [address objectAtIndex:indexPath.row];
    
    if (selectedLocation == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedLocation inSection:0];
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
        selectedLatitude = [[latitude objectAtIndex:selectedLocation] doubleValue];
        selectedLongitude = [[longitude objectAtIndex:selectedLocation] doubleValue];
        selectedName = [name objectAtIndex:selectedLocation];
    } else {
        cell.accessoryType = UITableViewScrollPositionNone;
    }
    
    cell.selectionStyle = UITableViewScrollPositionNone;
    return cell;
}

//-------------------------------------------------------------------------------------
#pragma mark - Load View -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Location";
    
    selectedLocation = 0;
    
    NSString *plistDictionary = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:plistDictionary]) {
        name = [[NSMutableArray alloc] init];
        address = [[NSMutableArray alloc] init];
        latitude = [[NSMutableArray alloc] init];
        longitude = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *locations = [[NSMutableDictionary alloc] initWithContentsOfFile: plistDictionary];
        
        NSArray *keys = [self sortedKeysForDictionary:locations];
        
        for (int i = 0; i < keys.count; i++) {
            NSString *key = [keys objectAtIndex:i];
            id location = [locations valueForKey:key];
            
            NSString *theName = [location objectForKey:@"name"];
            [name addObject:theName];
            
            NSString *theAddress = [location objectForKey:@"address"];
            [address addObject:theAddress];
            
            NSString *theLatitude = [location objectForKey:@"latitude"];
            [latitude addObject:theLatitude];
            
            NSString *theLongitude = [location objectForKey:@"longitude"];
            [longitude addObject:theLongitude];
            
        }
                
    }
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[latitude objectAtIndex:0] doubleValue];
    zoomLocation.longitude = [[longitude objectAtIndex:0] doubleValue];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
    
    for (int i = 0; i < name.count; i++) {
        double locationLatitude = [[latitude objectAtIndex:i] doubleValue];
        double locationLongitude = [[longitude objectAtIndex:i] doubleValue];
        
        NSString * locationName = [name objectAtIndex:i];
        NSString * locationAddress = [address objectAtIndex:i];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = locationLatitude;
        coordinate.longitude = locationLongitude;
        Location *annotation = [[Location alloc] initWithName:locationName address:locationAddress coordinate:coordinate];
        [_mapView addAnnotation:annotation];
    } // end coordinate configuration
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)showActionSheet:(id)sender {
    [self buttonAppleDirAction];
}

//-----------------------------------------------------------------------------------------
#pragma mark - Launch Apple Maps -

- (void)buttonAppleDirAction {
    
    Class mapItemClass = [MKMapItem class];
    
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(selectedLatitude, selectedLongitude);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:selectedName];
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 IF YOU WANT TO INCORPORATE SHOW DELIVERY RANGE
#pragma mark - Show Delivery Range -

- (IBAction)showDeliveryRange:(id)sender {
    CLLocationCoordinate2D deliveryPoints[11];
    
    deliveryPoints[0] = CLLocationCoordinate2DMake(45.716659, -94.225804); // 411th St (Rice)
    deliveryPoints[1] = CLLocationCoordinate2DMake(45.716734, -94.232338); // 409th St (Rice)
    deliveryPoints[2] = CLLocationCoordinate2DMake(45.709032, -94.235433); // Sage Ct (Rice)
    deliveryPoints[3] = CLLocationCoordinate2DMake(45.715055, -94.243694); // 65th Ave N (Rice)
    deliveryPoints[4] = CLLocationCoordinate2DMake(45.695919, -94.243651); // 65th Ave S (Rice)
    deliveryPoints[5] = CLLocationCoordinate2DMake(45.696054, -94.248844); // 395th St / 400th St (Rice)
    deliveryPoints[6] = CLLocationCoordinate2DMake(45.694136, -94.248780); // 400th St (Rice)
    deliveryPoints[7] = CLLocationCoordinate2DMake(45.677452, -94.259380); // End of 73rd Ave (Sartell)
    deliveryPoints[8] = CLLocationCoordinate2DMake(45.673584, -94.258822); // 40th St / 73rd Ave (Sartell)
    deliveryPoints[9] = CLLocationCoordinate2DMake(45.661798, -94.248737); // Southern bend of Blackberry (Sartell)
    deliveryPoints[10] = CLLocationCoordinate2DMake(45.655499, -94.241184); // End of 27th St N / Oak Ridge (Sartell)
    
    MKPolygon* deliveryRange = [MKPolygon polygonWithCoordinates:deliveryPoints count:11];
    
    if (deliveryRangeSwitch.on) {
        [self.mapView addOverlay:deliveryRange];
    }
}
*/

@end
