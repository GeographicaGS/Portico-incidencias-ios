//
//  TableHelperMunicipios.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 17/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "TableHelperMunicipios.h"
#import "IncidenceModel.h"
#import "CellIncidenceTownModel.h"
#import "Constants.h"

@implementation TableHelperMunicipios

- (void) cargarDatos
{
    [super cargarDatos];
    
    [IncidenceModel getNumIncidenciasPorMunicipio:@selector(afterGetIncidencias:) fromObject:self offset:[NSString stringWithFormat:@"%d", self.offset]];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((!self.finLista) && ([self.arrayDatos count] != 0) && (indexPath.row == [self.arrayDatos count] -1))
    {
        [self cargarDatos];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellIncidenceTownModel *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaTown"];
    
    cell.nombreMunicipio.text = [[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"nombre"];
    cell.numIncidencias.text= [[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"num"]stringValue];
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 26;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *myArray = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"M", @"N", @"Ñ", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    return myArray;
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
    NSMutableArray *myArray = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"M", @"N", @"Ñ", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
	return [myArray objectAtIndex:section];
    
}

@end
