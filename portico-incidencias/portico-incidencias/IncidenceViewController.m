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
#import "UserHelper.h"
#import "ListIncidencesViewController.h"
#import "CellImageGallery.h"
#import "AFHTTPRequestOperation.h"
#import "Constants.h"
#import "DownloadJsonHelper.h"

@interface IncidenceViewController ()

@end

@implementation IncidenceViewController

CGRect frameUserComment;
CGRect frameComment;
CGRect frameSeparator;
int commentHeight;

NSMutableArray *imagesArray;


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
    self.labelNavigationAux.text = NSLocalizedString(@"###incidencia###", nil);
    [self.labelNavigation sizeToFit];
    [self.labelNavigationAux sizeToFit];
    
    self.sendButton.titleLabel.text = NSLocalizedString(@"###enviar###", nil);
    self.textFieldComment.placeholder = NSLocalizedString(@"###addComentario###", nil);
    
    self.titulo.text = self.incidencia.tituloIncidencia.text;
    self.municipio.text = self.incidencia.municipioIncidencia.text;
    if([self.incidencia.estado intValue] == 0){
        self.estado.text = @"Abierta";
        self.imgEstado.image = [UIImage imageNamed:@"POR_icon_incidencias_abiertas.png"];
    }else if([self.incidencia.estado intValue] == 1){
        self.estado.text = @"Cerrada";
        self.estado.textColor = [[UIColor alloc]initWithRed:(43/255.0) green:(133/255.0) blue:(208/255.0) alpha:1.0];
        self.imgEstado.image = [UIImage imageNamed:@"POR_icon_incidencias_cerradas.png"];
        self.imgenPorDefecto.backgroundColor = [[UIColor alloc]initWithRed:(202/255.0) green:(224/255.0) blue:(243/255.0) alpha:1.0];
    }else{
        self.estado.text = @"Archivada";
        self.estado.textColor = [[UIColor alloc]initWithRed:(110/255.0) green:(90/255.0) blue:(99/255.0) alpha:1.0];
        self.imgEstado.image = [UIImage imageNamed:@"POR_icon_incidencias_congeladas.png"];
        self.imgenPorDefecto.backgroundColor = [[UIColor alloc]initWithRed:(213/255.0) green:(210/255.0) blue:(208/255.0) alpha:1.0];
    }
    [self.estado sizeToFit];
    
    if([self.municipio.text isEqualToString:@""] || self.municipio.text == nil){
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
    
    
    [self.miniSeparator removeFromSuperview];
    [self.miniSeparator setTranslatesAutoresizingMaskIntoConstraints:YES];
    frame = self.miniSeparator.frame;
    if([self.botonIrMapa isHidden]){
        frame.origin.y = self.titulo.frame.origin.y + self.titulo.frame.size.height + 10;
    }else{
        frame.origin.y = self.municipio.frame.origin.y + self.municipio.frame.size.height + 10;
    }
    self.miniSeparator.frame = frame;
    [self.mainView addSubview:self.miniSeparator];
    
    if(![self.incidencia.user isKindOfClass:[NSNull class]])
    {
        [self.labelUserDescripcion removeFromSuperview];
        [self.labelUserDescripcion setTranslatesAutoresizingMaskIntoConstraints:YES];
        self.labelUserDescripcion.text = self.incidencia.user;
        [self.labelUserDescripcion sizeToFit];
        frame = self.labelUserDescripcion.frame;
        frame.origin.y = self.miniSeparator.frame.origin.y + self.miniSeparator.frame.size.height + 10;
        self.labelUserDescripcion.frame = frame;
        [self.mainView addSubview:self.labelUserDescripcion];
    }
    
    
    [self.labelDescripcion removeFromSuperview];
    [self.labelDescripcion setTranslatesAutoresizingMaskIntoConstraints:YES];
    self.labelDescripcion.text = self.incidencia.descripcion;
    [self.labelDescripcion sizeToFit];
    frame = self.labelDescripcion.frame;
    frame.origin.y = self.labelUserDescripcion.frame.origin.y + self.labelUserDescripcion.frame.size.height + 10;
    self.labelDescripcion.frame = frame;
    [self.mainView addSubview:self.labelDescripcion];

    [self.commentView removeFromSuperview];
    [self.commentView setTranslatesAutoresizingMaskIntoConstraints:YES];
    frame = self.commentView.frame;
    frame.origin.y = self.labelDescripcion.frame.origin.y + self.labelDescripcion.frame.size.height + 10;
    self.commentView.frame = frame;
    [self.mainView addSubview:self.commentView];
    
    //self.constrainScroll.constant = self.labelDescripcion.frame.origin.y + self.labelDescripcion.frame.size.height + self.actionView.frame.size.height  - (self.scrollView.frame.size.height - self.commentView.frame.origin.y);

    
    //self.constrainScroll.constant = self.labelDescripcion.frame.origin.y + self.labelDescripcion.frame.size.height - self.scrollView.frame.size.height ;
    
    self.constrainScroll.constant = (self.mainView.frame.size.height - [[UIScreen mainScreen] bounds].size.height) + 22;
    
    [self.spinnerAddComment setHidden:false];
   // self.constrainScroll.constant += self.spinnerAddComment.frame.size.height;
    
    [self.doPhotoButton setTitle:NSLocalizedString(@"###doPhoto###", nil) forState:UIControlStateNormal];
    [self.selectPhotoButton setTitle:NSLocalizedString(@"###selectFoto###", nil) forState:UIControlStateNormal];
    [self.cancelButton setTitle:NSLocalizedString(@"###cancel###", nil) forState:UIControlStateNormal];
   
    
    //[self.collectionView registerClass:[CellImageGallery class] forCellWithReuseIdentifier:@"cellImageGallery"];
    imagesArray = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    self.photoView.layer.borderColor = [[UIColor alloc]initWithRed:(181/255.0) green:(180/255.0) blue:(179/255.0) alpha:1.0].CGColor;
    self.photoView.layer.borderWidth = 1.0f;

    self.library = [[ALAssetsLibrary alloc] init];
    
    [IncidenceModel getIncidenceComents:@selector(afterGetComments:) fromObject:self idIncidencia:self.incidencia.idIncidencia];
    [self loadImages];
    
    [self.progressBar setHidden:true];
    self.progressBar.progress = 0.0;
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Nos damos de alta en la notificación del teclado para adaptar la Text View
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [center addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    if(self.ocultarNavigationBar){
        [self.goListButton setHidden:false];
        self.navigationController.navigationBar.hidden = YES;
    }
    else{
        [self.goListButton setHidden:true];
        self.navigationController.navigationBar.hidden = NO;
    }
    
    //self.constrainScroll.constant = (self.mainView.frame.size.height - [[UIScreen mainScreen] bounds].size.height) + 22;
}


- (void)viewDidAppear:(BOOL)animated{
    [self actualizaProgressBar];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Nos damos de baja en la notificación del teclado para adaptar la Text View
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    
    [self.goListButton setHidden:true];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidUnload
{
    self.library = nil;
    [super viewDidUnload];
}

-(void) loadImages
{
    [IncidenceModel getIncidenceImages:@selector(afterGetImages:) fromObject:self idIncidencia:self.incidencia.idIncidencia];
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
            
            //CGRect frame = self.actionView.frame;
            //frame.origin.y -= keyboardRect.size.height;
            //self.actionView.frame = frame;
            //self.constrainActionView.constant = keyboardRect.size.height + 45;
            
            [self.actionView removeFromSuperview];
            [self.actionView setTranslatesAutoresizingMaskIntoConstraints:YES];
            CGRect frame = self.actionView.frame;
            frame.origin.y -= keyboardRect.size.height;
            self.actionView.frame = frame;
            [self.view addSubview:self.actionView];
            [self.textFieldComment becomeFirstResponder];
            
            self.constrainScroll.constant += keyboardRect.size.height;
            
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
        
        [self.actionView removeFromSuperview];
        [self.actionView setTranslatesAutoresizingMaskIntoConstraints:YES];
        CGRect frame = self.actionView.frame;
        frame.origin.y += keyboardRect.size.height;
        self.actionView.frame = frame;
        [self.view addSubview:self.actionView];
        
        self.constrainScroll.constant -= keyboardRect.size.height;

        
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
    [self.spinnerAddComment setHidden:true];
    //self.constrainScroll.constant -= self.spinnerAddComment.frame.size.height;
    
    frameUserComment = self.userComment.frame;
    frameComment = self.labelComent.frame;
    frameSeparator = self.separatorComment.frame;
    commentHeight = 0;
    
    for (NSDictionary *comentario in [json objectForKey:@"results"])
    {
        [self addCommentToView:[comentario objectForKey:@"contenido"] fromUser:[comentario objectForKey:@"email"]];
    }
    //self.constrainScroll.constant = commentHeight + self.actionView.frame.size.height - (self.scrollView.frame.size.height - self.commentView.frame.origin.y);

    int aux = commentHeight - (self.scrollView.frame.size.height - self.commentView.frame.origin.y);
    if(aux > 0)
    {
        self.constrainScroll.constant += aux;
    }
    
    [self.commentView removeFromSuperview];
    [self.commentView setTranslatesAutoresizingMaskIntoConstraints:YES];
    CGRect frame = frame = self.commentView.frame;
    frame.size.height += self.constrainScroll.constant;
    self.commentView.frame = frame;
    [self.mainView addSubview:self.commentView];
}

- (void)addCommentToView: (NSString*) comentario fromUser: (NSString*) user
{
    UILabel *aux;
    UILabel *aux2;
    UIView *auxSeparator;
    
    auxSeparator = [[UIView alloc]initWithFrame:frameSeparator];
    auxSeparator.backgroundColor = self.separatorComment.backgroundColor;
    [self.commentView addSubview:auxSeparator];
    
    aux = [[UILabel alloc]initWithFrame:frameUserComment];
    aux.font = self.userComment.font;
    aux.text = user;
    aux.textColor = self.userComment.textColor;
    [aux sizeToFit];
    [self.commentView addSubview:aux];
    
    aux2 = [[UILabel alloc]initWithFrame:frameComment];
    aux2.font = self.labelComent.font;
    aux2.text = comentario;
    aux2.textColor = self.labelComent.textColor;
    aux2.numberOfLines = 0;
    aux2.autoresizesSubviews = YES;
    [aux2 sizeToFit];
    [self.commentView addSubview:aux2];
    
    frameSeparator.origin.y = aux.frame.origin.y + aux.frame.size.height + aux2.frame.size.height + 25;
    frameUserComment.origin.y = frameSeparator.origin.y + 10;
    frameComment.origin.y =frameUserComment.origin.y + 29;
    
    commentHeight += aux.frame.size.height + aux2.frame.size.height  + 25 + 10;
    
    [self.commentView setHidden:false];
}

- (IBAction)addComment:(id)sender {
    if(![self.textFieldComment.text isEqualToString:@""]){
        [IncidenceModel addComment:@selector(afterAddComment:) fromObject:self comment:self.textFieldComment.text idIncidencia:self.incidencia.idIncidencia];
        [self.spinnerAddComment setHidden:false];
        self.constrainScroll.constant += self.spinnerAddComment.frame.size.height;
        [self.textFieldComment resignFirstResponder];
        self.textFieldComment.text = @"";
        self.textFieldComment.placeholder = NSLocalizedString(@"###addComentario###", nil);
    }
}

-(void) afterAddComment: (NSDictionary*) json
{
    [self.spinnerAddComment setHidden:true];
    self.constrainScroll.constant -= self.spinnerAddComment.frame.size.height;
    
    [self addCommentToView:[[json objectForKey:@"result"]objectForKey:@"contenido"] fromUser:[[json objectForKey:@"result"]objectForKey:@"id_user"]];
    //self.constrainScroll.constant = commentHeight + self.actionView.frame.size.height - (self.scrollView.frame.size.height - self.commentView.frame.origin.y);
    self.constrainScroll.constant = (self.mainView.frame.size.height - [[UIScreen mainScreen] bounds].size.height) + 22;
    self.constrainScroll.constant += commentHeight - (self.scrollView.frame.size.height - self.commentView.frame.origin.y);



    CGPoint bottomOffset = CGPointMake(0, self.constrainScroll.constant);
    [self.scrollView setContentOffset:bottomOffset];
    
    [self.commentView removeFromSuperview];
    [self.commentView setTranslatesAutoresizingMaskIntoConstraints:YES];
    CGRect frame = frame = self.commentView.frame;
    if(self.constrainScroll.constant < (self.scrollView.frame.size.height - frame.size.height)){
        frame.size.height += (self.scrollView.frame.size.height - frame.size.height);
    }else{
        frame.size.height += self.constrainScroll.constant;
    }
    self.commentView.frame = frame;
    [self.mainView addSubview:self.commentView];
}

- (IBAction)showAddPhoto:(id)sender
{
    
    [self backgroundTouched:sender];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0.0];
    
    [self.photoView removeFromSuperview];
    [self.photoView setTranslatesAutoresizingMaskIntoConstraints:YES];
    CGRect frame = self.photoView.frame;
    frame.origin.y = [[UIScreen mainScreen] bounds].size.height - frame.size.height - self.actionView.frame.size.height - 10;;
    self.photoView.frame = frame;
    [self.view addSubview:self.photoView];
    
    [self.mainView setAlpha:0.2];
    
    [UIView commitAnimations];
    
}

- (IBAction)doPhoto:(id)sender
{
    // Creo el View Controller
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    // Nos declaramos su delegado
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    [self cancelPhoto];
}

- (IBAction)selectPhoto:(id)sender
{
    // Creo el View Controller
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // Nos declaramos su delegado
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    [self cancelPhoto];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.progressBar setHidden:false];

    [IncidenceModel addImages:@selector(reloadImages) fromObject:self parameters:[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.incidencia.idIncidencia,@"id",nil] images:[[NSMutableArray alloc]initWithObjects:image, nil]];
    
    if(image.size.width != self.collectionView.frame.size.width || image.size.height != self.collectionView.frame.size.height){
        CGFloat oldWidth = image.size.width;
        CGFloat oldHeight = image.size.height;
        CGFloat scaleFactor = (oldWidth > oldHeight) ? self.collectionView.frame.size.width / oldWidth : self.collectionView.frame.size.height / oldHeight;
        CGFloat newHeight = oldHeight * scaleFactor;
        CGFloat newWidth = oldWidth * scaleFactor;
        CGSize newSize = CGSizeMake(newWidth, newHeight);
        
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    [imagesArray addObject:image];

    [self actualizaProgressBar];
    
    
    
    //Guardo la imagen en el album
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        NSString *albumName=@"Pórtico";
        __block ALAssetsGroup* groupToAddTo;
        
        [self.library enumerateGroupsWithTypes:ALAssetsGroupAlbum
                                    usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                        if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:albumName]) {
                                            groupToAddTo = group;
                                        }
                                    }
                                  failureBlock:^(NSError* error) {
                                  }];
        CGImageRef img = [image CGImage];
        
        [self.library writeImageToSavedPhotosAlbum:img
                                       orientation:((ALAssetOrientation)image.imageOrientation)
                                   completionBlock:^(NSURL* assetURL, NSError* error) {
                                       if (error.code == 0) {
                                           
                                           // try to get the asset
                                           [self.library assetForURL:assetURL
                                                         resultBlock:^(ALAsset *asset) {
                                                             // assign the photo to the album
                                                             [groupToAddTo addAsset:asset];
                                                         }
                                                        failureBlock:^(NSError* error) {
                                                        }];
                                       }
                                       else {
                                       }
                                   }];

    }
    
    

    [self dismissViewControllerAnimated:NO completion:nil];
    
    self.constrainTopMainView.constant = -132;
    self.constrainScroll.constant = (self.mainView.frame.size.height - [[UIScreen mainScreen] bounds].size.height) + 22;
    self.constrainScroll.constant += commentHeight - (self.scrollView.frame.size.height - self.commentView.frame.origin.y);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    self.constrainTopMainView.constant = -132;
    self.constrainScroll.constant = (self.mainView.frame.size.height - [[UIScreen mainScreen] bounds].size.height) + 22;
    self.constrainScroll.constant += commentHeight - (self.scrollView.frame.size.height - self.commentView.frame.origin.y);
}

