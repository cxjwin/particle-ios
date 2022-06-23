//
//  MainViewController.m
//  DemoObjc
//
//  Created by link on 2022/6/21.
//

#import "MainViewController.h"
#import "SwitchChainViewController.h"
#import "APIReferenceViewController.h"

@import ParticleAuthService;
@import ParticleNetworkBase;
@import ParticleWalletGUI;
@import ParticleWalletAPI;

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginWithEmailButton;
@property (weak, nonatomic) IBOutlet UIButton *loginWithPhoneButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *openWalletButton;
@property (weak, nonatomic) IBOutlet UIButton *switchChainButton;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *welcomeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *coreImageView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ChainName *chainName = ParticleNetwork.getChainName;
    NSString *nameString = chainName.nameString;
    Name name = chainName.name;
    NSString *network = chainName.network;
    NSLog(@"%@, %@", nameString, network);
    
    [self showLogin:true];
    self.switchChainButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.switchChainButton.titleLabel.numberOfLines = 2;
    self.switchChainButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.switchChainButton.transform = CGAffineTransformMakeRotation(M_PI / 4);
    
    
    if ([ParticleAuthService isUserLoggedIn]) {
        [self showLogin:NO];
    } else {
        [self showLogin:YES];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newUserInfo:) name:[Notifications newUserInfo] object:nil];
    UserInfo *userInfo = [ParticleAuthService getUserInfo];
    NSString *address = userInfo.address;
    NSString *uuid = userInfo.uuid;
    NSString *token = userInfo.token;
    NSString *publicKey = userInfo.publicKey;
    
    NSLog(@"uuid = %@, token = %@, address = %@, publicKey = %@", uuid, token, address, publicKey);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateUI];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[Notifications newUserInfo] object:nil];
}


- (void)newUserInfo:(NSNotification *)notification {
    
}

- (IBAction)loginWithEmail {
    [ParticleAuthService loginWithType:LoginTypeEmail successHandler:^(UserInfo * userInfo) {
        NSLog(@"%@", userInfo);
        [self showLogin:NO];
    } failureHandler:^(NSError * error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)loginWithPhone {
    [ParticleAuthService loginWithType:LoginTypePhone successHandler:^(UserInfo * userInfo) {
        NSLog(@"%@", userInfo);
        [self showLogin:NO];
    } failureHandler:^(NSError * error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)logout {
    [ParticleAuthService logoutWithSuccessHandler:^(NSString * result) {
        NSLog(@"%@", result);
        [self showLogin:YES];
    } failureHandler:^(NSError * error) {
        NSLog(@"%@", error);
    }];
}

- (IBAction)openWallet {
    [PNRouter navigatorWalletWithDisplay:DisplayToken];
}

- (IBAction)switchChainClick {
    SwitchChainViewController *vc = [[SwitchChainViewController alloc] init];
    __weak MainViewController *weakSelf = self;
    vc.selectHandler = ^{
        [weakSelf updateUI];
    };
    self.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:vc animated:true completion:nil];
}

- (void)erc20Transfer {
    NSString *contractAddress = @"";
    NSString *to = @"";
    NSString *amount = @"";
    [[ParticleWalletAPI getEvmService] erc20TransferWithContractAddress:contractAddress to:to amount:amount successHandler:^(NSString * result) {
            // handle result
    } failureHandler:^(NSError * error) {
        // handle error
    }];
}


- (void)erc20Approve {
    NSString *contractAddress = @"";
    NSString *spender = @"";
    NSString *amount = @"";
    [[ParticleWalletAPI getEvmService] erc20ApproveWithContractAddress:contractAddress spender:spender amount:amount successHandler:^(NSString * result) {
            // handle result
    } failureHandler:^(NSError * error) {
        // handle error
    }];
}

- (void)erc20TransferFrom {
    NSString *contractAddress = @"";
    NSString *from = @"";
    NSString *to = @"";
    NSString *amount = @"";
    
    [[ParticleWalletAPI getEvmService] erc20TransferFromContractAddress:contractAddress from:from to:to amount:amount successHandler:^(NSString * result) {
            // handle result
    } failureHandler:^(NSError * error) {
        // handle error
    }];
}

- (void)erc721SafeTransferFrom {
    NSString *contractAddress = @"";
    NSString *from = @"";
    NSString *to = @"";
    NSString *tokenId = @"";
    
    [[ParticleWalletAPI getEvmService] erc721SafeTransferFromContractAddress:contractAddress from:from to:to tokenId:tokenId successHandler:^(NSString * result) {
            // handle result
    } failureHandler:^(NSError * error) {
        // handle error
    }];
}

- (void)erc1155SafeTransferFrom {
    NSString *contractAddress = @"";
    NSString *from = @"";
    NSString *to = @"";
    NSString *tokenId = @"";
    NSString *amount = @"";
    NSArray *data = [[NSArray alloc] init];
    
    [[ParticleWalletAPI getEvmService] erc1155SafeTransferFromContractAddress:contractAddress from:from to:to id:tokenId amount:amount data:data successHandler:^(NSString * result) {
        // handle result
    } failureHandler:^(NSError * error) {
        // handle error
    }];
}


- (void)showLogin:(BOOL)isShow {
    self.loginWithEmailButton.hidden = !isShow;
    self.loginWithPhoneButton.hidden = !isShow;
    self.coreImageView.hidden = !isShow;
    
    self.logoutButton.hidden = isShow;
    self.openWalletButton.hidden = isShow;
    self.welcomeImageView.hidden = isShow;
    self.welcomeLabel.hidden = isShow;
}

- (void)updateUI {
    NSString *name = [ParticleNetwork getChainName].nameString;
    NSString *network = [ParticleNetwork getChainName].network;
    
    NSString *title = [NSString stringWithFormat:@"%@ \n %@", name, network];
    [self.switchChainButton setTitle:title forState:UIControlStateNormal];
}



@end
