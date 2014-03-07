//
//  TableHelper.h
//  Pórtico incidencias
//
//  Created by Javier Aragón on 14/02/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableHelper : NSObject <UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *spinnerViewInferior;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerCentral;
@property (weak, nonatomic) IBOutlet UITableView *tablaDatos;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) int offset;
@property (nonatomic) bool buscando;
@property (nonatomic) bool finLista;
@property (strong) NSMutableArray *arrayDatos;

- (void) afterGetIncidencias: (NSDictionary*) json;
- (void) cargarDatos;

@end
