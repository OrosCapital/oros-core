package com.gsl.cbs.contraints.enums

/**
 * Created with IntelliJ IDEA.
 * User: gsl
 * Date: 5/29/14
 * Time: 4:02 PM
 * To change this template use File | Settings | File Templates.
 */
public enum DraftType {
    AUTHORIZED("Authorized"),
    NOTAUTHORIZED("Not Authorized"),

    final String value
    DraftType(String value) {
        this.value = value
    }
    String toString() { value }
    String getKey() { name() }
}