- (void) reloadImages
{
    [self.collectionView reloadData];
    [self.spinnerImage setHidden:true];
    [self.imgenPorDefecto setHidden:true];
    self.contadorImages.text = [NSString stringWithFormat:@"%lu", (unsigned long)[imagesArray count]];
}

- (void) afterGetImages: (NSDictionary*) json
{
    imagesArray = [[NSMutableArray alloc] init];
    
    if([[json objectForKey:@"result"] count] == 0)
    {
        [self.spinnerImage setHidden:true];
        [self.imgenPorDefecto setHidden:false];
    }
    
    for (NSDictionary *imagen in [json objectForKey:@"result"])
    {
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[imagen objectForKey:@"url"]]]];
        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            UIImage *image = (UIImage*)responseObject;

            if(image.size.width != self.collectionView.frame.size.width || image.size.height != self.collectionView.frame.size.height){
               CGFloat oldWidth = image.size.width;
               CGFloat oldHeight = image.size.height;
               CGFloat scaleFactor = (oldWidth > oldHeight) ? self.collectionView.frame.size.width / oldWidth : self.collectionView.frame.size.height / oldHeight;
               CGFloat newHeight = oldHeight * scaleFactor;
               CGFloat newWidth = oldWidth * scaleFactor;
               CGSize newSize = CGSizeMake(newWidth, newHeight);
                
                UIGraphicsBeginImageContext(newSize);
                [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
                image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
            
            [imagesArray addObject:image];
            [self reloadImages];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self.spinnerImage setHidden:true];
            [self.imgenPorDefecto setHidden:false];
        }];
        [requestOperation start];
    }
    
    
    
    
}

