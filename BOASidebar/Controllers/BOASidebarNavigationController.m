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

#import "BOASidebarNavigationController.h"
#import "BOASidebarConfig.h"

@implementation BOASidebarNavigationController

@synthesize parent;

- (void)flipViewAccordingToStatusBarOrientation:(NSNotification *)notification {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGFloat angle = 0.0;
    
    switch (orientation) { 
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = - M_PI / 2.0f;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI / 2.0f;
            break;
        default: // as UIInterfaceOrientationPortrait
            angle = 0.0;
            break;
    } 
    
    self.view.transform = CGAffineTransformMakeRotation(angle);
    
    float statusBarHeight = 20.0f;
    float portraitWidth = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? kSideBarWidthiPhonePortrait : kSideBarWidthiPadPortrait;
    float portraitHeight = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? kSideBarHeightiPhonePortrait : kSideBarHeightiPadPortrait;
    float landscapeWidth = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? kSideBarWidthiPhoneLandscape : kSideBarWidthiPadLandscape;
    float landscapeHeight = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? kSideBarHeightiPhoneLandscape : kSideBarHeightiPadLandscape;
    
    CGRect frame = self.view.frame;
    
    switch (orientation) { 
        case UIInterfaceOrientationPortraitUpsideDown:
            frame = CGRectMake(landscapeHeight - portraitWidth, 0, portraitWidth, portraitHeight - statusBarHeight);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            frame = CGRectMake(statusBarHeight, portraitHeight - portraitWidth, landscapeHeight - statusBarHeight, landscapeWidth);
            break;
        case UIInterfaceOrientationLandscapeRight:
            frame = CGRectMake(0, 0, landscapeHeight - statusBarHeight, landscapeWidth);
            break;
        default: // as UIInterfaceOrientationPortrait
            frame = CGRectMake(0, statusBarHeight, portraitWidth, portraitHeight - statusBarHeight);
            break;
    } 
    
    self.view.frame = frame;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _shadowView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 27.0f, 0.0f, 27.0f, 1024.0f)];
    _shadowView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _shadowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shadow.png"]];
    [self.view addSubview:_shadowView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flipViewAccordingToStatusBarOrientation:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];  
    [self flipViewAccordingToStatusBarOrientation:nil]; // upate view :-)
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidLoad
{
    self.navigationBarHidden = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
