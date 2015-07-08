//
//  ViewController.m
//  Hazardous Waste Disposal Sites in Mountain View
//
//  Created by Evan Kroske on 6/28/15.
//
//

#import "LocationMapViewController.h"

@implementation LocationMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSAssert([self.view isKindOfClass:[MKMapView class]], @"bad!");
    MKMapView *mapView = (MKMapView *)self.view;
    mapView.region = MKCoordinateRegionMakeWithDistance({37.3894, -122.0819}, 10000, 10000);
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = {37.3894, -122.0819};
    annotation.title = @"Mountain View";
    [mapView addAnnotation:annotation];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView
                                                             dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
    
    if (!pinView)
    {
        pinView = [[MKPinAnnotationView alloc]
                                              initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
        pinView.pinColor = MKPinAnnotationColorPurple;
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        
        // Because this is an iOS app, add the detail disclosure button to display details about the annotation in another view.
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        pinView.rightCalloutAccessoryView = rightButton;        
    }
    else {
        pinView.annotation = annotation;
    }
    
    return pinView;
}


@end
