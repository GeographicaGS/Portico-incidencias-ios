//
//  TableHelper.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 14/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "TableHelper.h"
#import "Constants.h"
#import "IncidenceModel.h"

@interface TableHelper ()
    
@end

@implementation TableHelper

@synthesize spinnerCentral, spinnerViewInferior, arrayDatos, tablaDatos, searchBar, offset, buscando, finLista, spinnerInferior;

- (void) cargarDatos
{
    if(arrayDatos == nil)
    {
        arrayDatos = [[NSMutableArray alloc] init];
    }
    else
    {
       [spinnerViewInferior setHidden:false];
    }
    
    //[IncidenceModel getIncidenciasPorFecha:@selector(afterGetIncidencias:) fromObject:self offset:[NSString stringWithFormat:@"%d", offset]];
}

-(void) afterGetIncidencias: (NSDictionary*) json
{
    bool recarga = false;
    [spinnerCentral setHidden:true];
    [spinnerViewInferior setHidden:true];
    [spinnerInferior setHidden:true];
    if([json objectForKey:@"error"])
    {
        
    }
    else
    {
        for (NSDictionary *incidencia in [json objectForKey:@"results"])
        {
            [arrayDatos addObject:incidencia];
            recarga = true;
        }
        if(recarga)
        {
            offset += LIMIT;
            //[tablaDatos reloadData];
        }
        else
        {
            finLista = true;
        }
        [tablaDatos reloadData];
        if(![self.searchBar isHidden]){
            [self.tablaDatos setContentOffset:CGPointMake(0,-45) animated:YES];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayDatos count];
}

/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayDatos count];
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*CellIncidenceModel *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaIncidencia"];
    
    cell.tituloIncidencia.text = [[arrayDatos objectAtIndex:indexPath.row]objectForKey:@"titulo"];
    if([[arrayDatos objectAtIndex:indexPath.row]objectForKey:@"nombre_municipio"] != [NSNull null])
    {
        cell.municipioIncidencia.text = [[arrayDatos objectAtIndex:indexPath.row]objectForKey:@"nombre_municipio"];
    }
    else
    {
        cell.municipioIncidencia.text = @"";
    }
    
    cell.infoIncidencia.text= [[[arrayDatos objectAtIndex:indexPath.row]objectForKey:@"dias"]stringValue];
    
    return cell;*/
    return nil;
    
}

/*- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((!finLista) && ([arrayDatos count] != 0) && (indexPath.row == [arrayDatos count] -1))
    {
        [self cargarDatos];
    }
}*/


//Métodos para crear una tabla alfabética

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    //return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
    NSInteger newRow = [self indexForFirstChar:title inArray:arrayDatos ];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newRow inSection:0];
    [tableView scrollToRowAtIndexPath:newIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    return index;
}

// Return the index for the location of the first item in an array that begins with a certain character
- (NSInteger)indexForFirstChar:(NSString *)character inArray:(NSArray *)array
{
    NSUInteger count = 0;
    for (NSDictionary *str in array) {
        if ([[str objectForKey:@"titulo"] hasPrefix:character]) {
            return count;
        }
        count++;
    }
    return 0;
}
*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [searchBar setHidden:true];
    [searchBar resignFirstResponder];
    buscando = 0;
    [self.tablaDatos deselectRowAtIndexPath:indexPath animated:NO];
}


//Métodos sobre el scroll

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [UIView transitionWithView:searchBar
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];

    /*CGRect f = self.searchBar.frame;
    f.size.height = 0;
    searchBar.frame = f;
    f.size.height = 44;
    [UIView animateWithDuration:0.3 animations:^{
        [searchBar setHidden:false];
        searchBar.frame = f;
        
    } completion:nil];*/
    
    if (scrollView.contentOffset.y < 0 && !buscando)
    {
        [tablaDatos setContentOffset:CGPointMake(0,-45) animated:YES];
        [searchBar setHidden:false];
        buscando = true;
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0)
{
    if ((buscando) && (scrollView.contentOffset.y>=0))
    {
        [searchBar setHidden:true];
        [searchBar resignFirstResponder];
        buscando = 0;
        [scrollView setContentOffset:CGPointMake(0,0) animated:NO];
    }
}

@end
