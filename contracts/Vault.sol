// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0 <0.8.20;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol"  ;
// import "@openzeppelin/contracts/utils/math/SafeMath.sol";
// import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
// import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
// import "@uniswap/v3-periphery/contracts/libraries/OracleLibrary.sol";
// import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol' ;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol" ;
import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
import "@uniswap/v3-periphery/contracts/libraries/OracleLibrary.sol";

interface IUniswapV2Router {
  function getAmountsOut(uint amountIn, address[] memory path)
    external
    view
    returns (uint[] memory amounts);

  function swapExactTokensForTokens(
    uint amountIn,
    uint amountOutMin,
    address[] calldata path,
    address to,
    uint deadline
  ) external returns (uint[] memory amounts);

  function swapExactTokensForETH(
    uint amountIn,
    uint amountOutMin,
    address[] calldata path,
    address to,
    uint deadline
  ) external returns (uint[] memory amounts);

  function swapExactETHForTokens(
    uint amountOutMin,
    address[] calldata path,
    address to,
    uint deadline
  ) external payable returns (uint[] memory amounts);

  function addLiquidity(
    address tokenA,
    address tokenB,
    uint amountADesired,
    uint amountBDesired,
    uint amountAMin,
    uint amountBMin,
    address to,
    uint deadline
  )
    external
    returns (
      uint amountA,
      uint amountB,
      uint liquidity
    );

  function removeLiquidity(
    address tokenA,
    address tokenB,
    uint liquidity,
    uint amountAMin,
    uint amountBMin,
    address to,
    uint deadline
  ) external returns (uint amountA, uint amountB);
}
interface IUniswapV2Factory {
  event PairCreated(address indexed token0, address indexed token1, address pair, uint);

  function feeTo() external view returns (address);

  function feeToSetter() external view returns (address);

  function getPair(address tokenA, address tokenB) external view returns (address pair);

  function allPairs(uint) external view returns (address pair);

  function allPairsLength() external view returns (uint);

  function createPair(address tokenA, address tokenB) external returns (address pair);

  function setFeeTo(address) external;

  function setFeeToSetter(address) external;
}


