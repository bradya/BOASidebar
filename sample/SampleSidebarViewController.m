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

#import "SampleSidebarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BOAAccessoryView.h"


@implementation SampleSidebarViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}


+(UIView *) sidebarHeaderForText:(NSString*)text
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 28.0f)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0f, 0.0f, 300.0f, 26.0f)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.text = text;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.shadowColor = [UIColor blackColor];
    textLabel.shadowOffset = CGSizeMake(0, -1);
    textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = headerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:75.0f/255.0f green:75.0f/255.0f blue:75.0f/255.0f alpha:1.0f] CGColor], nil];
    [headerView.layer insertSublayer:gradient atIndex:0];
    
    [headerView addSubview:textLabel];
    
    return headerView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        default:
            return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [SampleSidebarViewController sidebarHeaderForText:@"General"];
    }
    else if (section == 1)
    {
        return [SampleSidebarViewController sidebarHeaderForText:@"Settings"];;
    }
    
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *text = nil;
    
    switch (indexPath.section) {
        case 0:
            text = @"Friends";
            break;
        case 1:
        {
            if (indexPath.row == 0)
            {
                text = @"Misc";
            }
            else
            {
                text = @"About";
            }
        }
            break;
        default:
            break;
    }
    
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.shadowColor = [UIColor blackColor];
    cell.textLabel.shadowOffset = CGSizeMake(0, -1);
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f];
    cell.textLabel.text = [NSString stringWithFormat:@" %@",text];
    
    BOAAccessoryView * accessoryView = [BOAAccessoryView accessoryWithColor:[UIColor colorWithWhite:1.0f alpha:0.4f]];
    accessoryView.highlightedColor = [UIColor colorWithWhite:1.0f alpha:0.4f];
    cell.accessoryView = accessoryView;
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.1f];
    cell.selectedBackgroundView = v;
    
    UIImageView * line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    CGRect frame = line.frame;
    frame.size.width = cell.frame.size.width;
    frame.origin.y = cell.frame.size.height - 4.0f;
    line.frame = frame;
    [cell addSubview:line];
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
