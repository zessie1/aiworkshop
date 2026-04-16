/*------------------------------------------------------------------------
  File        : ItemEntity
  Purpose     : Business Entity for Item data access
  Syntax      : 
  Description : 
  Author(s)   : 
  Created     : Wed Apr 16 12:35:00 CEST 2025
  Notes       : 
----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS business.ItemEntity INHERITS BusinessEntity USE-WIDGET-POOL:
    
    /* Include dataset definition */
    {business/ItemDataset.i}
    
    /* Define data sources */
    DEFINE DATA-SOURCE srcItem FOR Item.
    
    /*------------------------------------------------------------------------------
     Purpose: Constructor for ItemEntity
     Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC ItemEntity():
        SUPER(DATASET dsItem:HANDLE).

        VAR HANDLE[1] hDataSourceArray = DATA-SOURCE srcItem:HANDLE.
        VAR CHARACTER[1] cSkipListArray = [""].
        
        /* Data Source for each table in dataset */
        THIS-OBJECT:ProDataSource = hDataSourceArray.
        /* Skip-list entry for each table in dataset */
        THIS-OBJECT:SkipList = cSkipListArray.
    END CONSTRUCTOR.
    
    /*------------------------------------------------------------------------------
     Purpose: Get item by item number
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC LOGICAL GetItemByNumber(INPUT ipiItemNum AS INTEGER,
                                          OUTPUT DATASET dsItem):
        VAR CHARACTER cFilter.
        VAR LOGICAL lFound = FALSE.
        
        /* Build filter for item number */
        cFilter = "WHERE Item.ItemNum = " + STRING(ipiItemNum).
        
        /* Read data using filter */
        THIS-OBJECT:ReadData(cFilter).
    
        /* Check if item was found */
        lFound = CAN-FIND(FIRST ttItem).
        
        RETURN lFound.
    END METHOD.
    
    /*------------------------------------------------------------------------------
     Purpose: Create item data
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CreateItem(INPUT-OUTPUT DATASET dsItem):
        /* Create data in database */
        THIS-OBJECT:CreateData(DATASET dsItem BY-REFERENCE).
    END METHOD.
    
    /*------------------------------------------------------------------------------
     Purpose: Update item data
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID UpdateItem(INPUT-OUTPUT DATASET dsItem):
        /* Update data in database */
        THIS-OBJECT:UpdateData(DATASET dsItem BY-REFERENCE).
    END METHOD.
    
    /*------------------------------------------------------------------------------
     Purpose: Delete item data
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID DeleteItem(INPUT-OUTPUT DATASET dsItem):
        /* Delete data from database */
        THIS-OBJECT:DeleteData(DATASET dsItem BY-REFERENCE).
    END METHOD.
    
    /*------------------------------------------------------------------------------
     Purpose: Validate item data
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC LOGICAL ValidateItem(INPUT-OUTPUT DATASET dsItem,
                                         OUTPUT errorMessage AS CHARACTER):
        VAR LOGICAL isValid = TRUE.
        
        /* Find first item in dataset */
        FIND FIRST ttItem NO-ERROR.
        IF AVAILABLE ttItem THEN DO:
            /* Validate item price */
            IF ttItem.Price = 0 THEN DO:
                isValid = FALSE.
                errorMessage = "Price cannot be empty".
            END.
            
            /* Validate total value on hand */
            IF isValid AND (ttItem.OnHand * ttItem.Price) > 6000 THEN DO:
                isValid = FALSE.
                errorMessage = "Total value onhand should not be larger than 6000".
            END.
        END.
        
        RETURN isValid.
    END METHOD.

END CLASS.
