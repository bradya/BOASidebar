/*-
 *  BOA Sidebar Sample App
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


#import "SampleViewController.h"
#import "SampleSidebarViewController.h"
#import "BOASidebarNavigationController.h"

@implementation SampleViewController

#pragma mark - View events

- (void)sidebarButtonPressed:(id)sender
{
    if ([self showingSidebar])
    {
        [self dismissSidebar:YES];
    }
    else
    {
        [self showSidebar];
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    SampleSidebarViewController * sidebarViewController = [[SampleSidebarViewController alloc] initWithStyle:UITableViewStylePlain];
    BOASidebarNavigationController * sidebarNavigationController = [[BOASidebarNavigationController alloc] initWithRootViewController:sidebarViewController];
    [self addSidebar:sidebarNavigationController];
    
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"lines.png"] style:UIBarButtonItemStylePlain target:self action:@selector(sidebarButtonPressed:)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
