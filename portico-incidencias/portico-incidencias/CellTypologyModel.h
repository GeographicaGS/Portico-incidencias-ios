//
//  CellTypologyModel.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 11/11/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellTypologyModel : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *tick;

@property NSNumber *idTypology;

@end
