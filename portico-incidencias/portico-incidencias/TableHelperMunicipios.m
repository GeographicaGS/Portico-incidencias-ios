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
#import "TimerHelper.h"

@implementation TableHelperMunicipios

NSMutableArray *myArray;
NSMutableArray *numbers;
NSMutableArray *myArrayHeader;


- (void) cargarDatos
{
    [super cargarDatos];
    myArray = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K",@"L", @"M", @"N", @"Ñ", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    numbers = [[NSMutableArray alloc] init];
    myArrayHeader = [[NSMutableArray alloc] init];
    for (int i=0; i<[myArray count]; i++) {
        [numbers addObject:[NSNull null]];
    }
    
    [IncidenceModel getNumIncidenciasPorMunicipio:@selector(afterGetIncidencias:) fromObject:self offset:[NSString stringWithFormat:@"%d", self.offset] search: self.searchBar.text];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   /* if ((!self.finLista) && ([self.arrayDatos count] != 0) && (indexPath.row == [self.arrayDatos count] -1))
    {
        [self cargarDatos];
    }*/
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellIncidenceTownModel *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaTown"];
    if([self.arrayDatos count] > 0){
        int indice = 0;
         for (int i=0; i<indexPath.section; i++) {
            indice += [[numbers objectAtIndex:i]intValue];
        }
        cell.idMunicipio = [[self.arrayDatos objectAtIndex:indexPath.row + indice]objectForKey:@"id_municipio"];
        cell.nombreMunicipio.text = [[self.arrayDatos objectAtIndex:indexPath.row + indice]objectForKey:@"nombre"];
        cell.numIncidencias.text= [[[self.arrayDatos objectAtIndex:indexPath.row + indice]objectForKey:@"num"]stringValue];
    }

    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.searchBar.text isEqualToString:@""]) {
        NSInteger result = 0;
        NSString *nombre;
        NSString *letra;
        
        for (int i=0; i<[myArray count]; i++) {
            for (int y=0; y<[self.arrayDatos count]; y++) {
                nombre = [[[self.arrayDatos objectAtIndex:y]objectForKey:@"nombre"]substringToIndex:1];
                letra = [myArray objectAtIndex:i];
                if([nombre isEqualToString:letra]){
                    result ++;
                    [myArrayHeader addObject:letra];
                    break;
                }
            }
        }
        
        return result;
    }
    return 1;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([self.searchBar.text isEqualToString:@""]) {
        return myArray;
    }
    return NULL;
}

/*- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
    
	return [myArray objectAtIndex:section];
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.searchBar.text isEqualToString:@""]) {
        NSInteger result = 0;
        NSString *nombre;
        NSString *letra;
        for (int i=0; i<[self.arrayDatos count]; i++) {
            nombre = [[[self.arrayDatos objectAtIndex:i]objectForKey:@"nombre"]substringToIndex:1];
            letra = [myArrayHeader objectAtIndex:section];
            if([[nombre substringToIndex:1] compare:letra options:NSDiacriticInsensitiveSearch] == NSOrderedSame){
                result ++;
            }
        }
        [numbers replaceObjectAtIndex:section withObject:[NSString stringWithFormat:@"%ld",(long)result]];
        return result;
    }
    return [self.arrayDatos count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 305, 23)];
    view.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];

    UILabel *label = [[UILabel alloc] init];
    

    if ([self.searchBar.text isEqualToString:@""]) {
        label.frame = CGRectMake(15, 0, 305, 23);
        label.textColor = [UIColor colorWithRed:(247/255.0) green:(77/255.0) blue:0.0 alpha:1.0];
        label.text = [myArrayHeader objectAtIndex:section];
    }
    else{
        label.frame = CGRectMake(0, 0, 320, 23);
        label.backgroundColor = [UIColor whiteColor];
    }
    [view addSubview:label];
    
    return view;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tablaDatos deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.y < 0 && !self.buscando)
    {
        [UIView transitionWithView:self.searchBar
                          duration:0.4
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        
        //[self.tablaDatos setContentOffset:CGPointMake(0,-110) animated:YES];
        [self.searchBar setHidden:false];
        self.buscando = true;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.arrayDatos removeAllObjects];
    [self.tablaDatos reloadData];
    //[self.spinnerCentral setHidden:false];
    [[TimerHelper getInstance]start:1 funcion:@selector(cargarDatos) fromObject:self];
}

-(void) afterGetIncidencias: (NSDictionary*) json
{
    [super afterGetIncidencias:json];
    /*if(![self.searchBar isHidden]){
        [self.tablaDatos setContentOffset:CGPointMake(0,-110) animated:YES];
    }*/
    //if([self.arrayDatos count] > 0){
        //[self.tablaDatos scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    //}else{
        //[self.tablaDatos scrollRectToVisible:CGRectMake(0, -1, 1, 1) animated:NO];
        //[self.tablaDatos setContentOffset:CGPointZero animated:YES];
    //}
    
}

@end
