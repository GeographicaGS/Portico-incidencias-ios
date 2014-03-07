//
//  TableHelperIncidencias.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 14/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "TableHelperIncidencias.h"
#import "TimerHelper.h"
#import "IncidenceModel.h"
#import "CellIncidenceModel.h"
#import "Constants.h"

@implementation TableHelperIncidencias
- (void) cargarDatos
{
    [super cargarDatos];
    

    switch (_tipoListado) {
        case INCIDENCIAS_RECIENTES:
            [IncidenceModel getIncidenciasPorFecha:@selector(afterGetIncidencias:) fromObject:self offset:[NSString stringWithFormat:@"%d", self.offset] search:self.searchBar.text];
            break;
        case INDICENCIAS_CERCANAS:
            [IncidenceModel getIncidenciasByDist:@selector(afterGetIncidencias:) fromObject:self offset:[NSString stringWithFormat:@"%d", self.offset] latitud:self.currentLocation.coordinate.latitude longitud:self.currentLocation.coordinate.longitude search: self.searchBar.text];
            break;
        case INCIDENCIAS_MUNICIPIOS_RECIENTES:
            
            break;
        case INCIDENCIAS_MUNICIPIOS_CERCANAS:
            
            break;
        case INCIDENCIAS_USUARIO_RECIENTES:
            [IncidenceModel getIncidenciasPorUsuario:@selector(afterGetIncidencias:) fromObject:self offset:[NSString stringWithFormat:@"%d", self.offset]];
            break;
        case INCIDENCIAS_USUARIO_CERCANAS:
            
            break;
            
        default:
            break;
    }
    
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
    float distancia;
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setMaximumFractionDigits:2];
    CGRect frame;
    
    CellIncidenceModel *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaIncidencia"];
    
    cell.tituloIncidencia.text = [[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"titulo"];
    if([[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"nombre_municipio"] != [NSNull null])
    {
        cell.municipioIncidencia.text = [[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"nombre_municipio"];
    }
    else
    {
        cell.municipioIncidencia.text = @"";
    }
    

    
    
    switch (_tipoListado) {
            
        case INCIDENCIAS_RECIENTES:
            frame = cell.tituloIncidencia.frame;
            frame.size.width = 180;
            cell.tituloIncidencia.frame = frame;
            
            frame = cell.municipioIncidencia.frame;
            frame.size.width = 180;
            cell.municipioIncidencia.frame = frame;
            
            frame = cell.icon.frame;
            frame.origin.x = 260;
            cell.icon.frame = frame;
            cell.icon.image = [UIImage imageNamed:@"POR_icon_hora.png"];
            
            frame = cell.infoIncidencia.frame;
            frame.origin.x = 270;
            frame.size.width = 45;
            cell.infoIncidencia.frame = frame;
            
            
            cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"dias"]stringValue],@"d"];
            break;
        case INDICENCIAS_CERCANAS:
            frame = cell.tituloIncidencia.frame;
            frame.size.width = 160;
            cell.tituloIncidencia.frame = frame;
            
            frame = cell.municipioIncidencia.frame;
            frame.size.width = 160;
            cell.municipioIncidencia.frame = frame;
            
            frame = cell.icon.frame;
            frame.origin.x = 245;
            cell.icon.frame = frame;
            cell.icon.image = [UIImage imageNamed:@"POR_icon_ubicacion.png"];
            
            frame = cell.infoIncidencia.frame;
            frame.origin.x = 250;
            frame.size.width = 65;
            cell.infoIncidencia.frame = frame;
            

            distancia = [[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"distance"]floatValue];
            if(distancia < 1000){
                cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [format stringFromNumber:[NSNumber numberWithFloat:distancia]] ,@"m"];
            }else{
                distancia /= 1000;
                cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [format stringFromNumber:[NSNumber numberWithFloat:distancia]] ,@"km"];
            }
            
            break;
        case INCIDENCIAS_MUNICIPIOS_RECIENTES:
            
            break;
        case INCIDENCIAS_MUNICIPIOS_CERCANAS:
            
            break;
        case INCIDENCIAS_USUARIO_RECIENTES:
            frame = cell.tituloIncidencia.frame;
            frame.size.width = 180;
            cell.tituloIncidencia.frame = frame;
            
            frame = cell.municipioIncidencia.frame;
            frame.size.width = 180;
            cell.municipioIncidencia.frame = frame;
            
            frame = cell.icon.frame;
            frame.origin.x = 260;
            cell.icon.frame = frame;
            cell.icon.image = [UIImage imageNamed:@"POR_icon_hora.png"];
            
            frame = cell.infoIncidencia.frame;
            frame.origin.x = 270;
            frame.size.width = 45;
            cell.infoIncidencia.frame = frame;
            
            cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"dias"]stringValue],@"d"];
            break;
        case INCIDENCIAS_USUARIO_CERCANAS:
            
            break;
            
        default:
            break;
    }
    
    cell.infoIncidencia.textAlignment = NSTextAlignmentRight;
    
    return cell;
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.arrayDatos removeAllObjects];
    [self.tablaDatos reloadData];
    [self.spinnerCentral setHidden:false];
    self.finLista = false;
    self.offset = 0;
    [[TimerHelper getInstance]start:1 funcion:@selector(cargarDatos) fromObject:self];
}



@end
