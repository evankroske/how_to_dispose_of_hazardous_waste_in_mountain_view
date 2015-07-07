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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