- (IBAction)cancelPhoto:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0.0];
    [self cancelPhoto];
    [UIView commitAnimations];
}

- (void) cancelPhoto{
    
    [self.photoView removeFromSuperview];
    [self.photoView setTranslatesAutoresizingMaskIntoConstraints:YES];
    CGRect frame = self.photoView.frame;
    frame.origin.y = [[UIScreen mainScreen]bounds].size.height;
    self.photoView.frame = frame;
    [self.view addSubview:self.photoView];
    
    [self.mainView setAlpha:1.0];
}

-(IBAction)backgroundTouched:(id)sender
{
    [self.textFieldComment resignFirstResponder];
}

- (IBAction)goToList:(id)sender {
    
    UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
    
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    
    tabBarItem1.title = NSLocalizedString(@"###incidencias###", nil);
    tabBarItem2.title = NSLocalizedString(@"###municipios###", nil);
    tabBarItem3.title = NSLocalizedString(@"###usuario###", nil);
    
    [tabBarItem1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:247/255.0 green:77/255.0 blue:41/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateSelected];
    
    [tabBarItem2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:247/255.0 green:77/255.0 blue:41/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateSelected];
    
    [tabBarItem3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:247/255.0 green:77/255.0 blue:41/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateSelected];
    
    
    [tabBarItem1 setSelectedImage:[[UIImage imageNamed:@"POR_menu_icon_incidencias_ON.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem1 setImage:[[UIImage imageNamed:@"POR_menu_icon_incidencias_OFF.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [tabBarItem2 setSelectedImage:[[UIImage imageNamed:@"POR_menu_icon_municipios_ON.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem2 setImage:[[UIImage imageNamed:@"POR_menu_icon_municipios_OFF.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [tabBarItem3 setSelectedImage:[[UIImage imageNamed:@"POR_menu_icon_usuario_ON.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem3 setImage:[[UIImage imageNamed:@"POR_menu_icon_usuario_OFF.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
//    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"POR_menu_icon_incidencias_ON.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"POR_menu_icon_incidencias_OFF.png"]];
//    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"POR_menu_icon_municipios_ON.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"POR_menu_icon_municipios_OFF.png"]];
//    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"POR_menu_icon_usuario_ON.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"POR_menu_icon_usuario_OFF.png"]];
//    
    
    [self presentViewController:tabBarController animated:YES completion:nil];

}


-(void) actualizaProgressBar{
    
    NSMutableArray *arrayProgress = [[[DownloadJsonHelper getInstance]progreso]objectForKey:[self.incidencia.idIncidencia stringValue]];
    
    if(arrayProgress != nil){
        [self.progressBar setHidden:false];
        float bytes = [[arrayProgress objectAtIndex:0]floatValue];
        float totalVytes = [[arrayProgress objectAtIndex:1]floatValue];
        //if(self.progressBar.progress < 1.0){
        if(totalVytes != 0){
            [self.progressBar setProgress:bytes/totalVytes animated:NO];
            //NSLog(@"Espero subir: %f", self.progressBar.progress);
        }
        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(actualizaProgressBar) userInfo:nil repeats:NO];
    }
    else{
        [self.progressBar setHidden:true];
    }
    
}





-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [imagesArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellImageGallery *cell = (CellImageGallery *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellImageGallery" forIndexPath:indexPath];
    cell.image.image = [imagesArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(320, 240);
    //return ((UIImage *)[imagesArray objectAtIndex:indexPath.row]).size;
}

@end
