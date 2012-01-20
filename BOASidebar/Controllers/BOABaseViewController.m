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

#import "BOABaseViewController.h"
#import "BOASidebarNavigationController.h"
#import "BOASidebarConfig.h"

@implementation BOABaseViewController

#pragma mark - Touch events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_sidebar && [self showingSidebar])
    {
        UITouch * touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.navigationController.view];
        
        BOOL dismiss = NO;
        
        switch (self.interfaceOrientation) {
            case UIInterfaceOrientationPortraitUpsideDown:
                if (location.x > 0)
                {
                    dismiss = YES;
                }
                break;
            case UIInterfaceOrientationLandscapeLeft:
                if (location.y > 0)
                {
                    dismiss = YES;
                }
                break;
            case UIInterfaceOrientationLandscapeRight:
                if (location.y > 0)
                {
                    dismiss = YES;
                }
                break;
            default:
                if (location.x > 0)
                {
                    dismiss = YES;
                }
                break;
        }

        if (dismiss)
        {
            // Dismiss sidebar animated
            [self dismissSidebar:YES];
        }
    }
}

#pragma mark - Sidebar

-(BOOL)showingSidebar
{
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            if (self.navigationController.view.frame.origin.x < 0)
            {
                return YES;
            }
            break;
        case UIInterfaceOrientationLandscapeLeft:
            if (self.navigationController.view.frame.origin.y < 0)
            {
                return YES;
            }
            break;
        case UIInterfaceOrientationLandscapeRight:
            if (self.navigationController.view.frame.origin.y > 0)
            {
                return YES;
            }
            break;
        default:
            if (self.navigationController.view.frame.origin.x > 0)
            {
                return YES;
            }
            break;
    }

    return NO;
}

-(void)addSidebar:(BOASidebarNavigationController *)sidebar
{
    BOOL portrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
    
    float width = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? (portrait ? kSideBarWidthiPhonePortrait : kSideBarWidthiPhoneLandscape) : (portrait ? kSideBarWidthiPadPortrait : kSideBarWidthiPadLandscape);
    
    sidebar.view.frame = CGRectMake(sidebar.view.frame.origin.x, sidebar.view.frame.origin.y, width, sidebar.view.frame.size.height);
    
    [self.navigationController.view.superview addSubview:sidebar.view];
    [self.navigationController.view.superview sendSubviewToBack:sidebar.view];
    
    _sidebar = sidebar;
}

-(void)showSidebar
{
    CGRect destination = self.navigationController.view.frame;
    
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            destination.origin.x -= _sidebar.view.frame.size.width;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            destination.origin.y -= _sidebar.view.frame.size.height;
            break;
        case UIInterfaceOrientationLandscapeRight:
            destination.origin.y += _sidebar.view.frame.size.height;
            break;
        default:
            destination.origin.x += _sidebar.view.frame.size.width;
            break;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.navigationController.view.frame = destination;        
    }];
}

-(void)dismissSidebar:(BOOL)animated
{
    BOOL portrait = UIInterfaceOrientationIsPortrait(self.interfaceOrientation);
    
    CGRect destination = self.navigationController.view.frame;
    
    if (portrait)
    {
        destination.origin.x = 0;
    }
    else
    {
        destination.origin.y = 0;
    }
    
    if (animated)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.view.frame = destination;
        } completion:^(BOOL finished) {
            if (_sidebar)
            {
                [_sidebar popToRootViewControllerAnimated:NO];
            }
        }];
    }
    else
    {
        self.navigationController.view.frame = destination;
    }
}

@end
