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
        sites{{"Blossom True Value Hardware", "1297 W. El Camino Real", 37.3759962, -122.0601066},
              {"Orchard Supply Hardware", "2555 Charleston Road", 37.4210681, -122.0994957},
              {"Bruce Bauer Lumber and Supply", "134 San Antonio Circle", 37.4076531, -122.1097241},
              {"Stanford Electric", "126 San Antonio Circle", 37.408972, -122.1101135}} {}
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
