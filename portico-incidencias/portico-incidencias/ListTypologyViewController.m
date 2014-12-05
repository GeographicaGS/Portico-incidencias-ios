//
//  ListTypologyViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 11/11/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "ListTypologyViewController.h"
#import "CellTypologyModel.h"
#import "IncidenceModel.h"
#import "ListTypologyViewController.h"
#import "CreateIncidenceViewController.h"

@implementation ListTypologyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height +20)];
    [v setBackgroundColor: [[UIColor alloc]initWithRed:(74/255.0) green:(60/255.0) blue:(49/255.0) alpha:1.0]];
    [self.view addSubview:v];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    self.table.delegate = self;
    self.table.dataSource = self;
    
    if(self.arrayDatos == nil)
    {
        self.arrayDatos = [[NSMutableArray alloc] init];
    }
    
    [self.titleHead setText:NSLocalizedString(@"###Tipologias###", nil)];
    
    [IncidenceModel getTypologies:@selector(afterGetTypoogies:) fromObject:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayDatos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellTypologyModel *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaTypology"];
    [cell.title setText:([[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"titulo"])];
    if(((CreateIncidenceViewController *) self.delegate).idTypology == [[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"id_tema"]){
        [cell.tick setHidden:false];
    }else{
        [cell.tick setHidden:true];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [((CreateIncidenceViewController *) self.delegate).typology setText:[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"titulo"]];
    ((CreateIncidenceViewController *) self.delegate).idTypology = [[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"id_tema"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) afterGetTypoogies: (NSDictionary*) json
{
    for (NSDictionary *typology in [json objectForKey:@"results"]){
        [self.arrayDatos addObject:typology];
    }
    
    [self.table reloadData];
    [self.table setHidden:false];
}

@end
