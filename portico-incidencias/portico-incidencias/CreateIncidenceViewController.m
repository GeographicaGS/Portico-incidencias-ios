//
//  CreateIncidenceViewController.m
//  Pórtico incidencias
//
//  Created by Javier Aragón on 21/04/14.
//  Copyright (c) 2014 Javier Aragón. All rights reserved.
//

#import "CreateIncidenceViewController.h"
#import "LocationHelper.h"
#import "IncidenceModel.h"
#import "UserHelper.h"
#import "IncidenceViewController.h"
#import "ListIncidencesViewController.h"

@interface CreateIncidenceViewController ()

@end

@implementation CreateIncidenceViewController

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
    
    UIColor *colorPlaceHolder = [[UIColor alloc]initWithRed:(205/255.0) green:(205/255.0) blue:(202/255.0) alpha:1.0];
   
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height +20)];
    [v setBackgroundColor: [[UIColor alloc]initWithRed:(74/255.0) green:(60/255.0) blue:(49/255.0) alpha:1.0]];
    [self.view addSubview:v];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    
    
    
    self.labelNavigation.text = NSLocalizedString(@"###newIncidence###", nil);
    [self.createButtom setTitle:NSLocalizedString(@"###doIt###", nil) forState:UIControlStateNormal];
    self.incidenceTitle.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"###incidenceTitle###", nil) attributes:@{NSForegroundColorAttributeName: colorPlaceHolder}];
    
    self.incidenceDescription.text = NSLocalizedString(@"###incidenceDescription###", nil);
    
     self.latitud.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"###latitude###", nil) attributes:@{NSForegroundColorAttributeName: colorPlaceHolder}];
    
     self.longitud.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"###longitude###", nil) attributes:@{NSForegroundColorAttributeName: colorPlaceHolder}];
    
    [self.addImageButton setTitle:NSLocalizedString(@"###addPhoto###", nil) forState:UIControlStateNormal];
    [self.locateButton setTitle:NSLocalizedString(@"###currentLocation###", nil) forState:UIControlStateNormal];
    
    self.incidenceDescription.delegate = self;
    self.incidenceTitle.delegate = self;
    self.incidenceDescription.delegate = self;
    self.latitud.delegate = self;
    self.longitud.delegate = self;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.incidenceDescription.text isEqualToString:NSLocalizedString(@"###incidenceDescription###", nil)]) {
        self.incidenceDescription.text = @"";
        self.incidenceDescription.textColor = [[UIColor alloc]initWithRed:(110/255.0) green:(99/255.0) blue:(90/255.0) alpha:1.0];
    }
    [self.incidenceDescription becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.incidenceDescription.text isEqualToString:@""]) {
        self.incidenceDescription.text = NSLocalizedString(@"###incidenceDescription###", nil);
        self.incidenceDescription.textColor = [[UIColor alloc]initWithRed:(205/255.0) green:(202/255.0) blue:(199/255.0) alpha:1.0];
    }
    [textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTouched:(id)sender {
    [self.incidenceTitle resignFirstResponder];
    [self.incidenceDescription resignFirstResponder];
    [self.latitud resignFirstResponder];
    [self.longitud resignFirstResponder];
}

- (IBAction)getCurrenLocation:(id)sender {
    [[LocationHelper getInstance]getCurrentLocation:@selector(afterGetCurrentLocation:) fromObject:self];
}

- (void) afterGetCurrentLocation: (CLLocation*) currentLocation{
    self.latitud.text = [[NSString alloc] initWithFormat:@"%f", currentLocation.coordinate.latitude] ;
    self.longitud.text = [[NSString alloc] initWithFormat:@"%f", currentLocation.coordinate.longitude] ;
}

- (IBAction)createIncidence:(id)sender {
    if(![self.incidenceTitle.text isEqualToString:@""] && (![self.incidenceDescription.text isEqualToString:@""] || [self.incidenceDescription.text isEqualToString:NSLocalizedString(@"###incidenceDescription###", nil)]) && ![self.latitud.text isEqualToString:@""] && ![self.longitud.text isEqualToString:@""]){

        [self.spinner setHidden:false];
        [self backgroundTouched:sender];
        
          NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.incidenceTitle.text, @"titulo", self.incidenceDescription.text, @"descripcion", @"0", @"estado", [[UserHelper getInstance]getUsuario], @"id_user", self.latitud.text, @"latitud", self.longitud.text, @"longitud", nil];
        
        [IncidenceModel createIncidence:@selector(afterCreateIncidence:) fromObject:self parameters:parameters];

    }else{
        NSString *error = @"";;
        if([self.incidenceTitle.text isEqualToString:@""]){
            error = @"La incidencia debe tener un título.";
            
        }else if([self.incidenceDescription.text isEqualToString:@""] || [self.incidenceDescription.text isEqualToString:NSLocalizedString(@"###incidenceDescription###", nil)]){
            error = @"La incidencia debe tener una descripción.";
            
        }else{
           error = @"La incidencia debe estar localizada. Complete los campos latitud y longitud.";
            
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Complete los campos obligatorios"
                                                        message:error
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void) afterCreateIncidence: (NSDictionary*) json{
    
    [self.spinner setHidden:true];
    NSDictionary* result = [json objectForKey:@"result"];
    
    IncidenceViewController *incidenceView = [self.storyboard instantiateViewControllerWithIdentifier:@"IncidenceViewController"];
    
    CellIncidenceModel *incidencia = [[CellIncidenceModel alloc]init];
    
    [incidencia setTituloIncidencia:[[UILabel alloc]init]];
    [incidencia.tituloIncidencia setText:[result objectForKey:@"titulo"]];
    
    [incidencia setMunicipioIncidencia:[[UILabel alloc]init]];
    [incidencia.municipioIncidencia setText:[result objectForKey:@"nombre_municipio"]];
    
    [incidencia setDescripcion:[result objectForKey:@"descripcion"]];
    [incidencia setUser:[result objectForKey:@"id_user"]];
    
    [incidencia setIdIncidencia:[NSNumber numberWithInt:[[result objectForKey:@"id_incidencia"] intValue]]];
    [incidencia setEstado:[result objectForKey:[result objectForKey:@"estado"]]];
    
    [incidenceView setIncidencia:incidencia];

    incidenceView.ocultarNavigationBar = true;
    [self.navigationController pushViewController:incidenceView animated:YES];
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"awdadwa" style:UIBarButtonItemStylePlain target:nil action:nil];
}*/

@end
