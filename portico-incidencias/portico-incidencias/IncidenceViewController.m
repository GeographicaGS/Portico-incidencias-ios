//
//  IncidenceViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 14/04/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "IncidenceViewController.h"
#import "MapViewController.h"
#import "IncidenceModel.h"

@interface IncidenceViewController ()

@end

@implementation IncidenceViewController

CGRect frameUserComment;
CGRect frameComment;
CGRect frameSeparator;
int commentHeight;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textFieldComment.delegate = self;

    self.labelNavigation.text = NSLocalizedString(@"###incidencia###", nil);
    [self.labelNavigation sizeToFit];
    
    self.sendButton.titleLabel.text = NSLocalizedString(@"###enviar###", nil);
    self.textFieldComment.placeholder = NSLocalizedString(@"###addComentario###", nil);
    
    self.titulo.text = self.incidencia.tituloIncidencia.text;
    self.municipio.text = self.incidencia.municipioIncidencia.text;
    if([self.incidencia.estado intValue] == 0){
        self.estado.text = @"Abierta";
        self.imgEstado.image = [UIImage imageNamed:@"POR_icon_incidencias_abiertas.png"];
    }else if([self.incidencia.estado intValue] == 1){
        self.estado.text = @"Cerrada";
        self.imgEstado.image = [UIImage imageNamed:@"POR_icon_incidencias_cerradas.png"];
    }else{
        self.estado.text = @"Congelada";
        self.imgEstado.image = [UIImage imageNamed:@"POR_icon_incidencias_congeladas.png"];
    }
    [self.estado sizeToFit];
    
    if([self.municipio.text isEqualToString:@""]){
        [self.botonIrMapa setHidden:true];
    }else{
        [self.botonIrMapa setHidden:false];
    }

    CGRect frame;
    
    [self.titulo removeFromSuperview];
    [self.titulo setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.titulo sizeToFit];
    [self.mainView addSubview:self.titulo];
    
    
    [self.botonIrMapa removeFromSuperview];
    [self.botonIrMapa setTranslatesAutoresizingMaskIntoConstraints:YES];
    frame = self.botonIrMapa.frame;
    frame.origin.y = self.titulo.frame.origin.y;
    frame.origin.y += self.titulo.frame.size.height;
    self.botonIrMapa.frame = frame;
    [self.mainView addSubview:self.botonIrMapa];
    
    [self.municipio removeFromSuperview];
    [self.municipio setTranslatesAutoresizingMaskIntoConstraints:YES];
    frame = self.municipio.frame;
    frame.origin.y = self.botonIrMapa.frame.origin.y + 5;
    self.municipio.frame = frame;
    [self.mainView addSubview:self.municipio];
    

    [self.commentView removeFromSuperview];
    [self.commentView setTranslatesAutoresizingMaskIntoConstraints:YES];
    frame = self.commentView.frame;
    if([self.botonIrMapa isHidden]){
        frame.origin.y = self.titulo.frame.origin.y + self.titulo.frame.size.height + 5;
    }else{
        frame.origin.y = self.municipio.frame.origin.y + self.municipio.frame.size.height + 5;
    }
    self.commentView.frame = frame;
    [self.mainView addSubview:self.commentView];
    
    
    
    [IncidenceModel getIncidenceComents:@selector(afterGetComments:) fromObject:self idIncidencia:self.incidencia.idIncidencia];

}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Nos damos de alta en la notificación del teclado para adaptar la Text View
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [center addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Nos damos de baja en la notificación del teclado para adaptar la Text View
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    
}

-(void)keyboardWillAppear:(NSNotification *)notification {
    
    // Verificamos si el UITextField 2 es el responder
    if ([self.textFieldComment isFirstResponder]) {
        
        // Sacar el frame final del teclado de la notificacion
        // Este es el rectángulo que va a ocupar el teclado
        CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        /*CGRect newRect = CGRectMake(self.view.frame.origin.x,
                                    self.view.frame.origin.y - keyboardRect.size.height,
                                    self.view.frame.size.width,
                                    self.view.frame.size.height);*/
        
        // Tiempo que va a durar la animación del teclado
        NSTimeInterval seconds = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        // Crear mi bloque de animación para el textview
        [UIView animateWithDuration:seconds animations:^{
            
            // Cambiamos el frame del TextView para adaptarla al teclado que aparece
           // self.view.frame = newRect;
            
            CGRect frame = self.actionView.frame;
            frame.origin.y -= keyboardRect.size.height;
            self.actionView.frame = frame;
            
        }];
    }
}


-(void)keyboardWillDisappear:(NSNotification *)notification {
    
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Tiempo que va a durar la animación del teclado
    NSTimeInterval seconds = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // El frame original era...
    /*CGRect oldFrame = CGRectMake(0,
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);*/
    
    // Dejamos la altura de la textview en su valor original
    [UIView animateWithDuration:seconds animations:^{
        
        //self.view.frame = oldFrame;
        CGRect frame = self.actionView.frame;
        frame.origin.y += keyboardRect.size.height;
        self.actionView.frame = frame;

        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueMapIncidence"]){
        MapViewController *map = [segue destinationViewController];
        [map setNavigate:false];
        [IncidenceModel getGeoJsonIncidencia:@selector(afterGetAllIncidences:) fromObject:map idIncidencia:self.incidencia.idIncidencia];
    }
}

- (void) afterGetComments: (NSDictionary*) json
{
    [self.spinner setHidden:true];
    frameUserComment = self.userComment.frame;
    frameComment = self.labelComent.frame;
    frameSeparator = self.separatorComment.frame;
    UILabel *aux;
    UILabel *aux2;
    UIView *auxSeparator;
    commentHeight = 0;
    for (NSDictionary *comentario in [json objectForKey:@"results"])
    {
        auxSeparator = [[UIView alloc]initWithFrame:frameSeparator];
        auxSeparator.backgroundColor = self.separatorComment.backgroundColor;
        [self.commentView addSubview:auxSeparator];
        
        aux = [[UILabel alloc]initWithFrame:frameUserComment];
        aux.font = self.userComment.font;
        aux.text = [comentario objectForKey:@"email"];
        aux.textColor = self.userComment.textColor;
        [aux sizeToFit];
        [self.commentView addSubview:aux];
        
        aux2 = [[UILabel alloc]initWithFrame:frameComment];
        aux2.font = self.labelComent.font;
        aux2.text = [comentario objectForKey:@"contenido"];
        aux2.textColor = self.labelComent.textColor;
        aux2.numberOfLines = 0;
        aux2.autoresizesSubviews = YES;
        [aux2 sizeToFit];
        [self.commentView addSubview:aux2];
        
        frameSeparator.origin.y = aux.frame.origin.y + aux.frame.size.height + aux2.frame.size.height + 25;
        frameUserComment.origin.y = frameSeparator.origin.y + 10;
        frameComment.origin.y =frameUserComment.origin.y + 29;
        
        commentHeight += aux.frame.size.height + aux2.frame.size.height + 29;
    }
    
    self.constrainScroll.constant = commentHeight + self.actionView.frame.size.height -  200;
     if(![self.botonIrMapa isHidden]){
         self.constrainScroll.constant += self.municipio.frame.size.height;
     }

}

-(IBAction)backgroundTouched:(id)sender
{
    [self.textFieldComment resignFirstResponder];
}




@end
