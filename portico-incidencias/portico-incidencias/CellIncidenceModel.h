//
//  CellIncidenceModel.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 13/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellIncidenceModel : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;


@property (nonatomic, retain) IBOutlet UILabel *tituloIncidencia;
@property (nonatomic, retain) IBOutlet UILabel *municipioIncidencia;
@property (nonatomic, retain) IBOutlet NSNumber *estado;
@property NSNumber *idIncidencia;

@property (weak, nonatomic) IBOutlet UILabel *infoIncidencia;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *separator;


@property  NSString *descripcion;
@property  NSString *user;

@end