contract Vault
{
    // using SafeMath for uint256;
    
    uint256 DECIMAL_MULTIPLIER = 8 ; 
    struct Info 
    {
        uint256 shares; 
        uint256 initialAmount; 
    }  

    address private constant ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address constant WETH = 0x325f188ce09F94Bd8eA7Bf395019cD146780BA20 ;
    address constant Wmatic = 0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889 ;
   
    // For this example, we will set the pool fee to 0.3%.
    uint24 public constant poolFee = 3000;
    address[] tokensList;
    uint256 initialTotalAmount; 
    uint256 managerBonusTotal; 
    uint256 totalTokenCount = 10 ;
    uint256 totalShares; 
    IERC20 public token;
    uint256 managerShares;
    uint256 unInvestedAmount ;     // nativeToken amount in the vault 

    mapping(address => Info) internal investors;
    mapping(address => bool) internal isInvestor; 
    
    uint256 internal feeManager; 
    uint256 managingBonus; 
    uint256 activationPeriod; 
    uint256 managerFee ;
    address owner;
    address manager ;  
    
    IUniswapV2Router02 public uniswapRouter;
    

    constructor(
        // uint256 _activationPeriod,
        // uint256 _managingBonus,
        // address _tokenAddress,  //address of the token we want to accept investment 
        // uint256 _managerFee,
        // address _routerAddress ,
    
   ) 
    {
        owner = msg.sender;
        token = IERC20(0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889);
        activationPeriod = 9;
        managingBonus = 9; 
        managerFee = 9;
        uniswapRouter = IUniswapV2Router02(ROUTER);
        manager = msg.sender ;
        
    }

     event Deposit(address indexed depositor, uint256 amount , uint256 shares);

     event Withdrawl(address indexed withdrawler , uint256 amount , uint256 shares) ;

     event VaultBalance(address vault , uint256 amount , uint256 shares) ;

     event Isactivate(uint256 time , uint256 totalBalance , uint256 totalShares) ;

     event VaultTokens(uint256 indexed timestamp , address tokens , uint256 disPercent) ;
     
     event ManagerFee( uint256 managerShares , address vault , address Manager ) ;

     function getManagerShares () external view returns(uint256)
     {  
        return managerShares;
    }
    function swapTokens(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint256 _amountOutMin
    ) public  {
        
        address[] memory path = new address[](2);
        path[0] = _tokenIn;
        path[1] = _tokenOut;
        
        uint256 amountRou = 1000000000000000000000000000000000000000000000000 ;
       
        // token.approve(ROUTER, amountRou);
        token.transferFrom( address(this), ROUTER , _amountIn);
        // uint256[] memory result = IUniswapV2Router(ROUTER).swapExactTokensForTokens(_amountIn, 0, path, address(this), block.timestamp + 1000000000000);
        // emit VaultTokens(block.timestamp, _tokenOut , _amountIn);
    }  


    function approveTheToken() external 
    {
        token.approve(ROUTER, 100000000000000000) ;
    }

    function Invest(address  _token, uint256 _amountIn)  external
    {
        //  totalTokenCount = address(this).balance / tokensCount;
      
        // require(totalBalance(address(token)) > totalTokenCount, "insufficient matic balance");
        swapTokens(address(token), _token, _amountIn , 0);

        tokensList.push(_token);
        
        emit VaultTokens(block.timestamp, _token, _amountIn);
    }


    //update the tokens : whole array updates , not a single element 

    function UpdateTokensList (address [] memory tokens ) onlyManager external 
    {
        tokenList = tokens ;
    }



    function calculateShares(uint256 amount) internal returns (uint256)
     {
        uint256 shares;

        if (totalShares == 0) 
        {
            shares = amount;
            totalShares = amount;
        } 
        else {
            shares = (amount * totalShares)**DECIMAL_MULTIPLIER / getFundValue();
            totalShares = shares + totalShares; 
        }

        uint256 managerShareForInvestor = managerFee * shares / 100;

        managerShares = managerShares + managerShareForInvestor;   

        uint256 finalShare = shares - managerShareForInvestor - shares * 2 / 100;

        return finalShare;
    } 
        function calcuateAmount(uint256 shares) internal returns (uint256) 
        {
        uint256 amount = shares.mul(initialTotalAmount).div(investors[msg.sender].shares);
        initialTotalAmount = initialTotalAmount.add(amount); 
        uint256 sharePercent = shares.div(totalShares);
        uint256 maticTokenAmount;
        maticTokenAmount = totalBalance(address(token));

        for (uint256 i = 0; i < tokensList.length; i++) 
        {
            uint256 tokenBalance = totalBalance(tokensList[i]).mul(sharePercent);
        }

        uint256 deltaMaticTokenAmount = totalBalance(address(token)).sub(maticTokenAmount);
        
        if (deltaMaticTokenAmount > investors[msg.sender].initialAmount) 
        {
            uint256 managerBonusAmount = managingBonus.mul(deltaMaticTokenAmount.sub(investors[msg.sender].initialAmount));
            return deltaMaticTokenAmount.sub(managerBonusAmount).sub(2 * (deltaMaticTokenAmount - investors[msg.sender].initialAmount));
        }
        
        return amount;
       }


    function getCurrentFundValue () public view returns(uint256)
    {   
        uint256 totalTokenAmount ; 
        for (uint256 i ; i < 10 ; i ++) 
        {
           uint256 tokenAmount =  getUniPrice(tokensList[i]) ;  // token / usdt pair 
           totalTokenAmount = tokenAmount + totalTokenAmount ;
        }
       return totalTokenAmount; 
    }

    // function getChainlinkPrice(address PriceFeedAddress) public view returns (uint256) 
    // {
    //     require(PriceFeedAddress != address(0), "Price feed not set for token") ;
    //     IPriceFeed priceFeed = IPriceFeed(priceFeedAddress);
    //     (   
    //         , 
    //         int256 price,
    //         ,
    //         uint256 updatedAt,
    //         uint80 answeredInRound
    //     ) = priceFeed.latestRoundData();

        // Ensure the price is not negative and the data is fresh (answeredInRound is the same as the latest roundId)
        // require(price >= 0, "Invalid price data");
        // (uint80 roundId, , , , ) = priceFeed.latestRoundData();
    //     require(answeredInRound == roundId, "Stale price data");

    //     // Optionally, you can check the 'updatedAt' variable to ensure the data is not outdated
    //     require(block.timestamp - updatedAt < 1 hours, "Price data is outdated");

    //     uint8 decimals = priceFeed.decimals();
    //     return uint256(price) * 10**(18 - decimals); // Convert price to have 18 decimals, if necessary
    // }


    function getCurrentBalance () public view returns(uint256)
    { 
      uint256 totalTokenAmount ; 
      for (uint256 i ; i < 10 ; i++)
      {
         uint256 tokenAmount = totalBalanceOf(tokenList[i]) * UniswapPriceFeed(tokenList[i] , UsdTAddress , 1 , 10) ;
         totalTokenAmount = tokenAmount + totalTokenAmount ; 
      }
      return totalTokenAmount ; 
    }

    address public immutable token0;
    address public immutable token1;
    address public immutable pool;

    constructor(
        address _factory,
        address _token0,
        address _token1,
        uint24 _fee
    ) {
        token0 = _token0;
        token1 = _token1;

        address _pool = IUniswapV3Factory(_factory).getPool(
            _token0,
            _token1,
            _fee
        );
        require(_pool != address(0), "pool doesn't exist");

        pool = _pool;
    }

    function estimateAmountOut(
        address tokenIn,
        uint128 amountIn,
        uint32 secondsAgo
    ) external view returns (uint amountOut) {
        require(tokenIn == token0 || tokenIn == token1, "invalid token");

        address tokenOut = tokenIn == token0 ? token1 : token0;

        // (int24 tick, ) = OracleLibrary.consult(pool, secondsAgo);

        // Code copied from OracleLibrary.sol, consult()
        uint32[] memory secondsAgos = new uint32[](2);
        secondsAgos[0] = secondsAgo;
        secondsAgos[1] = 0;

        // int56 since tick * time = int24 * uint32
        // 56 = 24 + 32
        (int56[] memory tickCumulatives, ) = IUniswapV3Pool(pool).observe(
            secondsAgos
        );

        int56 tickCumulativesDelta = tickCumulatives[1] - tickCumulatives[0];

        // int56 / uint32 = int24
        int24 tick = int24(tickCumulativesDelta / secondsAgo);
        // Always round to negative infinity
        /*
        int doesn't round down when it is negative

        int56 a = -3
        -3 / 10 = -3.3333... so round down to -4
        but we get
        a / 10 = -3

        so if tickCumulativeDelta < 0 and division has remainder, then round
        down
        */
        if (
            tickCumulativesDelta < 0 && (tickCumulativesDelta % secondsAgo != 0)
        ) {
            tick--;
        }

        amountOut = OracleLibrary.getQuoteAtTick(
            tick,
            amountIn,
            tokenIn,
            tokenOut
        );
    }

    function transfer() external payable 
    {
     require (msg.value > 0 , "No amount added ") ;
      
     emit Deposit(msg.sender, msg.value, 23524);
    }  

    
        function addInvestor(uint256 _amount) external 
       { 
         require(_amount > 0, "Deposit amount must be greater than 0");
    
         token.transferFrom( msg.sender, address(this) , _amount) ;  //amount = token 

         uint256 shares = calculateShares(_amount);

         initialTotalAmount = initialTotalAmount + _amount ; 

        if (isInvestor[msg.sender] == false) 
            {
            investors[msg.sender].shares = shares ;
            isInvestor[msg.sender] = true; 
            investors[msg.sender].initialAmount = _amount;
        } 
        else 
        {
            investors[msg.sender].shares = investors[msg.sender].shares + shares;
            investors[msg.sender].initialAmount = investors[msg.sender].initialAmount + _amount;
        }

        // addInvestment(amount);
        emit Deposit( msg.sender , _amount , shares ) ;
        emit VaultBalance(address(this), initialTotalAmount, totalShares);
        emit ManagerFee(managerShares , address(this) ,  manager );
    }


    function totalBalanceOf(address _token) public view returns(uint256) 
    {
         return IERC20(_token).balanceOf(address(this));
    }

  //  function totalBalance(address _token) internal returns (uint256) 
  //  {

  //   (bool success, bytes memory data) = _token.call(abi.encodeWithSignature("balanceOf(address)",0xBde318f03764648D02247BF87c20F277c948Da83));
  //   require(success, "Call to balanceOf failed");
  //   // Parse the result
  //   uint256 tokenBalance;
  //   assembly {
  //       tokenBalance := mload(add(data, 32))
  //   }
  //   return tokenBalance;
  //  }

      function withdrawAmount(uint256 _shares) public 
      { 
          
        require(isInvestor[msg.sender] == true, "You don't have any deposited amount in this vault");
        require(_shares <= investors[msg.sender].shares, "Insufficient shares");

        uint256 amount = calcuateAmount(_shares);
        
        investors[msg.sender].shares = investors[msg.sender].shares - _shares; 

        uint256 i = 0 ;
        while( i < 10)
        {  
         uint256 amount = totalBalance(tokensList[i]) ;
        // aduint160(tokensList[i]))).transfer(amount) 
        tokenList[i].transferFrom( address(this) , msg.sender , amount);
         i++ ;
        }
        emit Withdrawl(msg.sender , amount , _shares) ;
        emit VaultBalance(address(this), initialTotalAmount, totalShares);
        emit ManagerFee(managerShares , address(this) ,  manager );
     }

    function returnInfo(address _user) onlyOwner  public returns (uint256, uint256) 
    {
        uint256 shares = investors[_user].shares;
        uint256 amount = investors[_user].initialAmount;
        emit VaultBalance(address(this), initialTotalAmount, totalShares);
        return (shares, amount);
    }


    function claimMaangerFee() onlyManager onlyOwner external 
    {
    require(msg.sender == owner, "You are not the manager");
    uint256 _amount = calcuateAmount(managerShares);
    managerShares = 0;
    token.transfer(msg.sender, _amount); 
    emit VaultBalance(address(this), initialTotalAmount, totalShares);
    }

        modifier onlyOwner ()
    {
        require(msg.sender == owner , "You are not the owner ") ;
         _;
    }

    
    modifier onlyManager ()
    {
        require(msg.sender == manager , "You are not the owner ") ;
         _;
    } 
}
// //issue 
// //what if someone deposits some other tokrn to the contract and gets shares , we have to check 
// //the delta amount of matic everytime and that should be the amount of depoist he has done 



