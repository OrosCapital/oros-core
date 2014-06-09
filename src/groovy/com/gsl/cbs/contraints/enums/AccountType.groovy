package com.gsl.cbs.contraints.enums

/**
 * Created by dell on 5/26/14.
 */
public enum AccountType {
    SAVINGS("Savings"),
    CURRENT("Current"),

    final String value

    AccountType(String value) {
        this.value = value
    }

    String toString() { value }

    String getKey() { name() }
}
