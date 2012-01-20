/*-
 *  BOA Sidebar
 *  
 *  Copyright 2012 Brady Archambo
 *  Created by Brady Archambo.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License. 
 *
 *  Find me on Twitter, twitter.com/bradyy
 *
 */

#import "BOABaseSidebarViewController.h"

@implementation BOABaseSidebarViewController

#pragma mark - View lifecycle

-(BOASidebarNavigationController*) sidebarNavigationController
{
    return (BOASidebarNavigationController*) self.navigationController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"sidebarBg.png"]]];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 1000.0f);
    [self.tableView sizeToFit];
    self.tableView.contentSize = self.tableView.frame.size;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
