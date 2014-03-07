//
//  CellIncidenceTownModel.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 14/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "CellIncidenceTownModel.h"

@implementation CellIncidenceTownModel

@synthesize nombreMunicipio, numIncidencias;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
