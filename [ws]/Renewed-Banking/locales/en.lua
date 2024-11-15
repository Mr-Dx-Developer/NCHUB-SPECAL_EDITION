Translations = {
    time = {
        weeks = "%{time} weeks ago",
        aweek = "A week ago",
        days = "%{time} days ago",
        aday = "A day ago",
        hours = "%{time} hours ago",
        ahour = "A hour ago",
        mins = "%{time} minutes ago",
        amin = "A minute ago",
        secs = "A few seconds ago",
    },
    logs = {
        invalid_account = "^6[^4Renewed-Banking^6] ^0 Account not found (%{account})",
        broke_account = "^6[^4Renewed-Banking^6] ^0 Account(%{account}) is too broke with balance of $%{amount}",
        illegal_action = "^6[^4Renewed-Banking^6] ^0 %{name} has attempted to perform an action to an account they didnt create.",
        no_account = "^6[^4Renewed-Banking^6] ^0 %{name} has attempted to perform an action to an account they didnt create.",
        existing_account = "^6[^4Renewed-Banking^6] ^0 Account %{account} already exsist"
    },
    notify = {
        invalid_amount = "Invalid amount to %{type}",
        not_enough_money = "Account does not have enough funds!",
        comp_transaction = "%{name} has %{type} $%{amount}",
        fail_transfer = "Failed to transfer to unknown account!",
        account_taken = "Account ID is already in use",
        unknown_player = "Player with ID '%{id}' could not be found.",
        loading_failed = "Failed to load Banking Data!",
        dead = "Action failed, you're dead ",
        too_far_away = "Action failed, too far away",
        give_cash = "Successfully gave $%{crypto} to ID %{id}",
        received_cash = "Successfully received $%{crypto} from ID %{id}"
    },
    menu = {
        bank_name = "Los Santos Banking",
        view_members = "View All Account Members!",
        no_account = "Account Not Found",
        no_account_txt = "You need to be the creator",
        manage_members = "Manage Account Members",
        manage_members_txt = "View Existing & Add Members",
        edit_acc_name = "Change Account Name",
        edit_acc_name_txt = "Transactions wont update old names",
        remove_member_txt = "Remove Account Member!",
        add_member = "Add Citizen To Account",
        add_member_txt = "Be careful who youu add(Requires Citizen ID)",
        remove_member = "Are you sure you want to remove Citizen?",
        remove_member_txt2 = "CitizenID: %{id}; Their is no going back.",
        back = "Go Back",
        view_bank = "View Bank Account",
        manage_bank = "Manage Bank Account",
        create_account = "Create New Account",
        create_account_txt = "Create a new sub bank account!",
        manage_account = "Manage Existing Accounts",
        manage_account_txt = "View existing accounts!",
        account_id = "Account ID (NO SPACES)",
        change_account_name = "Change Account Name",
        citizen_id = "Citizen/State ID",
        add_account_member = "Add Account Member",
        givecash = "Usage /givecrypto [ID] [AMOUNT]",
    },
    ui = {
        account_title = " Account / ",
        account = " Account ",
        amount = "Amount",
        comment = "Comment",
        transfer = "Business or Citizen ID",
        cancel = "Cancel",
        confirm = "Submit",
        cash = "Cash: $",
        transactions = "Transactions",
        bank_name = "Los Santos Bank",
        select_account = "Select any Account",
        message = "Message",
        accounts = "Accounts",
        balance = "Available Balance",
        frozen = "Account Status: Frozen",
        org = "Organization",
        personal = "Personal",
        personal_acc = "Personal Account / ",
        deposit_but = "Deposit",
        withdraw_but = "Withdraw",
        transfer_but = "Transfer",
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})