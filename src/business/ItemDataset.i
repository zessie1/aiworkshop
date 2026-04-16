/* Item Dataset Definition
 * Defines temp-tables and datasets for Item entity data transfer
 * Following Business Entity Architecture Pattern
 */

/* Define temp-table with BEFORE-TABLE for change tracking */
DEFINE TEMP-TABLE ttItem BEFORE-TABLE bttItem
    FIELD ItemNum AS INTEGER INITIAL 0 LABEL "Item Num"
    FIELD Price AS DECIMAL INITIAL 0 FORMAT "->,>>>,>>9.99" LABEL "Price"
    FIELD OnHand AS INTEGER INITIAL 0 LABEL "On Hand"
    FIELD Description AS CHARACTER LABEL "Description"
    INDEX ItemNum IS PRIMARY UNIQUE ItemNum ASCENDING.

/* Define dataset containing temp-table */
DEFINE DATASET dsItem FOR ttItem.