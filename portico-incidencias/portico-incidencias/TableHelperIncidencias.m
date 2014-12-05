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
#import "UIImageView+AFNetworking.h"

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
            [IncidenceModel getIncidenciasPorFechaPorMunicipio:@selector(afterGetIncidencias:) fromObject:self offset:[NSString stringWithFormat:@"%d", self.offset] search:self.searchBar.text municipio:self.idMunicipio];
            break;
        case INCIDENCIAS_MUNICIPIOS_CERCANAS:
            [IncidenceModel getIncidenciasByDistByTown:@selector(afterGetIncidencias:) fromObject:self offset:[NSString stringWithFormat:@"%d", self.offset] latitud:self.currentLocation.coordinate.latitude longitud:self.currentLocation.coordinate.longitude search: self.searchBar.text municipio:self.idMunicipio];
            break;
        case INCIDENCIAS_USUARIO_RECIENTES:
            [IncidenceModel getIncidenciasPorUsuario:@selector(afterGetIncidencias:) fromObject:self offset:[NSString stringWithFormat:@"%d", self.offset] search: self.searchBar.text estado:self.estado];
            break;
        case INCIDENCIAS_USUARIO_CERCANAS:
            [IncidenceModel getIncidenciasByDistByUser:@selector(afterGetIncidencias:) fromObject:self offset:[NSString stringWithFormat:@"%d", self.offset] latitud:self.currentLocation.coordinate.latitude longitud:self.currentLocation.coordinate.longitude search: self.searchBar.text estado:self.estado];
            break;
            
        default:
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((!self.finLista) && ([self.arrayDatos count] != 0) && (indexPath.row == [self.arrayDatos count] -1))
    {
        [self.spinnerInferior setHidden:false];
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
    
    cell.estado = [[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"estado"];
    if([cell.estado intValue] == 0){
        cell.thumbnail.backgroundColor = [[UIColor alloc]initWithRed:(255/255.0) green:(217/255.0) blue:(191/255.0) alpha:1.0];
    }else if([cell.estado intValue] == 1){
        cell.thumbnail.backgroundColor = [[UIColor alloc]initWithRed:(202/255.0) green:(224/255.0) blue:(243/255.0) alpha:1.0];
    }else{
        cell.thumbnail.backgroundColor = [[UIColor alloc]initWithRed:(213/255.0) green:(210/255.0) blue:(208/255.0) alpha:1.0];
    }
    cell.idIncidencia = [[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"id_incidencia"];
    
    cell.descripcion = [[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"descripcion"];
    cell.user = [[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"id_user"];
    
    switch (_tipoListado) {
            
        case INCIDENCIAS_RECIENTES:
            cell.icon.image = [UIImage imageNamed:@"POR_icon_hora.png"];
            cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"dias"]stringValue],@"d"];
            
            break;
        case INDICENCIAS_CERCANAS:
            
            cell.icon.image = [UIImage imageNamed:@"POR_icon_ubicacion.png"];
            distancia = [[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"distance"]floatValue];
            if(distancia < 1000){
                cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [format stringFromNumber:[NSNumber numberWithFloat:distancia]] ,@"m"];
            }else{
                distancia /= 1000;
                cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [format stringFromNumber:[NSNumber numberWithFloat:distancia]] ,@"km"];
            }
            
            break;
            
        case INCIDENCIAS_MUNICIPIOS_RECIENTES:
            cell.icon.image = [UIImage imageNamed:@"POR_icon_hora.png"];
            cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"dias"]stringValue],@"d"];
            
            break;
        case INCIDENCIAS_MUNICIPIOS_CERCANAS:
            cell.icon.image = [UIImage imageNamed:@"POR_icon_ubicacion.png"];
            distancia = [[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"distance"]floatValue];
            if(distancia < 1000){
                cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [format stringFromNumber:[NSNumber numberWithFloat:distancia]] ,@"m"];
            }else{
                distancia /= 1000;
                cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [format stringFromNumber:[NSNumber numberWithFloat:distancia]] ,@"km"];
            }
            
            break;
            
        case INCIDENCIAS_USUARIO_RECIENTES:
            cell.icon.image = [UIImage imageNamed:@"POR_icon_hora.png"];
            cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"dias"]stringValue],@"d"];
            
            break;
            
        case INCIDENCIAS_USUARIO_CERCANAS:
            
            cell.icon.image = [UIImage imageNamed:@"POR_icon_ubicacion.png"];
            distancia = [[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"distance"]floatValue];
            if(distancia < 1000){
                cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [format stringFromNumber:[NSNumber numberWithFloat:distancia]] ,@"m"];
            }else{
                distancia /= 1000;
                cell.infoIncidencia.text= [NSString  stringWithFormat:@"%@%@",  [format stringFromNumber:[NSNumber numberWithFloat:distancia]] ,@"km"];
            }
            
            break;
            
        default:
            break;
    }
    
    [cell.infoIncidencia removeFromSuperview];
    [cell.infoIncidencia setTranslatesAutoresizingMaskIntoConstraints:YES];
    [cell.infoIncidencia sizeToFit];
    frame = cell.infoIncidencia.frame;
    frame.origin.x = [[UIScreen mainScreen] bounds].size.width - frame.size.width - 15;
    cell.infoIncidencia.frame = frame;
    //cell.infoIncidencia.textAlignment = NSTextAlignmentRight;
    [cell addSubview:cell.infoIncidencia];
    
    [cell.icon removeFromSuperview];
    [cell.icon setTranslatesAutoresizingMaskIntoConstraints:YES];
    frame = cell.icon.frame;
    frame.origin.x = cell.infoIncidencia.frame.origin.x - 12;
    cell.icon.frame = frame;
    [cell addSubview:cell.icon];
    
    [cell.tituloIncidencia removeFromSuperview];
    [cell.tituloIncidencia setTranslatesAutoresizingMaskIntoConstraints:YES];
    frame = cell.tituloIncidencia.frame;
    frame.size.width = cell.icon.frame.origin.x - frame.origin.x - 10;
    cell.tituloIncidencia.frame = frame;
    [cell addSubview:cell.tituloIncidencia];
    
    
    /*NSString *url = [[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"thumbnail"];
    if([url length] > 0)
    {
        // NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        //cell.thumbnail.image = [UIImage imageWithData:data];
        
       
        cell.tag = indexPath.row;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        
        
       dispatch_async(queue, ^(void) {
            
            NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *thumbnail = [UIImage imageWithData:data];
            
           if (thumbnail) {
               dispatch_async(dispatch_get_main_queue(), ^{
                   if (cell.tag == indexPath.row) {
                       cell.thumbnail.image = thumbnail;
                       [cell setNeedsLayout];
                   }
               });
           }
           
        });
    }
    else
    {
        cell.thumbnail.image = [UIImage imageNamed:@"POR_icon_bg_thumbnail.png"];
    }*/


    [cell.thumbnail setImageWithURL:[NSURL URLWithString:[[self.arrayDatos objectAtIndex:indexPath.row]objectForKey:@"thumbnail"]] placeholderImage:[UIImage imageNamed:@"POR_icon_bg_thumbnail.png"]];
    
     [cell.separator setHidden:false];
    
    return cell;
    
}


/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tablaDatos deselectRowAtIndexPath:indexPath animated:NO];
}*/

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.arrayDatos removeAllObjects];
    [self.tablaDatos reloadData];
    [self.spinnerCentral setHidden:false];
    self.finLista = false;
    self.offset = 0;
    [[TimerHelper getInstance]start:1 funcion:@selector(cargarDatos) fromObject:self];
}



@end
