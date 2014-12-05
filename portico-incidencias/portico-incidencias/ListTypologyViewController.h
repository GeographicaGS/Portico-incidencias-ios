//
//  ListTypologyViewController.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 11/11/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListTypologyViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong) NSMutableArray *arrayDatos;
@property (weak, nonatomic) IBOutlet UILabel *titleHead;


@property (nonatomic, retain) id delegate;

- (void) afterGetTypoogies: (NSDictionary*) json;

@end
