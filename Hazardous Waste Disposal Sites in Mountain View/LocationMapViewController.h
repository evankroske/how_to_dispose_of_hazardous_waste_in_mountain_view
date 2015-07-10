//
//  ViewController.h
//  Hazardous Waste Disposal Sites in Mountain View
//
//  Created by Evan Kroske on 6/28/15.
//
//

#import <UIKit/UIKit.h>
#import <Mapkit/MapKit.h>

#include <string>
#include <vector>

@interface LocationMapViewController : UIViewController<MKMapViewDelegate>

@property std::vector<std::string> *addresses;

@end

