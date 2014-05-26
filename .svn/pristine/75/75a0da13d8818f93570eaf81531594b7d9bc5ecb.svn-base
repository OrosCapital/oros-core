package com.gsl.core.banking

/**
 * Created by aminul haque on 5/14/2014.
 */
class CommonUtility {
     public static final int DEFAULT_PAGINATION_START =0
    public static final int DEFAULT_PAGINATION_LENGTH =10
    public static final String DEFAULT_PAGINATION_SORT_ORDER ='asc'
    public static final String DEFAULT_PAGINATION_SORT_COLUMN ='id'
    public static final int DEFAULT_PAGINATION_SORT_IDX =0
    public static final String PERCENTAGE_SIGN ='%'

    public static final String SORT_ORDER_ASC ='asc'
    public static final String SORT_ORDER_DESC ='desc'
    public static final String DEFAULT_BTN_SPAN_CLS ='col-xs-6'

    // utility methods
    public static String editActionBtn(String controllerName, String actionName, def objId, String btnSpanClass = null, String className = ''){
        String actionStr =""
        if(!controllerName || ! actionName || !objId){
           return actionStr
        }

        if(!btnSpanClass){
            btnSpanClass =DEFAULT_BTN_SPAN_CLS
        }
        actionStr = "<sec:access controller='${controllerName}' action='${actionName}'><span class='${btnSpanClass}'><a href='' referenceId='${objId}'class='edit-reference ${className}' title='Edit'> <span class='green glyphicon glyphicon-pencil orange'></span></a></span></sec:access>"
        return actionStr
    }
    public static String deleteActionBtn(String controllerName, String actionName, def objId, String btnSpanClass = null, String className = ''){
        String actionStr =""
        if(!controllerName || ! actionName || !objId){
            return actionStr
        }
        if(!btnSpanClass){
            btnSpanClass =DEFAULT_BTN_SPAN_CLS
        }
        actionStr = "<sec:access controller='${controllerName}' action='${actionName}'><span class='${btnSpanClass}'><a href='' referenceId='${objId}'class='delete-reference ${className}' title='Delete'> <span class='red glyphicon glyphicon-trash'></span></a></span></sec:access>"
        return actionStr
    }
    public static String getSortColumn(String [] sortColumns, int idx){
        if(!sortColumns || sortColumns.length<1)
            return DEFAULT_PAGINATION_SORT_COLUMN
        int columnCounts = sortColumns.length
        if(idx>0 && idx<columnCounts){
            return sortColumns[idx]
        }
        return sortColumns[DEFAULT_PAGINATION_SORT_IDX]
    }
}
