/**
 * Main namespace insum toolit.
 *
 * @namespace
 */
 var insumTk = insumTk || {};

 insumTk.freezer = {};

 (function( freezer, $ ) {
     "use strict";


   var C_FREEZE_TPL_OPTION = "jsInsumFreezeColHead",
       SEL_FROZEN_REPORTS = "." + C_FREEZE_TPL_OPTION,
       C_TABLE_HEAD = "table.t-Report-report thead",
       C_TABLE_BODY = "table.t-Report-report tbody",
       C_MAGIC_PADDING = 20; // 10 (10 * 2) is our magic padding number

   freezer.frozenReportSel = function () {
     return SEL_FROZEN_REPORTS;
   };

   /**
    * Set the report width to match that of the container region (region)
    *
    * @param  {Strig|DOM Element} region
    *
    * @function setWidth
    * @memberOf insumTk.freezer
    */
   freezer.setWidth = function (region) {

     var $el=$(region),
         $thead=$el.find(C_TABLE_HEAD),
         $tbody=$el.find(C_TABLE_BODY),
         newWidth=$el.width() - C_MAGIC_PADDING;

     /*
      Set the widths to match the container region.
      This is needed so the scrollLeft values make sense
     */
     $thead.width(newWidth);
     $tbody.width(newWidth);
   };



   /**
    * Freeze the first column and the headers of a Classic Report
    * and start listening for scroll event in order to maintain the frozen column
    * and the headers scrolling in sync
    *
    * @issues
    *  - If you resize the browser by making it larger, the header may fit, but the body may extend.
    *    A possible fix is to re-run the sizes code on head/body after resize.
    *    However, the workaround is to simply reload the page.
    *
    * @param  {Strig|DOM Element} region
    *
    * @function coolReport
    * @memberOf insumTk.freezer
    */
   freezer.coolReport = function (region,options) {

    var options = apex.jQuery.extend({
                    nro_columns: 1,
                    border_header_yn: 'N',
                    border_columns_yn: 'N'
                  }, options);

     var $el=$(region),
         $thead=$el.find(C_TABLE_HEAD),
         $tbody=$el.find(C_TABLE_BODY),
         m=0;

     //console.log("this.action.attribute01",options.nro_columns);
     //console.log("this.action.attribute02",options.border_header_yn);
     //console.log("this.action.attribute03",options.border_columns_yn);

     var nroColumns         = options.nro_columns;
     var setBorderHeader_yn = options.border_header_yn;
     var setBorderColumn_yn = options.border_columns_yn;


     // flag this report with our "Template Option"
     $el.addClass(C_FREEZE_TPL_OPTION);

     /*
      Set the widths to match the container region.
      This is needed so the scrollLeft values make sense
     */
     insumTk.freezer.setWidth(region);


     // Match the header column height, against the next column (which should be sized to the table content)
     $thead.find("th:first-child").each(function(i){
       $(this).css('height',$(this).next().outerHeight());
     });

     var childColumns = "td:nth-child(-n+"+ nroColumns + ")";

     // Match the first column height to the next column (which should be sized to the table content)
     // the first column doesn't know the height of the table cells
     let selector = "tr>"+ childColumns;
     $tbody.find(selector).each(function(i){
       $(this).css('height',$(this).next().outerHeight());
     });

     // Match the header width to the the TD of the first TR (which should be sized to the table content)
     $thead.find("th").each(function(i){
       var thw=$(this).outerWidth(),
           tdw=$tbody.find("tr:first>td:nth-child("+(i+1)+")").outerWidth(),
           w=thw>tdw?thw:tdw; // find the large size between th and td

       // Make both match
       $(this).css({'min-width':w,'max-width':w});
       $tbody.find("tr:first>td:nth-child("+(i+1)+")").css({'min-width':w,'max-width':w});

     });

     // set the class for freeze on the N headers
     let selectorTh = ".jsInsumFreezeColHead table.t-Report-report thead th:nth-child(-n"+nroColumns+")";
     $(selectorTh).addClass("freezeTd");

     // set the class for freeze on the N columns
     let selectorTr = ".jsInsumFreezeColHead table.t-Report-report tbody tr "+childColumns;
     $(selectorTr).addClass("freezeTd");

     // setting the border for headers and columns

     if (setBorderHeader_yn == 'Y') {
       var selectorLastColumns = ".jsInsumFreezeColHead table.t-Report-report thead tr";
       $(selectorLastColumns).addClass("borderBottonColumn");
     }

     if (setBorderColumn_yn == 'Y') {
       var selectorLastColumns = ".jsInsumFreezeColHead table.t-Report-report tbody td:nth-child("+ nroColumns +")";
       $(selectorLastColumns).addClass("borderRightColumn");
     }


     /*
      Based on https://jsfiddle.net/RMarsh/bzuasLcz/3/
     */
     $tbody.scroll(function(e) { //detect a scroll event on the tbody
       /*
       Setting the thead left value to the negative valule of tbody.scrollLeft will make it track the movement
       of the tbody element. Setting an elements left value to that of the tbody.scrollLeft left makes it maintain
       it's relative position at the left of the table.
       */
       $thead.css("left", -$tbody.scrollLeft()); //fix the thead relative to the body scrolling
       //$thead.find('th:nth-child(1)').css("left", $tbody.scrollLeft()); //fix the first cell of the header
       //$tbody.find('td:nth-child(1)').css("left", $tbody.scrollLeft()); //fix the first column of body (this column is "frozen")

       $thead.each(function(i){
         $(this).find('th:lt('+nroColumns+')').css("left",  $tbody.scrollLeft());
       });

       $tbody.find("tr").each(function(i){
         $(this).find('td:lt('+nroColumns+')').css("left",  $tbody.scrollLeft());
       });

     });

   };

 })( insumTk.freezer, apex.jQuery );