import Foundation

public class Wallet
{
    //Properties ***********************************************************************************
    private var _brlAccount : Account;
    var brlAccount: Account {
        get { return self._brlAccount }
    }
    
    private var _cadAccount : Account;
    var cadAccount: Account {
        get { return self._cadAccount }
    }
    
    private var _uahAccount : Account;
    var uahAccount: Account {
        get { return self._uahAccount }
    }
    
    private var _statement : [Transaction];
    var statement: [Transaction] {
        get { return self._statement }
        set(value) {  self._statement = value}
    }
    
    //Constructor *********************************************************************************
    
    init ()
    {
        let initialUSDAmount : Double = 10_000;
        
        _brlAccount = Account(bank: "Santander Bank", country: "Brazil", iso: "BRL", balance: initialUSDAmount * CurrencyUtils.getFactor(from: "USD", to: "BRL"));
        _cadAccount = Account(bank: "TD Bank", country: "Canada", iso: "CAD", balance: initialUSDAmount * CurrencyUtils.getFactor(from: "USD", to: "CAD"));
        _uahAccount = Account(bank: "Privat Bank", country: "Ukraine", iso: "UAH", balance: initialUSDAmount * CurrencyUtils.getFactor(from: "USD", to: "UAH"));
        
        _statement = [Transaction]()
    }
    
    //Methods **************************************************************************************
    
    /*
     * Prints the transaction
     */
    func printStatement () -> String {
        var text = "";
        for t in statement {
            text = text + t.print() + "\r\n--------------------------------------------------------------------------------\r\n";
        }
        return text;
    }
    
}