///we have to trnasfer the tokens and coins , we have to spoeciif aboyt it , and the amount of tkokens wre are going got send thear egoing ot be native tokens
// wrapped tokens can be made using the unseapo funcito 



    // function ChnageInvestment(address[] memory oldTokens, address[] memory newTokens) external onlyManager 
    // {
    //     for (uint256 i = 0; i < newTokens.length; i++) 
    //     {
    //         swapTokens(oldTokens[i], newTokens[i], oldTokens[i].balance, 0);
    //         for (uint256 j = 0; j < tokensList.length; j++) {
    //             if (tokensList[j] == oldTokens[i]) {
    //                 tokensList[j] = newTokens[i];
    //             }
    //         }
    //     }
    //     emit VaultTokens(block.timestamp, tokensList, totalTokenCount );
    // }
    
    // function addInvestment(uint256 amount) internal
    // {
    //     uint256 bal = amount / tokensList.length;
    //     for (uint256 i = 0; i < tokensList.length; i++) {
    //         swapTokens(address(token), tokensList[i], bal, 0);
    //     }
    // }


     //     function calculateShares(uint256 amount) internal returns (uint256) {
    //     uint256 shares;
    //     if (totalShares == 0) {
    //         shares = amount;
    //         totalShares = amount;
    //     } else {
    //         shares = amount.mul(totalShares).div(initialTotalAmount);
    //         totalShares = shares.add(totalShares); 
    //     }

    //     uint256 managerShareForInvestor = managerFee.mul(shares).div(100);
    //     managerShares = managerShares.add(managerShareForInvestor);   
    //     uint256 finalShare = shares.sub(managerShareForInvestor).sub(shares.mul(2).div(100));
    //     return finalShare;
    // }

    // // function calcuateAmount(uint256 shares) internal returns (uint256) {
    // //     uint256 amount = shares * initialTotalAmount / investors[msg.sender].shares;
    // //     initialTotalAmount = initialTotalAmount + amount; 
    // //     uint256 sharePercent = shares / totalShares;
    // //     uint256 maticTokenAmount;
    // //     maticTokenAmount = totalBalance(address(token));
    // //     for (uint256 i = 0; i < tokensList.length; i++) {
    // //         swapTokens(tokensList[i], address(token), totalBalance(tokensList[i]) * sharePercent, 0);
    // //     }
    // //     uint256 deltaMaticTokenAmount = totalBalance(address(token)) - maticTokenAmount;
    // //     if (deltaMaticTokenAmount > investors[msg.sender].initialAmount) {
    // //         uint256 managerBonusAmount = managingBonus * (deltaMaticTokenAmount - investors[msg.sender].initialAmount);
    // //         token.transfer(owner, managerBonusAmount);
    // //         token.transfer(protocol, 2 * (deltaMaticTokenAmount - investors[msg.sender].initialAmount));
    // //         return (deltaMaticTokenAmount - managerBonusAmount - 2 * (deltaMaticTokenAmount - investors[msg.sender].initialAmount)); 
    // //     }
    // //     return amount;
    // // }