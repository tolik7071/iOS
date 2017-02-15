//
//  ViewController.m
//  Pigeon
//
//  Created by Anatoliy Goodz on 10/21/16.
//  Copyright © 2016 Anatoliy Goodz. All rights reserved.
//

#import "ViewController.h"

NSString *kMapTypeKey = @"HPMapType";
NSString *kHeading = @"HPFollowHeading";
NSString *kSavedLocation = @"HPLocation";

@interface ViewController ()
{
    MKPointAnnotation *_savedAnnotation;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dropPin:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"What's Here?"
        message:@"Type a label for this location."
        preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
        style:UIAlertActionStyleCancel
        handler:nil];
    [alert addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Remember"
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * _Nonnull action)
        {
            NSString *label = @"Over Here!";
            
            UITextField *textField = alert.textFields.firstObject;
            if (textField != nil && textField.text.length != 0)
            {
                label = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            }
            
            [self saveAnnotationUsingLabel:label];
        }];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)clearPin:(id)sender
{
    [self clearAnnotation];
}

- (void)saveAnnotationUsingLabel:(NSString *)aLabel
{
    MKUserLocation *location = self.mapView.userLocation;
    if (location != nil)
    {
        [self clearAnnotation];
        
        MKPointAnnotation *annotation = [MKPointAnnotation new];
        annotation.title = aLabel;
        annotation.coordinate = location.coordinate;
        [self.mapView addAnnotation:annotation];
        [self.mapView selectAnnotation:annotation animated:YES];
        
        _savedAnnotation = annotation;
    }
}

- (void)clearAnnotation
{
    if (_savedAnnotation != nil)
    {
        [self.mapView removeAnnotation:_savedAnnotation];
        _savedAnnotation = nil;
    }
}

#pragma mark -

- (void)mapView:(MKMapView *)mapView
    didChangeUserTrackingMode:(MKUserTrackingMode)mode
    animated:(BOOL)animated
{
    if (mode == MKUserTrackingModeNone)
    {
        self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isEqual:mapView.userLocation])
    {
        return nil;
    }
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Save"];
    if (pinView == nil)
    {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Save"];
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
        pinView.draggable = YES;
    }
    
    return pinView;
}

@end
