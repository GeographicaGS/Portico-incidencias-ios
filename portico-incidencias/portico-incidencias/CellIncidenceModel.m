//
//  CellIncidenceModel.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 13/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "CellIncidenceModel.h"

@implementation CellIncidenceModel

@synthesize thumbnail,tituloIncidencia, municipioIncidencia, infoIncidencia, icon, separator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
//    separator.layer.borderColor =  [separator.backgroundColor CGColor];
//    separator.layer.borderWidth = (1.0 / [UIScreen mainScreen].scale) / 2;
//
    CGRect frame = separator.frame;
    frame.size.height = (1.0 / [UIScreen mainScreen].scale) / 2;
    separator.frame = frame;
}

@end
