//
//  FirstViewController.m
//  SUPORTE
//
//  Created by Victor Antoniazzi on 20/07/12.
//  Copyright (c) 2012 UCPel. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

@synthesize scroll;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(IBAction)atualiza{
    
    [NSThread detachNewThreadSelector:@selector(metodoThread) toTarget:self withObject:nil];
        
}

-(void)metodoThread{
    
    FotosTirinhas = [[NSMutableArray alloc] init];
    [self analisaXML];
    [self adicionaImagens]; 

    
}

-(void)analisaXML{
    
    noticiasArray = [[NSMutableArray alloc] init];
    
    
    NSXMLParser *photoParser = [[NSXMLParser alloc] 
                                initWithContentsOfURL:
                                [NSURL URLWithString:@"http://feeds.feedburner.com/vidasuporte.xml"]];
    [photoParser setDelegate:self];
    [photoParser parse];
    
    //-----------------------------------------
    
    for (int w = 0; w < 10; w++) {
        
        bool passou = NO;
        
        NSDictionary *rowdict = [noticiasArray objectAtIndex:w];
        
        NSString *bruto = [rowdict objectForKey:@"content:encoded"];
        
        NSString *lapidando = @"";
        
        
        for (int i = 0; i < bruto.length-4 ; i++) {
            
            lapidando=[[bruto substringToIndex:i+4] substringFromIndex:i];
            
            if ([lapidando isEqualToString:@"http"]){
                
                for (int j = i; j < 120; j++) {
                    
                    lapidando=[[bruto substringToIndex:j+4] substringFromIndex:j];
                    
                    if ([lapidando isEqualToString:@".jpg"] && [lapidando length] ){
                        
                        lapidando=[[bruto substringToIndex:j+4] substringFromIndex:i];
                        
                            if (lapidando.length < 77){
                            
                                [FotosTirinhas addObject:lapidando];
                        
                                NSLog(lapidando);
                        
                                passou = YES;
                        
                                break;
                            }
                    }
                    if (passou){
                        break;
                    }
                }
                
            }
            if (passou){
                break;
            }   
        }
        
    }
}


-(void)adicionaImagens{
    
    for (int i = 0; i < 7; i++) {
        
        
        NSURL *imgURL = [NSURL URLWithString:[FotosTirinhas objectAtIndex:i]];
        
        NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
        
        UIImageView *imagem = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 00.0f, 768.0f,  740.0f)]; 
        [imagem setImage:[UIImage imageWithData:imgData]]; 
        
        imagem.frame = CGRectMake(i*768, 0, 771, 740);
        
        [scroll addSubview:imagem];
        
    }
    
    scroll.contentSize = CGSizeMake((768*7), 738);
    scroll.pagingEnabled=YES;    
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict { 
    
    if (noticiaDict) {
        currentElement = [[NSString alloc] initWithString:elementName];
        elementString = [[NSMutableString alloc] init];
    }
    
    if ([elementName isEqualToString:@"item"]) {
        
        noticiaDict = [[NSMutableDictionary alloc] init];
    }
    
    
}

-(void) parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string{
    
    if (currentElement) {
        [elementString appendString:string];
    }
    
}


-(void) parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{
    
    
    if (noticiaDict && currentElement
        && elementString) {
        [noticiaDict setObject:elementString forKey:currentElement];
        
        currentElement = nil;
        elementString = nil;
    }
    if ([elementName
         isEqualToString:@"item"]) {
        [noticiasArray
         addObject:noticiaDict];
        
        elementString = nil;
        currentElement = nil;
        noticiaDict = nil;
    }
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
}

@end
