
import Cocoa

class AccountViewController: NSViewController {
    
    @IBOutlet weak var cmbFromIso: NSComboBox!
    @IBOutlet weak var cmbToIso: NSComboBox!
    @IBOutlet weak var txtFromAmount: NSTextField!
    @IBOutlet weak var gridAccounts: NSTableView!
    @IBOutlet var txtLog: NSTextView!
    
    private var wallet : Wallet = Wallet();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        gridAccounts.delegate = self
        gridAccounts.dataSource = self
    }
    
    @IBAction func btnConfirmClicked(_ sender: Any) {
        
        let fromIso : String = cmbFromIso.stringValue.trimmingCharacters(in: .whitespacesAndNewlines);
        let toIso : String  = cmbToIso.stringValue.trimmingCharacters(in: .whitespacesAndNewlines);
        let fromAmount : String  = txtFromAmount.stringValue.trimmingCharacters(in: .whitespacesAndNewlines);
        
        if fromIso == "" || toIso == "" || fromAmount == "" 
        {
            FormUtils.showAlert(text: "Please, fill in all fields!")
            return;
        }
        
        let value = Double(fromAmount.replacingOccurrences(of: ",", with: ""));
        if value == nil
        {
            FormUtils.showAlert(text: "Invalid amount!")
            return;
        }
        
        let from : Account = getAccount(iso: fromIso);
        let to : Account = getAccount(iso: toIso);
        
        let trans : Transaction = from.transfer(to: to, amount : value!);
        wallet.statement.append(trans);
        
        FormUtils.showAlert(text: "Transaction successfully!\n" + trans.print())
        gridAccounts.reloadData();
        txtLog.string = wallet.printStatement();
        
        cmbFromIso.stringValue = "";
        cmbToIso.stringValue = "";
        txtFromAmount.stringValue = "";
    }
    
    private func getAccount(iso : String) -> Account
    {
        if iso.contains("BRL")
        {
            return wallet.brlAccount;
        }
        else if iso.contains("CAD")
        {
            return wallet.cadAccount;
        }
        else //UAH
        {
            return wallet.uahAccount;
        }
    }
}

extension AccountViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 3;
    }
}

extension AccountViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let CountryCellID = "CountryCellID"
        static let BankCellID = "BankCellID"
        static let IsoCellID = "IsoCellID"
        static let BalanceCellID = "BalanceCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text: String = "";
        var cellIdentifier: String = "";
        
        var item : Account = wallet.brlAccount
        if row == 1
        {
            item = wallet.cadAccount;
        }
        else if row == 2
        {
            item = wallet.uahAccount;
        }
        
        if tableColumn == tableView.tableColumns[0] {
            text = item.country
            cellIdentifier = CellIdentifiers.CountryCellID;
        } else if tableColumn == tableView.tableColumns[1] {
            text = item.bank;
            cellIdentifier = CellIdentifiers.BankCellID;
        } else if tableColumn == tableView.tableColumns[2] {
            let numberFormatter = NumberFormatter();
            numberFormatter.numberStyle = NumberFormatter.Style.currency;
            text = item.iso + " " + numberFormatter.string(from: NSNumber(floatLiteral: item.balance))!;
            cellIdentifier = CellIdentifiers.BalanceCellID;
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        
        return nil
    }
    
}
