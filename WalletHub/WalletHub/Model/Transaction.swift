import Foundation

public class Transaction {
    //Properties ***********************************************************************************
    
    private var _from : Account?;
    private var _to : Account?;
    private var _withdrawAmount : Double = 0;
    private var _depositAmount : Double = 0;
    
    //Constructor *********************************************************************************
    
    init (from : Account, to : Account, withdrawAmount : Double, depositAmount : Double)
    {
        self._withdrawAmount = withdrawAmount;
        self._depositAmount = depositAmount;
        _from = Account(bank: from.bank, country: from.country, iso: from.iso, balance: from.balance);
        _to = Account(bank: to.bank, country: to.country, iso: to.iso, balance: to.balance);
    }
    
    //Methods **************************************************************************************
    
    /*
     * Prints the transaction
     */
    func print () -> String {
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = NumberFormatter.Style.currency;
        
        return "FROM  >>  \(_from!.country), \(_from!.bank), \(_from!.iso) \(numberFormatter.string(from: NSNumber(floatLiteral: _withdrawAmount))!) \r\n" +
               "TO  >>  \(_to!.country), \(_to!.bank), \(_to!.iso) \(numberFormatter.string(from: NSNumber(floatLiteral: _depositAmount))!)";
    }
}
