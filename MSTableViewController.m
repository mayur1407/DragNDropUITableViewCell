//
//  MSTableViewController.m
//  DragNDropCell
//
//  Created by Mayur on 11/27/13.
//  Copyright (c) 2013 webwerks. All rights reserved.
//

#import "MSTableViewController.h"

@interface MSTableViewController ()

@end


@implementation MSTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    recipes = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [btn removeFromSuperview];
    btn=[[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-60, 5, 40, 40)];
    [btn setTitle:@"drag" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(addGst) forControlEvents:UIControlEventTouchDown];
    [cell addSubview:btn];
    [cell bringSubviewToFront:btn];
    previousIndexPath=indexPath;
    
}

-(void)addGst
{
    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [self.tableView addGestureRecognizer:panRecognizer];
    
    vw=[[UIView alloc]initWithFrame:[self.tableView cellForRowAtIndexPath:previousIndexPath].frame];
    vw.backgroundColor=[UIColor blackColor];
    vw.alpha=0.5;
    [self.tableView addSubview:vw];
    
}

-(void)onPan:(UIPanGestureRecognizer*)pGesture
{
    CGPoint touchPoint = [pGesture locationInView:self.view];
    
    [btn removeFromSuperview];
    vw.frame=CGRectMake(0, touchPoint.y, vw.frame.size.width, vw.frame.size.height);
    if (pGesture.state == UIGestureRecognizerStateRecognized)
    {
        NSLog(@"panFinished");
        [self.tableView removeGestureRecognizer:pGesture];
    }
    if (pGesture.state == UIGestureRecognizerStateEnded)
    {
        UITableView* tableView = (UITableView*)self.view;
        
        NSIndexPath* row = [tableView indexPathForRowAtPoint:touchPoint];
        if (row != nil)
        {
            [self.tableView moveRowAtIndexPath:previousIndexPath toIndexPath:row];
            NSLog(@"%@",row);
            
        }
    }
    
    if (([pGesture state] == UIGestureRecognizerStateEnded) || ([pGesture state] == UIGestureRecognizerStateCancelled)) {
        [UIView animateWithDuration:0.5 animations:^{
            vw.alpha = 0.0;
            [vw removeFromSuperview];
            
        }];
    }
    
}



@end
