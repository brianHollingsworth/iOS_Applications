//
//  Location.h
//  Marnanteli's Pizza
//
//  Created by Brian Hollingsworth on 1/18/15.
//  Copyright (c) 2015 Brian Hollingsworth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Location : NSObject <MKAnnotation>

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;

@end
