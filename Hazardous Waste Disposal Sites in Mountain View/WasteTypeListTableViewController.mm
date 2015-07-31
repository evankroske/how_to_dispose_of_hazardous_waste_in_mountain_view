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
#include <map>

#include "Site.h"

using std::vector;
using std::string;
using std::map;

class WasteTypeListTableViewControllerInstanceVariables {
  vector<Site> sites_for_batteries_only;
  vector<Site> sites_for_batteries_and_lamps;
  vector<Site> sites_for_paint;
  vector<Site> sites_for_batteries;
public:
  vector<string> wasteTypes;
  vector<Site> *sites_to_display;
  string *title_to_display;
  vector<string> titles;
  map<string, vector<Site> *> sites_for_waste_type;
  map<string, string> url_for_waste_type;
  WasteTypeListTableViewControllerInstanceVariables()
      : sites_for_batteries_and_lamps{{"Blossom True Value Hardware",
                                       "1297 W. El Camino Real, Mountain View, "
                                       "CA",
                                       37.387872, -122.089317},
                                      {"Orchard Supply Hardware",
                                       "2555 Charleston Road, Mountain View, "
                                       "CA",
                                       37.4210681, -122.0994957},
                                      {"Bruce Bauer Lumber and Supply",
                                       "134 San Antonio Circle, Mountain View, "
                                       "CA",
                                       37.4076531, -122.1097241},
                                      {"Stanford Electric", "126 San Antonio "
                                                            "Circle, Mountain "
                                                            "View, CA",
                                       37.408972, -122.1101135}},
        sites_for_batteries_only{
            {"Radio Shack", "530 Showers Drive, Mountain View, CA", 37.4020375,
             -122.1076114},
            {"Radio Shack", "1350 Grant Road, Mountain View, CA", 37.377018,
             -122.0767202},
            {"Best Buy", "2460 E Charleston Rd, Mountain View, CA", 37.423426,
             -122.097144},
            {"Target", "555 Showers Drive, Mountain View, CA", 37.4010106,
             -122.1060628},
            {"Green Citizen", "2500 W. El Camino Real #D, Mountain View, CA",
             37.3999169, -122.1101169}},
        sites_for_paint{
            {"Dunn-Edwards", "1949 El Camino Real, Mountain View, CA",
             37.3939783, -122.0980678},
            {"Kelly Moore", "180 El Camino Real E, Mountain View, CA",
             37.3796836, -122.0700783},
            {"Kelly Moore", "411 Fairchild Dr, Mountain View, CA", 37.4038062,
             -122.0532071},
            {"Orchard Supply", "2555 Charleston Road, Mountain View, CA",
             37.4210681, -122.0994957}},
        titles{"Where to Dispose of Batteries",
               "Where to Dispose of Fluorescent Lamps",
               "Where to Dispose of Paint"},
        url_for_waste_type{{"Automotive Batteries",
                            "https://www.sccgov.org/sites/iwm/hhw/Documents/"
                            "Auto%20batteries,%20tires,%20antifreeze.pdf"},
                           {"Other", "http://www.mountainview.gov/depts/pw/"
                                     "recycling/hazard/default.asp"}} {
    sites_for_batteries.insert(sites_for_batteries.end(),
                               sites_for_batteries_and_lamps.begin(),
                               sites_for_batteries_and_lamps.end());
    sites_for_batteries.insert(sites_for_batteries.end(),
                               sites_for_batteries_only.begin(),
                               sites_for_batteries_only.end());
    sites_for_waste_type["Batteries (Non-Automotive)"] = &sites_for_batteries;
    sites_for_waste_type["Fluorescent Lamps"] = &sites_for_batteries_and_lamps;
    sites_for_waste_type["Paint"] = &sites_for_paint;
    for (auto pair : sites_for_waste_type) {
      wasteTypes.push_back(pair.first);
    }
    for (auto pair : url_for_waste_type) {
      wasteTypes.push_back(pair.first);
    }
  }
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
  string waste_type = _ivars.wasteTypes.at(indexPath.row);
  if (_ivars.url_for_waste_type.count(waste_type) == 1) {
    [[UIApplication sharedApplication]
        openURL:[NSURL URLWithString:[NSString stringWithUTF8String:
                                                   _ivars.url_for_waste_type
                                                       .at(waste_type)
                                                       .c_str()]]];
    return;
  }
  _ivars.title_to_display = &_ivars.titles.at(indexPath.row);
  _ivars.sites_to_display = _ivars.sites_for_waste_type.at(waste_type);
  [self performSegueWithIdentifier:@"ShowLocations" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSAssert([segue.destinationViewController
               isKindOfClass:LocationMapViewController.class],
           @"bad");
  LocationMapViewController *vc = segue.destinationViewController;
  vc.title = [NSString stringWithUTF8String:_ivars.title_to_display->c_str()];
  vc.sites = _ivars.sites_to_display;
}

@end
