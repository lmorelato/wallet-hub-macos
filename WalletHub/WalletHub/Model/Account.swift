import Foundation

public class Account {
    
    //Properties ***********************************************************************************
    
    private var _bank : String  = ""
    var bank: String {
        get { return self._bank }
    }
    
    private var _country: String  = ""
    var country: String {
        get { return self._country }
    }
    
    private var _iso: String  = ""
    var iso: String {
        get { return self._iso }
    }
    
    private var _balance: Double  = 0
    var balance: Double {
        get { return self._balance }
    }
    
    //Constructor *********************************************************************************
    
    init (bank : String, country : String, iso : String, balance : Double)
    {
        self._bank = bank;
        self._country = country;
        self._iso = iso;
        self._balance = balance;
    }
    
    //Methods **************************************************************************************
    
    /*
     * Withdraws money
     */
    func withdraw(amount : Double) -> Void {
        _balance -= amount; 
    }
    
    /*
     * Deposits money
     */
    func deposit(amount : Double) -> Void {
        _balance += amount;
    }
    
    /*
     * Executes the transfer between accounts
     */
    public func transfer(to : Account, amount: Double) -> Transaction {
        withdraw(amount: amount);
        
        let factor : Double = CurrencyUtils.getFactor(from: iso, to: to.iso);
        let depositAmount : Double = amount * factor;
        to.deposit(amount: depositAmount);
        
        let transaction : Transaction = Transaction(from: self, to: to, withdrawAmount: amount, depositAmount: depositAmount);
        return transaction;
    }
        
}

