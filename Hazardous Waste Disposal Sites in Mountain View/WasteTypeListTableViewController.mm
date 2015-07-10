//
//  WasteTypeListTableViewController.m
//  Hazardous Waste Disposal Sites in Mountain View
//
//  Created by Evan Kroske on 7/2/15.
//
//

#import "WasteTypeListTableViewController.h"
#import "LocationMapViewController.h"

#include <vector>
#include <string>

#include "Site.h"

using std::vector;
using std::string;

class WasteTypeListTableViewControllerInstanceVariables {
public:
  vector<string> wasteTypes;
  vector<string> addresses;
  vector<Site> sites;
  WasteTypeListTableViewControllerInstanceVariables()
      : wasteTypes{"Batteries", "Lamps", "Paint", "Other"},
        addresses{"1297 W. El Camino Real", "2555 Charleston Road",
                  "134 San Antonio Circle"},
        sites{{"1297 W. El Camino Real", 37.3759962, -122.0601066},
              {"2555 Charleston Road", 37.4210681, -122.0994957},
              {"134 San Antonio Circle", 37.4076531, -122.1097241},
              {"126 San Antonio Circle", 37.408972, -122.1101135}} {}
};

@implementation WasteTypeListTableViewController {
  WasteTypeListTableViewControllerInstanceVariables _ivars;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return _ivars.wasteTypes.size();
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"WasteListPrototypeCell"
                                      forIndexPath:indexPath];
  cell.textLabel.text = [NSString
      stringWithUTF8String:_ivars.wasteTypes[(long)indexPath.row].c_str()];
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (_ivars.wasteTypes[indexPath.row] == "Batteries") {
    [self performSegueWithIdentifier:@"ShowLocations" sender:self];
  } else {
    [[UIApplication sharedApplication]
        openURL:[NSURL URLWithString:@"http://www.mountainview.gov/depts/pw/"
                                     @"recycling/hazard/default.asp"]];
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSAssert([segue.destinationViewController
               isKindOfClass:LocationMapViewController.class],
           @"bad");
  LocationMapViewController *vc = segue.destinationViewController;
  vc.addresses = &_ivars.addresses;
  vc.sites = &_ivars.sites;
}

@end
