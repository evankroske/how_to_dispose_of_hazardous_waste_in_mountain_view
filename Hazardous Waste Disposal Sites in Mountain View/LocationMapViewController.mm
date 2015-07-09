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
  mapView.region =
      MKCoordinateRegionMakeWithDistance({37.3894, -122.0819}, 10000, 10000);
  MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
  annotation.coordinate = {37.3894, -122.0819};
  annotation.title = @"Mountain View";
  annotation.subtitle = @"1297 W. El Camino Real";
  [mapView addAnnotation:annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
  NSString *reuseIdentifier = @"DirectionsAnnotation";
  MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView
      dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];

  if (!pinView) {
    pinView = [[MKPinAnnotationView alloc]
        initWithAnnotation:annotation
           reuseIdentifier:reuseIdentifier];
    pinView.pinColor = MKPinAnnotationColorPurple;
    pinView.animatesDrop = YES;
    pinView.canShowCallout = YES;

    UIButton *leftButton =
        [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pinView.leftCalloutAccessoryView = leftButton;
  } else {
    pinView.annotation = annotation;
  }

  return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  NSAssert([view.annotation isKindOfClass:[MKPointAnnotation class]], @"type error");
  MKPointAnnotation *annotation = view.annotation;
  NSString *address = annotation.subtitle;
  NSURLComponents *components = [NSURLComponents componentsWithString:@"http://maps.apple.com/"];
  components.queryItems =
  @[
    [NSURLQueryItem
     queryItemWithName:@"q"
     value:[address stringByAppendingString:@", Mountain View"]]];
  [[UIApplication sharedApplication] openURL:components.URL];
}

@end
