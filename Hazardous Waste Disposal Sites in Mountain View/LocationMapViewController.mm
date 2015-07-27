// Copyright 2015 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "LocationMapViewController.h"

@implementation LocationMapViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSAssert([self.view isKindOfClass:[MKMapView class]], @"bad!");
  MKMapView *mapView = (MKMapView *)self.view;
  mapView.region =
      MKCoordinateRegionMakeWithDistance({37.3894, -122.0819}, 10000, 10000);
  for (const Site& site : (*self.sites)) {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = {site.latitude, site.longitude};
    annotation.title = [NSString stringWithUTF8String:site.name.c_str()];
    annotation.subtitle = [NSString stringWithUTF8String:site.address.c_str()];
    [mapView addAnnotation:annotation];
  }
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
  NSString *name = annotation.title;
  NSString *address = annotation.subtitle;
  NSURLComponents *components = [NSURLComponents componentsWithString:@"http://maps.apple.com/"];
  components.queryItems =
  @[
    [NSURLQueryItem
     queryItemWithName:@"q"
     value:[@[name, address, @"Mountain View, CA"] componentsJoinedByString:@", "]]];
  [[UIApplication sharedApplication] openURL:components.URL];
}

@end
