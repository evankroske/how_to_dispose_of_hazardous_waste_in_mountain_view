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

#import "AboutViewController.h"
#import <WebKit/WebKit.h>

@implementation AboutViewController

- (void)loadView {
  WKWebView *webView = [[WKWebView alloc] init];
  self.view = webView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  WKWebView *webView = (WKWebView *)self.view;
  NSString *path =
      [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
  [webView
      loadHTMLString:[NSString stringWithContentsOfFile:path
                                               encoding:NSUTF8StringEncoding
                                                  error:nil]
             baseURL:[NSURL URLWithString:path]];
}

@end
