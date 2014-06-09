package com.gsl.cbs.contraints.enums

/**
 * Created by dell on 5/26/14.
 */
public enum TransactionType {
    CASH_DEPOSIT("Cash Deposit"),
    CHEQUE_DEPOSIT("Cheque Deposit"),
    WITHDRAWAL("Withdrawal"),
    FUND_TRANSFER("Fund Transfer"),

    final String value

    TransactionType(String value) {
        this.value = value
    }

    String toString() { value }

    String getKey() { name() }
}
