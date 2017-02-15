//
//  ViewController.h
//  Pigeon
//
//  Created by Anatoliy Goodz on 10/21/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

extern NSString *kMapTypeKey;
extern NSString *kHeading;
extern NSString *kSavedLocation;

@interface ViewController : UIViewController <MKMapViewDelegate>

@property (weak) IBOutlet MKMapView *mapView;

@end

