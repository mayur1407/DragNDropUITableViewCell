//
//  MSTableViewController.h
//  DragNDropCell
//
//  Created by Mayur on 11/27/13.
//  Copyright (c) 2013 webwerks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTableViewController : UITableViewController
{
    NSMutableArray *recipes;
    NSIndexPath *previousIndexPath;
    UIView *vw;
    UIButton *btn;
}
@end
