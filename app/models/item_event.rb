# frozen_string_literal: true

# ItemEvent represent a single step in fulfilling a processor item.
#
# Each item (BankStatement, etc.) must perform a list of step/events to complete.
class ItemEvent < ApplicationRecord

  belongs_to :item, polymorphic: true

  # bank statement upload
  TYPE_BANK_STATEMENT_UPLOAD_TRIGGER_REQUESTED_ACTIVITY = 'BankStatementUploadTriggerRequestedActivityEvent'
  TYPE_BANK_STATEMENT_UPLOAD_BANK_ACCOUNT_CREATED       = 'BankStatementUploadBankAccountCreatedEvent'
  TYPE_BANK_STATEMENT_UPLOAD_UPLOADED_TO_ADAPTER        = 'BankStatementUploadUploadedToAdapterEvent'
  TYPE_BANK_STATEMENT_UPLOAD_BANK_ACCOUNT_SYNCED        = 'BankStatementUploadBankAccountSyncedEvent'
  TYPE_BANK_STATEMENT_UPLOAD_TRIGGER_PROCESSED_ACTIVITY = 'BankStatementUploadTriggerProcessedActivityEvent'
  TYPE_BANK_STATEMENT_UPLOAD_BANK_STATEMENT_CREATED     = 'BankStatementUploadBankStatementCreatedEvent'
  TYPE_BANK_STATEMENT_UPLOAD_FILE_SECURED               = 'BankStatementUploadFileSecuredEvent'
  TYPE_BANK_STATEMENT_UPLOAD_FAILED                     = 'BankStatementUploadFailedEvent'
  TYPE_BANK_STATEMENT_UPLOAD_CANCELLING                 = 'BankStatementUploadCancellingEvent'
  TYPE_BANK_STATEMENT_UPLOAD_TRIGGER_CANCELLED_ACTIVITY = 'BankStatementUploadTriggerCancelledActivityEvent'
  TYPE_BANK_STATEMENT_UPLOAD_NOTIFY_FAILED              = 'BankStatementUploadNotifyFailedEvent'
  TYPE_BANK_STATEMENT_UPLOAD_CANCELLED                  = 'BankStatementUploadCancelledEvent'

end
