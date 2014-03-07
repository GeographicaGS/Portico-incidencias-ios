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
@property (weak, nonatomic) IBOutlet UILabel *tituloIncidencia;
@property (weak, nonatomic) IBOutlet UILabel *municipioIncidencia;
@property (weak, nonatomic) IBOutlet UILabel *infoIncidencia;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end
