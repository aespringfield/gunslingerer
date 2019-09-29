module GunslingersHelper
    def create_default_email_address(name)
        # "Sylvia Fowles" becomes "sylvia.fowles@example.com"
        "#{name.downcase.split.join('.')}@example.com"
    end
end